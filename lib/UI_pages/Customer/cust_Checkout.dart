import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'package:foodie_app/Utilities/utilities_cards.dart';
import 'package:foodie_app/Utilities/utilities_texts.dart';
import '../AddressPicker.dart';
import '../../Utilities/utilities_buttons.dart';
import '../Schemas/Food.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Customer_Page.dart';

class CustomerCheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;

  const CustomerCheckoutPage({required this.selectedItems, Key? key}) : super(key: key);

  @override
  State<CustomerCheckoutPage> createState() => _CustomerCheckoutPageState();
}

class _CustomerCheckoutPageState extends State<CustomerCheckoutPage> {
  bool isLoading = true;
  Map<String, dynamic>? userProfile;
  String? deliveryAddress;
  String? userId;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> chooseNewAddress() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddressPicker()),
    );

    if (result == null) {
      print("No address selected");
      return;
    }

    if (result != null && result is String) {
      setState(() {
        
        deliveryAddress = result;
      });
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      final response = await Supabase.instance.client
        .from('customers')
        .select()
        .eq('id', userId!)
        .single();
      
      setState(() {
        userProfile = response;
        print("User profile: $userProfile");
        userId = response['id'];
        deliveryAddress = response['address'] ?? 'No address set';
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> placeOrder() async {
    try {
      final order = await Supabase.instance.client
        .from('orders')
        .insert({
          'cust_id': userId,
          'delivery_address': deliveryAddress,
          'order_status': 'Pending',
          'order_date': DateTime.now().toIso8601String(),
          'order_total': calculateTotal(),
        })
        .select()
        .single();

      final orderID = order['id'];

      final orderItems = widget.selectedItems.map((item) {
        final product = Food.fromJson(item['products']);
        return {
          'order_id': orderID,
          'product_id': product.id,
          'quantity': item['quantity'],
        };
      }).toList();

      await Supabase.instance.client.from('order_items').insert(orderItems);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order placed!')));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CustomerPage()),
      );
    } catch (e) {
      print('Error placing order: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order. Please try again.'))
      );
    }
  }

  String getFullName() {
    if (userProfile == null) return '';
    final firstName = userProfile!['first_name'] ?? '';
    final middleName = userProfile!['middle_name'] ?? '';
    final lastName = userProfile!['last_name'] ?? '';
    final suffix = userProfile!['suffix'] ?? '';

    return [firstName, middleName, lastName, suffix]
      .where((s) => s.isNotEmpty)
      .join(' ');
  }

  double calculateTotal() {
    return widget.selectedItems.fold(0.0, (sum, item) {
      final product = Food.fromJson(item['products']);
      return sum + (product.price * item['quantity']);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TitleSectionButton(
                leftmost: YellowBackButton(),
                left: Heading4_Text(text: 'Checkout', color: c_pri_yellow)),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
                elevation: 1,
                child: Material(
                  color: c_pri_yellow,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: chooseNewAddress,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Deliver to:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: c_white),
                          ),
                          Text(
                            getFullName(),
                            style: TextStyle(fontSize: 12, color: c_white),
                          ),
                          Text(
                            (deliveryAddress ?? 'No address set').split(',').take(2).join(','),
                            style: TextStyle(fontSize: 10, color: c_white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8),
                itemCount: widget.selectedItems.length,
                itemBuilder: (context, index) {
                  final item = widget.selectedItems[index];
                  final product = Food.fromJson(item['products']);
                  return Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: Image.network(
                                      product.imageUrl ?? '',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: Icon(Icons.image_not_supported),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.product_name,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'P${product.price.toString()}',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'x${item['quantity']}',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 1,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Heading4_Text(text: 'Total:', color: c_pri_yellow),
                          Heading4_Text(
                            text: 'P${calculateTotal().toStringAsFixed(2)}',
                            color: Colors.black
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  ActionButton(
                    buttonName: 'Place Order',
                    backgroundColor: c_pri_yellow,
                    onPressed: () {
                      placeOrder();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'package:foodie_app/Utilities/utilities_cards.dart';
import 'package:foodie_app/Utilities/utilities_texts.dart';
import 'cust_Checkout.dart';
import '../../Utilities/utilities_buttons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerCartPage extends StatefulWidget {
  @override
  State<CustomerCartPage> createState() => _CustomerCartPageState();
}

class _CustomerCartPageState extends State<CustomerCartPage> {
  Set<int> selectedCartItemIds = {};
  List<Map<String, dynamic>> cartItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  void handleSelectionChange(Set<int> newSelectedIds) {
    setState(() {
      selectedCartItemIds = newSelectedIds;
    });
  }

  void handleCartItemsChange(List<Map<String, dynamic>> newCartItems) {
    setState(() {
      cartItems = newCartItems;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TitleSectionButton(
              leftmost: YellowBackButton(), 
              left: Heading4_Text(text: 'Cart', color: c_pri_yellow)),
            Expanded(
              child: CartCards(
                onSelectionChanged: handleSelectionChange,
                onCartItemsChanged: handleCartItemsChange,
              )
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: 
              ActionButton(buttonName: 'Checkout', backgroundColor: c_pri_yellow, 
                onPressed: () { 
                  print('Selected IDs before checkout: $selectedCartItemIds');
                  print('Cart Items before checkout: $cartItems');
                  
                  final selectedItems = selectedCartItemIds.map((id) {
                    final item = cartItems.firstWhere(
                      (item) => item['id'] == id,
                      orElse: () {
                        print('Item not found for ID: $id');
                        return <String, dynamic>{};
                      }
                    );
                    print('Found item for ID $id: $item');
                    return item;
                  }).toList();
                  
                  print('Selected Items for checkout: $selectedItems');

                  if (selectedItems.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select items to checkout'))
                    );
                    return;
                  }

                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => CustomerCheckoutPage(selectedItems: selectedItems))
                  );
                }, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_texts.dart';
import '../../Utilities/utilities_cards.dart';
import '../Schemas/Food.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerFoodTemplate extends StatefulWidget {
  final Food food;

  CustomerFoodTemplate({
    super.key,
    required this.food,
  });

  @override
  State<CustomerFoodTemplate> createState() => _CustomerFoodTemplateState();
}

class _CustomerFoodTemplateState extends State<CustomerFoodTemplate> {
  int quantity = 1;
  double total = 0;

  @override
  void initState() {
    super.initState();
    total = widget.food.price;
  }

  void updateTotal(int newQuantity) {
    setState(() {
      quantity = newQuantity;
      total = widget.food.price * newQuantity;
    });
  }

  Future<void> addToCart() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please login to add items to cart'))
        );
        return;
      }

      await Supabase.instance.client.from('cart_items').insert({
        'cust_id': userId,
        'product_id': widget.food.id,
        'quantity': quantity,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added to cart successfully'))
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add to cart: ${e.toString()}'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.65,
                child: Image.network(
                  widget.food.imageUrl ?? 'lib/images/opening-image.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'lib/images/opening-image.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),

            // Back Button
            Positioned(
              top: 8,
              left: 4,
              child: YellowBackButton(),
            ),
            // Bottom Sheet
            DraggableScrollableSheet(
              initialChildSize: 0.42,
              minChildSize: 0.42,
              maxChildSize: 0.45,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: c_white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Drag Handle
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          // Food Name
                          Heading2_Text(
                            text: widget.food.product_name,
                            color: c_pri_yellow,
                          ),
                          SizedBox(height: 8),
                          // Description Section
                          bodyText(
                            text: widget.food.description,
                            color: Colors.black,
                          ),
                          SizedBox(height: 8),
                          Divider(
                            color: Colors.grey,
                            thickness: .2,
                          ),
                          SizedBox(height: 8),
                          // Price and Quantity Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Heading4_Text(
                                text: 'Total: P${total}',
                                color: Colors.black,
                              ),
                              AddRemoveButton(
                                initialValue: 1,
                                onChanged: updateTotal,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          // Add to Cart Button
                          ActionButton(
                            buttonName: 'Add to Cart',
                            onPressed: addToCart,
                            backgroundColor: c_pri_yellow,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
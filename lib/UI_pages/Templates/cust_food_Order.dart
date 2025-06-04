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
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = 1;
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
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
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
            Positioned(
              top: 8,
              left: 4,
              child: YellowBackButton()
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: c_pri_yellow,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                ),
                margin: EdgeInsets.zero,
                child: Container(
                  decoration: BoxDecoration(
                    color: c_white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                  ),
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Heading2_Text(text: widget.food.product_name, color: c_pri_yellow),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Heading4_Text(text: 'Description', color: c_pri_yellow),
                            bodyText(text: widget.food.description, color: Colors.black),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Heading4_Text(text: 'Total: P${widget.food.price}', color: Colors.black),
                          AddRemoveButton(
                            initialValue: 1,
                            onChanged: (_quantity) {
                              setState(() {
                                quantity = _quantity;
                              });
                            },
                          ),
                        ],
                      ),
                      ActionButton(
                        buttonName: 'Add to Cart', 
                        onPressed: addToCart, 
                        backgroundColor: c_pri_yellow
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
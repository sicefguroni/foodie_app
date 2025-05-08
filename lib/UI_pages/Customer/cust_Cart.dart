import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'package:foodie_app/Utilities/utilities_cards.dart';
import 'package:foodie_app/Utilities/utilities_texts.dart';
import 'cust_Checkout.dart';
import '../../Utilities/utilities_buttons.dart';

class CustomerCartPage extends StatelessWidget {
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
              child: CartCards()
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: 
              ActionButton(buttonName: 'Checkout', backgroundColor: c_pri_yellow, 
                onPressed: () { 
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => CustomerCheckoutPage())
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
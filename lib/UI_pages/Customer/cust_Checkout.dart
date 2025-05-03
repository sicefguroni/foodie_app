import 'package:flutter/material.dart';
import 'package:foodie_app/utilities/color_palette.dart';
import 'package:foodie_app/utilities/utilities_cards.dart';
import 'package:foodie_app/utilities/utilities_texts.dart';
import '../../utilities/utilities_buttons.dart';

class CustomerCheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 1,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: c_pri_yellow,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deliver to:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: c_white),
                      ),
                      Text(
                        'Ceferino Jumao-as V', style: TextStyle(fontSize: 12, color: c_white),
                      ),
                      Text(
                        'UP Cebu, Lahug, Gorordo', style: TextStyle(fontSize: 10, color: c_white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: CheckoutCards()
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8,16),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 1,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Heading4_Text(text: 'Total:', color: c_pri_yellow),
                          Heading4_Text(text: 'P100', color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8), 
                  ActionButton(buttonName: 'Place Order', backgroundColor: c_pri_yellow, 
                    onPressed: () { 
                      Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => CustomerCheckoutPage())
                      );
                    }, fontSize: 16
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
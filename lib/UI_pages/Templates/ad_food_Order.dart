import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_texts.dart';
import '../../Utilities/utilities_cards.dart';

class AdminFoodTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: 
      Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/opening-image.png'),
                  fit: BoxFit.cover,
                )
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 4,
            child: YellowBackButton()),
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
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Heading2_Text(text: 'Foodie Burger', color: c_pri_yellow),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Heading4_Text(text: 'Description', color: c_pri_yellow),
                            bodyText(text: 'This is so yummy yummy yummy yummy and crunchy!', color: Colors.black),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Heading4_Text(text: 'Ingredients', color: c_pri_yellow),
                            SizedBox(height: 4),
                            Container(
                              height: 35,
                              margin: EdgeInsets.zero,
                              child: OrderStatusCards(),
                                
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Heading4_Text(text: 'Total: P100', color: Colors.black),
                          AddRemoveButton(onChanged: (int ) {  },),
                        ],
                      ),
                      ActionButton(buttonName: 'Edit Details', onPressed: () {}, backgroundColor: c_pri_yellow)
                    ],
                  ),
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
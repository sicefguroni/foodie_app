import 'package:flutter/material.dart';
import 'cust_Cart.dart';
import 'package:foodie_app/utilities/color_palette.dart';
import 'package:foodie_app/UI_pages/Templates/account_Profile.dart';
import '../../utilities/utilities_cards.dart';
import '../../utilities/utilities_buttons.dart';
import '../../utilities/utilities_others.dart';
import '../../utilities/utilities_texts.dart';

class CustomerHomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: c_pri_yellow,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TitleSectionButton(
                    leftmost: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: c_white,
                      onPressed: () {
                        Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => CustomerCartPage())
                        );
                      },
                    ),
                    right: IconButton(onPressed: () {}, icon: Icon(Icons.notifications), color: c_white),
                    rightmost: ProfileButton(iconColor: c_white, 
                      onPressed: () {
                        return ProfilePage();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Heading3_Text(text: 'What foodie', color: c_white),
                        Heading3_Text(text: 'would you like?', color: c_white),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                    child: CustomSearchBar(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 0, 4),
              child: Text('Category', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            // Horizontal scrolling cards with fixed height
            Container(
              height: 80,
              child: CategoryCards(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 0, 4),
              child: Text('Picks for you', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            // Vertical scrolling grid that takes remaining space
            Expanded(
              child: AdminFoodCards(),
            ),
          ],
        ),
      ),
    );
  }
}

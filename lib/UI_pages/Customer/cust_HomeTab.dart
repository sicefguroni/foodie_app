import 'package:flutter/material.dart';
import 'cust_Cart.dart';
import 'package:foodie_app/UI_pages/Templates/account_Profile.dart';
import '../../utilities/utilities_cards.dart';
import '../../utilities/utilities_buttons.dart';
import '../../utilities/utilities_others.dart';
import '../../utilities/utilities_texts.dart';

const Color c_green = Color(0xFF00695C);
const Color c_white = Color(0xFFFFFFFF);
const Color c_pri_yellow = Color(0xFFFFA62F);
const Color c_sec_yellow = Color(0xFFFFC96F);
const Color c_background = Color(0xFFFFFBD8);

class CustomerHomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleSectionButton(
              leftmost: IconButton(
                icon: Icon(Icons.shopping_cart),
                color: c_pri_yellow,
                onPressed: () {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => CustomerCartPage())
                  );
                },
              ),
              right: IconButton(onPressed: () {}, icon: Icon(Icons.notifications), color: c_pri_yellow),
              rightmost: ProfileButton(iconColor: c_pri_yellow, 
                onPressed: () {
                  return ProfilePage();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 0, 4),
              child: Heading3_Text(text: 'What foodie would you like?', color: c_pri_yellow),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
              child: CustomSearchBar(),
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
              child: FoodCards(),
            ),
          ],
        ),
      ),
    );
  }
}

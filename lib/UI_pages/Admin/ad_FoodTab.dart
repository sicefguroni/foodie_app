import 'package:flutter/material.dart';
import 'package:foodie_app/UI_pages/Templates/AddFood_Form.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import '../../Utilities/utilities_cards.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_others.dart';
import 'ad_ProfilePage.dart';

class AdminFoodTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleSectionButton(
                  leftmost: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.history),
                    color: c_pri_yellow,
                  ),
                  right: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications),
                    color: c_pri_yellow,
                  ),
                  rightmost: ProfileButton(iconColor: c_pri_yellow, 
                    onPressed: () {
                      return AdminProfilePage();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 4),
                  child: Text('Food Available', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                // Horizontal scrolling cards with fixed height
                Expanded(
                  child: CustomTabBar(
                    tabLabels: ['Mains', 'Appetizers', 'Pastries', 'Beverages'],
                tabContents: [
                  AdminFoodCards(categoryFilter: 'Mains'),
                  AdminFoodCards(categoryFilter: 'Appetizers'),
                  AdminFoodCards(categoryFilter: 'Pastries'),
                  AdminFoodCards(categoryFilter: 'Beverages'),
                  ],
                  )
                ),
              ],
            ),
            Positioned(
              right: 16,
              bottom: 16,
              child: FAButton(
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => AddFoodTemplate())
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

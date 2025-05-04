import 'package:flutter/material.dart';
import 'package:foodie_app/UI_pages/Templates/add_Food.dart';
import 'package:foodie_app/utilities/color_palette.dart';
import 'package:foodie_app/UI_pages/Templates/account_Profile.dart';
import '../../utilities/utilities_cards.dart';
import '../../utilities/utilities_buttons.dart';

class AdminIngredientsTab extends StatelessWidget {
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
                      return ProfilePage();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 4),
                  child: Text('Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                // Horizontal scrolling cards with fixed height
                Container(
                  height: 80,
                  child: CategoryCards(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 0, 4),
                  child: Text('All Ingredients', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                // Vertical scrolling grid that takes remaining space
                Expanded(
                  child: AdminIngredientCards(),
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

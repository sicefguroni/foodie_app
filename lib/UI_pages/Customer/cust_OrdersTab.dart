import 'package:flutter/material.dart';
import 'package:foodie_app/utilities/color_palette.dart';
import 'package:foodie_app/UI_pages/Templates/account_Profile.dart';
import 'cust_Cart.dart';
import '../../utilities/utilities_buttons.dart';
import '../../utilities/utilities_others.dart';

class CustomerOrdersTab extends StatelessWidget {
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
              rightmost: ProfileButton(
                iconColor: c_pri_yellow, 
                onPressed: () {
                  return ProfilePage();
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 0, 4),
              child: Text('My Orders', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            // Horizontal scrolling cards with fixed height
            Expanded(
              child: CustomTabBar(),
            ),
          ],
        ),
      ),
    );
  }
}

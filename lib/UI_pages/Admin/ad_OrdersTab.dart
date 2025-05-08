import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'package:foodie_app/UI_pages/Templates/account_Profile.dart';
import '../../Utilities/utilities_cards.dart';
import '../../Utilities/utilities_buttons.dart';

class AdminOrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleSectionButton(
              leftmost: IconButton(
                onPressed: () {},
                icon: Icon(Icons.history),
                color: c_pri_yellow,
              ),
              left: IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete),
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
              child: Text('Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            // Horizontal scrolling cards with fixed height
            Container(
              height: 35,
              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: OrderStatusCards(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 0, 4),
              child: Text('Customer Orders', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            // Vertical scrolling grid that takes remaining space
            Expanded(
              child: AdminOrdersCards(),
            ),
          ],
        ),
      ),
    );
  }
}

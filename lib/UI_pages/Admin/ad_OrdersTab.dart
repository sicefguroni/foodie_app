import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import '../../Utilities/utilities_cards.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_others.dart';
import 'ad_ProfilePage.dart';
import 'ad_DeniedTab.dart';

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
                icon: Icon(Icons.delete),
                color: c_pri_yellow,
                onPressed: () {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => AdDeniedOrdersTab())
                  );
                },
              ),
              right: IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications),
                color: c_pri_yellow,
              ),
              rightmost: ProfileButton(
                iconColor: c_pri_yellow,
                onPressed: () {
                  return AdminProfilePage();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
              child: Text('Customer Orders',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            // Vertical scrolling grid that takes remaining space
            Expanded(
              child: CustomTabBar(
                tabLabels: ['Pending', 'Accepted', 'To Deliver', 'Completed'],
                tabContents: [
                  AdminOrdersCards(statusFilter: 'Pending'),
                  AdminOrdersCards(statusFilter: 'Accepted'),
                  AdminOrdersCards(statusFilter: 'To Deliver'),
                  AdminOrdersCards(statusFilter: 'Completed'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

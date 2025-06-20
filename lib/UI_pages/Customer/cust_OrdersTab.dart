import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'cust_ProfilePage.dart';
import 'cust_Cart.dart';
import '../../Utilities/utilities_cards.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_others.dart';

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
                  return CustomerProfilePage();
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 0, 4),
              child: Text('My Orders', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            // Horizontal scrolling cards with fixed height
            Expanded(
              child: CustomTabBar(
                tabLabels: ['Pending', 'Accepted', 'To Deliver', 'Completed'],
                tabContents: [
                  CustomerOrdersCards(statusFilter: 'Pending'),
                  CustomerOrdersCards(statusFilter: 'Accepted'),
                  CustomerOrdersCards(statusFilter: 'To Deliver'),
                  CustomerOrdersCards(statusFilter: 'Completed'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

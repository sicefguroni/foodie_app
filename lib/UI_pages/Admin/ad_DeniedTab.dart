import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import '../Customer/cust_ProfilePage.dart';
import '../Customer/cust_Cart.dart';
import '../../Utilities/utilities_cards.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_others.dart';

class AdDeniedOrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                YellowBackButton(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 4),
                  child: Text('Denied Orders', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            // Horizontal scrolling cards with fixed height
            Expanded(
              child: CustomTabBar(
                tabLabels: ['Denied'],
                tabContents: [
                  AdminOrdersCards(statusFilter: 'Denied'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

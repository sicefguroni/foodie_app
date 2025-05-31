import 'package:flutter/material.dart';
import 'package:foodie_app/UI_pages/Opening/AdminSignIn_Route.dart';
import 'package:foodie_app/UI_pages/Opening/CustomerSignIn_Route.dart';
import '../Customer/Customer_Page.dart';
import '../Admin/Admin_Page.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_others.dart';

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TitlewithImage(
            title: 'Foodie',
            image: 'lib/images/opening-image.png',
          ),
          const SizedBox(height: 75),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                NormalButton(
                  buttonName: 'Customer',
                  fontColor: c_pri_yellow,
                  backgroundColor: c_white,
                  outlineColor: c_pri_yellow,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CustomerSignInRoute()),
                    );
                  },
                ),
                const SizedBox(height: 24), // Add spacing between buttons
                NormalButton(
                  buttonName: 'Admin',
                  fontColor: c_white,
                  backgroundColor: c_pri_yellow,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminSignInRoute()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

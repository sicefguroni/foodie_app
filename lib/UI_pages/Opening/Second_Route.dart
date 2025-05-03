import 'package:flutter/material.dart';
import 'package:foodie_app/utilities/color_palette.dart';
import '../../utilities/utilities_buttons.dart';
import '../../utilities/utilities_others.dart';
import '../Customer/Customer_Page.dart';
import '../Admin/Admin_Page.dart';


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
            margin: const EdgeInsets.all(1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NormalButton(
                  buttonName: 'Customer',
                  fontColor: c_pri_yellow,
                  backgroundColor: c_white,
                  outlineColor: c_pri_yellow,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CustomerPage()),
                    );
                  },
                ),
                const SizedBox(height: 20), // Add spacing between buttons
                NormalButton(
                  buttonName: 'Admin',
                  fontColor: c_white,
                  backgroundColor: c_pri_yellow,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminPage()),
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

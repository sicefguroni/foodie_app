import 'package:flutter/material.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_texts.dart';
import '../../Utilities/utilities_others.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'Second_Route.dart';

class FirstRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'lib/images/foodie_1st_bg.png',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Center(
                child: TitleText(title: 'Foodie', color: c_pri_yellow),
              )
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 16,
              child: ActionButton(
                buttonName: 'Order Now',
                backgroundColor: c_pri_yellow,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondRoute()),
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
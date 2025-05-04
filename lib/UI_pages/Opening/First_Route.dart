import 'package:flutter/material.dart';
import '../../utilities/utilities_buttons.dart';
import '../../utilities/utilities_texts.dart';
import '../../utilities/utilities_others.dart';
import 'package:foodie_app/utilities/color_palette.dart';
import 'Second_Route.dart';

class FirstRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
            children: [
              TitlewithImage(title: 'Foodie', 
                image: 'lib/images/opening-image.png'),
            const SizedBox(height: 25),
            Container(
              width: double.infinity,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Heading2_Text(text: 'Good Food\nGoodie Life', color: c_pri_yellow),
                  const SizedBox(height: 25),
                  const bodyText(
                    text:
                        'Enjoy our delicious, appetizing, crunchy, aromatic, tender, and savory food with affordable prices!',
                    color: c_pri_yellow
                  ),
                  const SizedBox(height: 30),
                  ActionButton(
                    buttonName: 'Order Now',
                    backgroundColor: c_pri_yellow,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
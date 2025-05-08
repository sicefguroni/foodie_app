import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import '../Utilities/utilities_buttons.dart';
import '../Utilities/utilities_texts.dart';
import '../UI_pages/Admin/Admin_Page.dart';

class SignInRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
            children: [
              TitleText(title: 'Foodie', color: c_pri_yellow),
              Heading3_Text(text: 'Welcome back!', color: c_pri_yellow),
              bodyText(text: 'Sign in your account', color: c_pri_yellow),
              const SizedBox(height: 75),
              Container(
                width: double.infinity,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [  
                        InputTextField(
                          hintText: 'Username'
                        ),
                        const SizedBox(height: 25),
                        InputTextField(
                          hintText: 'Password'
                        ),
                        const SizedBox(height: 25),
                        ActionButton(
                          buttonName: 'Sign In',
                          backgroundColor: c_pri_yellow,
                          onPressed: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AdminPage()));
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
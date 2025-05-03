import 'package:flutter/material.dart';
import '../utilities/utilities_buttons.dart';
import '../utilities/utilities_texts.dart';
import '../UI_pages/Opening/Second_Route.dart';

const Color c_green = Color(0xFF00695C);
const Color c_white = Color(0xFFFFFFFF);
const Color c_pri_yellow = Color(0xFFFFA62F);
const Color c_sec_yellow = Color(0xFFFFC96F);
const Color c_background = Color(0xFFFFFBD8);

class SignUpRoute_1st extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.0, left: 16.0),
                child: YellowBackButton(),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Column(
                  children: [
                    TitleText(title: 'Foodie', color: c_pri_yellow),
                    Heading3_Text(text: 'Welcome!', color: c_pri_yellow),
                    bodyText(text: 'Create your account', color: c_pri_yellow),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [  
                        InputTextField(
                          hintText: 'Name'
                        ),
                        const SizedBox(height: 25),
                        InputTextField(
                          hintText: 'Phone Number'
                        ),
                        const SizedBox(height: 25),
                        InputTextField(
                          hintText: 'Email (optional)'
                        ),
                        const SizedBox(height: 25),
                        ActionButton(
                          buttonName: 'Next',
                          backgroundColor: c_pri_yellow,
                          onPressed: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignUpRoute_2nd()));
                          },
                          fontSize: 12,
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


class SignUpRoute_2nd extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.0, left: 16.0),
                child: YellowBackButton(),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Column(
                  children: [
                    TitleText(title: 'Foodie', color: c_pri_yellow),
                    Heading3_Text(text: 'Welcome!', color: c_pri_yellow),
                    bodyText(text: 'Create your account', color: c_pri_yellow),
                  ],
                ),
              ),
              const SizedBox(height: 25),
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
                        InputTextField(
                          hintText: 'Confirm Password'
                        ),
                        const SizedBox(height: 25),
                        ActionButton(
                          buttonName: 'Sign Up',
                          backgroundColor: c_pri_yellow,
                          onPressed: () {
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SecondRoute()));
                          },
                          fontSize: 12,
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


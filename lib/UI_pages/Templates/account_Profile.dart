import 'package:flutter/material.dart';
import 'package:foodie_app/utilities/color_palette.dart';
import '../../utilities/utilities_buttons.dart';
import '../../utilities/utilities_others.dart';
import '../../utilities/utilities_texts.dart';
import '../Opening/Second_Route.dart';

class ProfilePage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return 
      Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: c_pri_yellow,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                ),
                margin: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [  
                    TitleSectionButton(
                      leftmost: WhiteBackButton(),
                      left: Heading4_Text(text: 'Profile', color: c_white),
                      rightmost: IconButton(onPressed: () {}, icon: Icon(Icons.edit), color: c_white),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomerAvatar(assetName: 'lib/images/opening-image.png', radius: 40),
                          Heading4_Text(text: 'KarlGwapo123', color: c_white),
                          bodyText(text: 'User', color: c_white),
                        ],
                      ),
                    ),
                  ],
                )
              ),
              Expanded(
                child: Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bodyText(text: 'Name', color: c_pri_yellow),
                              SizedBox(height: 4),
                              TextField(
                                readOnly: true,
                                controller: TextEditingController(text: 'Cef'),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: c_sec_yellow),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: c_pri_yellow),
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bodyText(text: 'Email', color: c_pri_yellow),
                              SizedBox(height: 4),
                              TextField(
                                readOnly: true,
                                controller: TextEditingController(text: 'Cef@gmail.com'),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: c_sec_yellow),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: c_pri_yellow),
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bodyText(text: 'Phone Number', color: c_pri_yellow),
                              SizedBox(height: 4),
                              TextField(
                                readOnly: true,
                                controller: TextEditingController(text: '0922'),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: c_sec_yellow),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: c_pri_yellow),
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    NormalButton(buttonName: 'Logout', fontColor: c_pri_yellow, backgroundColor: c_white, outlineColor: c_pri_yellow, 
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SecondRoute())
                        );
                      }, 
                    ),
                  ],
                ),
              ),
              ),
            ],
          ),
        ),
      );
  }
}
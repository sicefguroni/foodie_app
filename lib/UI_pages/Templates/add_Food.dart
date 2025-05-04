import 'package:flutter/material.dart';
import 'package:foodie_app/utilities/color_palette.dart';
import 'package:foodie_app/utilities/utilities_texts.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../utilities/utilities_buttons.dart';

class AddFoodTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            TitleSectionButton(
              leftmost: YellowBackButton(), 
              left: Heading4_Text(text: 'Add Food', color: c_pri_yellow)
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: DottedBorder(
                  color: c_pri_yellow,
                  dashPattern: const [6, 3],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 32), // add spacing
                    alignment: Alignment.center, // ensure the container centers content
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // hug content vertically
                      mainAxisAlignment: MainAxisAlignment.center, // center vertically
                      crossAxisAlignment: CrossAxisAlignment.center, // center horizontally
                      children: [
                        Icon(Icons.image, size: 32, color: c_pri_yellow),
                        bodyText(text: 'Upload Image', color: c_pri_yellow),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bodyText(text: 'Name', color: c_pri_yellow),
                          SizedBox(height: 4),
                          TextField(
                            decoration: InputDecoration(
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
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bodyText(text: 'Description', color: c_pri_yellow),
                          SizedBox(height: 4),
                          TextField(
                            decoration: InputDecoration(
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
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bodyText(text: 'Ingredients', color: c_pri_yellow),
                          SizedBox(height: 4),
                          TextField(
                            decoration: InputDecoration(
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
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bodyText(text: 'Price', color: c_pri_yellow),
                              SizedBox(height: 4),
                              TextField(
                                style: TextStyle(fontSize: 16),
                                decoration: InputDecoration(
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
                        SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bodyText(text: 'Quantity', color: c_pri_yellow),
                              SizedBox(height: 4),
                              TextField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: c_sec_yellow),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: c_pri_yellow),
                                  )
                                ),
                              ),
                            ]
                          ),
                        ),
                      ],
                    ),
                    ActionButton(buttonName: 'Add Food', backgroundColor: c_pri_yellow, 
                        onPressed: () { 
                    },)
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
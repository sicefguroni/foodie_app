import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'package:foodie_app/Utilities/utilities_others.dart';
import 'package:foodie_app/Utilities/utilities_texts.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../Utilities/utilities_buttons.dart';

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
            //ImageUploader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      SizedBox(height: 12),
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
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bodyText(text: 'Category', color: c_pri_yellow),
                                  SizedBox(height: 4),
                                  //DropdownMenuCategories(),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                bodyText(text: 'Quantity', color: c_pri_yellow),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: AddRemoveButton(onChanged: (int) {}),
                                ),
                              ]
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      IngredientsInputSection(),
                      SizedBox(height: 12),
                      Column(
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
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ActionButton(buttonName: 'Add Food', backgroundColor: c_pri_yellow, 
                onPressed: () { 
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
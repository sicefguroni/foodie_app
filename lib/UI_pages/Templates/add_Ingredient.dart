import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'package:foodie_app/Utilities/utilities_others.dart';
import 'package:foodie_app/Utilities/utilities_texts.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../Utilities/utilities_buttons.dart';

class AddIngredientTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            TitleSectionButton(
              leftmost: YellowBackButton(), 
              left: Heading4_Text(text: 'Add Ingredient', color: c_pri_yellow)
            ),
            SizedBox(height: 8),
            ImageUploader(),
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
                          bodyText(text: 'Measurement by', color: c_pri_yellow),
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
                          flex: 2,
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                bodyText(text: 'Category', color: c_pri_yellow),
                                SizedBox(height: 4),
                                DropdownMenuCategories(),
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
                    ActionButton(buttonName: 'Add Ingredient', backgroundColor: c_pri_yellow, 
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
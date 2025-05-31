import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'package:foodie_app/Utilities/utilities_others.dart';
import 'package:foodie_app/Utilities/utilities_texts.dart';
import '../../Utilities/utilities_buttons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Schemas/Ingredient.dart';

class AddIngredientTemplate extends StatefulWidget {
  @override
  State<AddIngredientTemplate> createState() => _AddIngredientTemplateState();
}

class _AddIngredientTemplateState extends State<AddIngredientTemplate> {
  final nameController = TextEditingController();
  final unitController = TextEditingController();
  DropdownCategory? _selectedCategory;
  late int quantity;
  String? _imageUrl;

  Future<void> _submit() async {

    await Supabase.instance.client.from('ingredients').insert({
      'id': DateTime.now().millisecondsSinceEpoch,
      'name': nameController.text,
      'unit': unitController.text,
      'category': _selectedCategory?.categoryName,
      'quantity': quantity,
      'image_url': _imageUrl,
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ingredient added!")));
  }

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
            ImageUploader(
              onImageUploaded: (url) {
                setState(() {
                  _imageUrl = url;
                });
              },
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
                            controller: nameController,
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
                            controller: unitController,
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
                                DropdownMenuCategories(
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedCategory = value;
                                    });
                                  },
                                ),
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
                                child: AddRemoveButton(onChanged: (_quantity) {
                                  setState(() {
                                    quantity = _quantity;
                                  });
                                }),
                              ),
                            ]
                          ),
                        ),
                      ],
                    ),
                    ActionButton(buttonName: 'Add Ingredient', backgroundColor: c_pri_yellow, 
                        onPressed: () { 
                          _submit();
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

class EditIngredientTemplate extends StatefulWidget {
  final Ingredient ingredient;

  EditIngredientTemplate({super.key, required this.ingredient});
  
  @override
  State<EditIngredientTemplate> createState() => _EditIngredientTemplateState();
}

class _EditIngredientTemplateState extends State<EditIngredientTemplate> {
  late TextEditingController nameController;
  late TextEditingController unitController;
  late int quantity;
  String? _selectedCategory;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.ingredient.name);
    unitController = TextEditingController(text: widget.ingredient.unit);
    quantity = widget.ingredient.quantity;
    _selectedCategory = widget.ingredient.category;
    _imageUrl = widget.ingredient.imageUrl;
  }
  
  Future<void> updateIngredient() async {
    final id = widget.ingredient.id;

    await Supabase.instance.client.from('ingredients').update({
      'name': nameController.text,
      'unit': unitController.text,
      'category': _selectedCategory,
      'quantity': quantity,
      'image_url': _imageUrl,
    })
    .eq('id', id);

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ingredient updated!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            TitleSectionButton(
              leftmost: YellowBackButton(), 
              left: Heading4_Text(text: 'Edit Ingredient', color: c_pri_yellow)
            ),
            SizedBox(height: 8),
            ImageUploader(
              initialImageUrl: _imageUrl,
              onImageUploaded: (url) {
                setState(() {
                  _imageUrl = url;
                });
              },
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
                            controller: nameController,
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
                            controller: unitController,
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
                                DropdownMenuCategories(
                                  initialValue: _selectedCategory,
                                  onChanged: (DropdownCategory? newValue) {
                                    setState(() {
                                      _selectedCategory = newValue?.categoryName;
                                    });
                                  },
                                ),
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
                                child: AddRemoveButton(onChanged: (_quantity) {
                                  setState(() {
                                    quantity = _quantity;
                                  });
                                }),
                              ),
                            ]
                          ),
                        ),
                      ],
                    ),
                    ActionButton(buttonName: 'Save Changes', backgroundColor: c_pri_yellow, 
                        onPressed: () { 
                          updateIngredient();
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
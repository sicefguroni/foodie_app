import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'package:foodie_app/Utilities/utilities_others.dart';
import 'package:foodie_app/Utilities/utilities_texts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Utilities/utilities_buttons.dart';
import '../Schemas/Ingredient.dart';
import '../Schemas/Food.dart';

class AddFoodTemplate extends StatefulWidget {
  @override
  State<AddFoodTemplate> createState() => _AddFoodTemplateState();
}

class _AddFoodTemplateState extends State<AddFoodTemplate> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  List<Ingredient> _availableIngredients = [];
  List<IngredientWithQuantity> _selectedIngredients = [];
  DropdownCategory? _selectedCategory;
  late int quantity;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _loadIngredients();
    _selectedCategory = foodCategories[0];
  }

  Future<void> _loadIngredients() async {
    final response = await Supabase.instance.client
      .from('ingredients')
      .select();
    final data = response as List;
    final ingredients = data.map((json) => Ingredient.fromJson(json)).toList();

    setState(() {
      _availableIngredients = ingredients;
    });
  }

  Future<void> _addFood() async {
    final name = nameController.text.trim();
    final desc = descriptionController.text.trim();
    final price = double.tryParse(priceController.text.trim()) ?? 0;

    if (name.isEmpty || _selectedCategory == null || _imageUrl == null || _selectedIngredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all required fields.')));
      return;
    }

    // Validate that we have enough ingredients in stock
    for (final fi in _selectedIngredients) {
      final ingredient = _availableIngredients.firstWhere((ing) => ing.id == fi.ingredient.id);
      if (ingredient.quantity < fi.quantity) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Not enough ${ingredient.name} in stock. Available: ${ingredient.quantity}'))
        );
        return;
      }
    }

    try {
      // insert into food table
      final productInsert = await Supabase.instance.client.from('products').insert({
        'product_name': name,
        'description': desc,
        'category': _selectedCategory?.categoryName,
        'image_url': _imageUr
        'price': price,
        'quantity': quantity,
        'availability': true,
      }).select().single();

      final productID = productInsert['id'];
      // insert into food_ingredients and update stock
      for (final fi in _selectedIngredients) {
        await Supabase.instance.client.from('recipes').insert({
          'product_ID': productID,
          'ingredient_ID': fi.ingredient.id,
          'quantity': fi.quantity,
        });

        // decrement ingredient stock
        final ingredient = _availableIngredients.firstWhere((ing) => ing.id == fi.ingredient.id);
        final newQuantity = ingredient.quantity - fi.quantity;
        if (newQuantity >= 0) {
          await Supabase.instance.client.from('ingredients').update({
            'quantity': newQuantity
          }).eq('id', fi.ingredient.id);
        } else {
          throw Exception('Not enough ${ingredient.name} in stock');
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Food added successfully')));
      Navigator.pop(context); 

    } catch (e, stack) {
      print('Error adding food: $e');
      print(stack);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add food: ${e.toString()}')));
    }
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
              left: Heading4_Text(text: 'Add Food', color: c_pri_yellow)
            ),
            SizedBox(height: 8),
            ImageUploader(
              bucketName: 'food-images',
              onImageUploaded: (url) {
                setState(() {
                  _imageUrl = url;
                });
              },
            ),
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
                      SizedBox(height: 12),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            bodyText(text: 'Description', color: c_pri_yellow),
                            SizedBox(height: 4),
                            TextField(
                              controller: descriptionController,
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
                                  DropdownMenuCategories<DropdownCategory>(
                                    items: foodCategories,
                                    initialValue: _selectedCategory,
                                    getLabel: (cat) => cat.categoryName,
                                    onChanged: (DropdownCategory? value) {
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
                      SizedBox(height: 12),
                      IngredientDropdownSection(
                        ingredientOptions: _availableIngredients,
                        selectedIngredients: [],
                        onChanged: (List<IngredientWithQuantity> selected) {
                          _selectedIngredients = selected;
                        },
                      ),
                      SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bodyText(text: 'Price', color: c_pri_yellow),
                          SizedBox(height: 4),
                          TextField(
                            controller: priceController,
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
                onPressed: _addFood,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EditFoodTemplate extends StatefulWidget {
  final Food food;

  EditFoodTemplate({super.key, required this.food});

  @override
  State<EditFoodTemplate> createState() => _EditFoodTemplateState();
}

class _EditFoodTemplateState extends State<EditFoodTemplate> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late int quantity;
  String? _selectedCategory;
  late DropdownCategory matchedCategory;
  List<Ingredient> _availableIngredients = [];
  List<IngredientWithQuantity> _selectedIngredients = [];
  String? _imageUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.food.product_name);
    descriptionController = TextEditingController(text: widget.food.description);
    priceController = TextEditingController(text: widget.food.price.toString());
    quantity = widget.food.quantity;
    _selectedCategory = widget.food.category;
    _imageUrl = widget.food.imageUrl;
    matchedCategory = foodCategories.firstWhere(
      (cat) => cat.categoryName == _selectedCategory,
      orElse: () => foodCategories[0],
    );
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Load both data sets in parallel
      final results = await Future.wait([
        Supabase.instance.client
          .from('ingredients')
          .select()
          .order('name'),
        Supabase.instance.client
          .from('recipes')
          .select('ingredient_ID, quantity, ingredients(*)')
          .eq('product_ID', widget.food.id)
      ]);

      setState(() {
        _availableIngredients = (results[0] as List)
          .map((e) => Ingredient.fromJson(e))
          .toList();

        _selectedIngredients = (results[1] as List)
          .map((data) {
            final ingData = data['ingredients'];
            if (ingData == null) return null;
            return IngredientWithQuantity(
              ingredient: Ingredient(
                id: ingData['id'],
                name: ingData['name'],
                unit: ingData['unit'],
                category: ingData['category'],
                quantity: ingData['quantity'],
                imageUrl: ingData['image_url'],
              ),
              quantity: data['quantity'] ?? 0,
            );
          })
          .where((item) => item != null)
          .cast<IngredientWithQuantity>()
          .toList();

        _isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data: ${e.toString()}'))
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  void updateFood() async {
    try {
      await Supabase.instance.client.from('products').update({
        'product_name': nameController.text,
        'description': descriptionController.text,
        'price': double.tryParse(priceController.text) ?? 0,
        'category': _selectedCategory,
        'quantity': quantity,
        'image_url': _imageUrl,
      }).eq('id', widget.food.id);
      
      // Delete old ingredients
      await Supabase.instance.client
          .from('recipes')
          .delete()
          .eq('product_ID', widget.food.id);

      // Insert updated ingredients
      for (final fi in _selectedIngredients) {
        await Supabase.instance.client.from('recipes').insert({
          'product_ID': widget.food.id,
          'ingredient_ID': fi.ingredient.id,
          'quantity': fi.quantity,
        });
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Food updated successfully')));
      Navigator.pop(context);
    } catch (e) {
      print('Update failed: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update food')));
    }
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
              left: Heading4_Text(text: 'Edit Food', color: c_pri_yellow)
            ),
            SizedBox(height: 8),
            ImageUploader(
              bucketName: 'food-images',
              initialImageUrl: _imageUrl,
              onImageUploaded: (url) {
                setState(() {
                  _imageUrl = url;
                });
              },
            ),
            if (_isLoading)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: c_pri_yellow,
                  ),
                ),
              )
            else
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
                        SizedBox(height: 12),
                        Padding(
                          padding: EdgeInsets.zero,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bodyText(text: 'Description', color: c_pri_yellow),
                              SizedBox(height: 4),
                              TextField(
                                controller: descriptionController,
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
                                    DropdownMenuCategories<DropdownCategory>(
                                      items: foodCategories,
                                      initialValue: matchedCategory,
                                      getLabel: (cat) => cat.categoryName,
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
                                    child: AddRemoveButton(
                                      initialValue: quantity,
                                      onChanged: (_quantity) {
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
                        SizedBox(height: 12),
                        IngredientDropdownSection(
                          ingredientOptions: _availableIngredients,
                          selectedIngredients: _selectedIngredients,
                          onChanged: (List<IngredientWithQuantity> selected) {
                            _selectedIngredients = selected;
                          },
                        ),
                        SizedBox(height: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            bodyText(text: 'Price', color: c_pri_yellow),
                            SizedBox(height: 4),
                            TextField(
                              controller: priceController,
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
              child: ActionButton(buttonName: 'Save Changes', backgroundColor: c_pri_yellow, 
                onPressed: updateFood,
              ),
            )
          ],
        ),
      ),
    );
  }
}
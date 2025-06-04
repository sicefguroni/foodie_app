import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'package:foodie_app/Utilities/utilities_others.dart';
import 'package:foodie_app/Utilities/utilities_texts.dart';
import '../../Utilities/utilities_buttons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Schemas/Ingredient.dart';

class AddIngredientTemplate extends StatefulWidget {
  const AddIngredientTemplate({super.key});
  @override
  State<AddIngredientTemplate> createState() => _AddIngredientTemplateState();
}

class _AddIngredientTemplateState extends State<AddIngredientTemplate> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final unitController = TextEditingController();
  DropdownCategory? _selectedCategory;
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    _selectedCategory = ingredientCategories[0];
  }

  Future<void> _addIngredient() async {
    if (_formKey.currentState!.validate()) {
      final nameToCheck = nameController.text.trim();

      try {
        // Query Supabase to check if ingredient name already exists
        final existing = await Supabase.instance.client
            .from('ingredients')
            .select('name')
            .eq('name', nameToCheck)
            .maybeSingle();

        if (existing != null) {
          // Ingredient with this name already exists
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ingredient already exists.")),
          );
          return; // Don't proceed
        }

        // If not exists, insert new ingredient
        await Supabase.instance.client.from('ingredients').insert({
          'name': nameToCheck,
          'unit': unitController.text.trim(),
          'category': _selectedCategory?.categoryName,
          'quantity': quantity,
        });

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ingredient added!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add ingredient: $e")),
        );
      }
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
              left: Heading4_Text(text: 'Add Ingredient', color: c_pri_yellow),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bodyText(text: 'Name', color: c_pri_yellow),
                          const SizedBox(height: 4),
                          TextFormField(
                            controller: nameController,
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Name is required'
                                    : null,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: c_sec_yellow)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: c_pri_yellow)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          bodyText(text: 'Measurement by', color: c_pri_yellow),
                          const SizedBox(height: 4),
                          TextFormField(
                            controller: unitController,
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Measurement is required'
                                    : null,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: c_sec_yellow)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: c_pri_yellow)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    bodyText(
                                        text: 'Category', color: c_pri_yellow),
                                    const SizedBox(height: 4),
                                    DropdownMenuCategories<DropdownCategory>(
                                      items: ingredientCategories,
                                      initialValue: _selectedCategory,
                                      getLabel: (cat) => cat.categoryName,
                                      onChanged: (value) => setState(
                                          () => _selectedCategory = value),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    bodyText(
                                        text: 'Quantity', color: c_pri_yellow),
                                    const SizedBox(height: 8),
                                    AddRemoveButton(
                                      initialValue: quantity,
                                      onChanged: (val) =>
                                          setState(() => quantity = val),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ActionButton(
                        buttonName: 'Add Ingredient',
                        backgroundColor: c_pri_yellow,
                        onPressed: _addIngredient,
                      ),
                    ],
                  ),
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
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController unitController;
  late int quantity;
  DropdownCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.ingredient.name);
    unitController = TextEditingController(text: widget.ingredient.unit);
    quantity = widget.ingredient.quantity.toInt();

    _selectedCategory = ingredientCategories.firstWhere(
      (cat) => cat.categoryName == widget.ingredient.category,
      orElse: () => ingredientCategories[0],
    );
  }

  Future<void> _updateIngredient() async {
    if (_formKey.currentState!.validate()) {
      try {
        await Supabase.instance.client.from('ingredients').upsert(
          {
            'name': nameController.text.trim(),
            'unit': unitController.text.trim(),
            'category': _selectedCategory?.categoryName,
            'quantity': quantity,
          },
          onConflict: 'name',
        );
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ingredient updated!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update ingredient: $e")),
        );
      }
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
              left: Heading4_Text(text: 'Edit Ingredient', color: c_pri_yellow),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bodyText(text: 'Name', color: c_pri_yellow),
                          const SizedBox(height: 4),
                          TextFormField(
                            controller: nameController,
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Name is required'
                                    : null,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: c_sec_yellow)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: c_pri_yellow)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          bodyText(text: 'Measurement by', color: c_pri_yellow),
                          const SizedBox(height: 4),
                          TextFormField(
                            controller: unitController,
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Measurement is required'
                                    : null,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: c_sec_yellow)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: c_pri_yellow)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    bodyText(
                                        text: 'Category', color: c_pri_yellow),
                                    const SizedBox(height: 4),
                                    DropdownMenuCategories<DropdownCategory>(
                                      items: ingredientCategories,
                                      initialValue: _selectedCategory,
                                      getLabel: (cat) => cat.categoryName,
                                      onChanged: (newValue) => setState(() {
                                        _selectedCategory = newValue;
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    bodyText(
                                        text: 'Quantity', color: c_pri_yellow),
                                    const SizedBox(height: 8),
                                    AddRemoveButton(
                                      initialValue: quantity,
                                      onChanged: (val) =>
                                          setState(() => quantity = val),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ActionButton(
                        buttonName: 'Save Changes',
                        backgroundColor: c_pri_yellow,
                        onPressed: _updateIngredient,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

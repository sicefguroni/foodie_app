import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/UI_pages/Schemas/Ingredient.dart';
import 'package:foodie_app/Utilities/utilities_buttons.dart';
import 'utilities_texts.dart';
import 'utilities_cards.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IngredientQuantityInput extends StatelessWidget {
  final List<Ingredient> ingredientOptions;
  final Ingredient? selectedIngredient;
  final String? quantity;
  final Function(Ingredient?) onIngredientChanged;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const IngredientQuantityInput({
    super.key,
    required this.ingredientOptions,
    required this.selectedIngredient,
    required this.quantity,
    required this.onIngredientChanged,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // Filter out any duplicate ingredients based on ID
    final uniqueIngredients = ingredientOptions.toSet().toList();
    
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: DropdownButtonFormField<Ingredient>(
            value: selectedIngredient,
            items: uniqueIngredients.map((ingredient) {
              return DropdownMenuItem<Ingredient>(
                value: ingredient,
                child: Text(
                  ingredient.name,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: onIngredientChanged,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: c_sec_yellow),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: c_sec_yellow),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: c_pri_yellow),
              ),
            ),
            isExpanded: true,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AddRemoveButton(
                initialValue: int.tryParse(quantity ?? '0') ?? 0,
                onChanged: onQuantityChanged
              ),
              IconButton(
                onPressed: onRemove, 
                icon: Icon(Icons.remove_circle),
                color: c_pri_yellow,
                constraints: BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class IngredientDropdownSection extends StatefulWidget {
  final List<Ingredient> ingredientOptions;
  final List<IngredientWithQuantity> selectedIngredients;
  final Function(List<IngredientWithQuantity>) onChanged;

  const IngredientDropdownSection({
    super.key,
    required this.ingredientOptions,
    required this.selectedIngredients,
    required this.onChanged,
  });

  @override
  State<IngredientDropdownSection> createState() => _IngredientDropdownSectionState();
}

class _IngredientDropdownSectionState extends State<IngredientDropdownSection> {
  List<Map<String, Object?>> ingredients = [];

  @override
  void initState() {
    super.initState();
    _initializeIngredients();
  }

  @override
  void didUpdateWidget(IngredientDropdownSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIngredients != widget.selectedIngredients) {
      _initializeIngredients();
    }
  }

  void _initializeIngredients() {
    setState(() {
      ingredients = widget.selectedIngredients.map((iwq) => {
        'ingredient': iwq.ingredient as Object?,
        'quantity': iwq.quantity.toString() as Object?,
      }).toList();
    });
  }

  void _addIngredientField() {
    setState(() {
      ingredients.add({
        'ingredient': null as Object?,
        'quantity': '0' as Object?,
      });
    });
    widget.onChanged(_notifyParent());
  }

  void _removeIngredientField(int index) {
    setState(() {
      ingredients.removeAt(index);
    });
    widget.onChanged(_notifyParent());
  }

  void _updateIngredient(int index, Ingredient? ingredient) {
    setState(() {
      ingredients[index]['ingredient'] = ingredient as Object?;
    });
    widget.onChanged(_notifyParent());
  }

  void _updateQuantity(int index, String quantity) {
    setState(() {
      ingredients[index]['quantity'] = quantity as Object?;
    });
    widget.onChanged(_notifyParent());
  }

  List<IngredientWithQuantity> _notifyParent() {
    return ingredients
      .where((e) => e['ingredient'] != null && (e['quantity'] as String).isNotEmpty)
      .map((e) {
        final ingredient = e['ingredient'] as Ingredient;
        return IngredientWithQuantity(
          ingredient: ingredient,
          quantity: int.tryParse(e['quantity'] as String) ?? 0,
        );
      }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        bodyText(text: 'Ingredients', color: c_pri_yellow),
        ...ingredients.asMap().entries.map((entry) { 
          int index = entry.key;
          Map<String, Object?> data = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: IngredientQuantityInput(
              ingredientOptions: widget.ingredientOptions, 
              selectedIngredient: data['ingredient'] as Ingredient?, 
              quantity: data['quantity'] as String?, 
              onIngredientChanged: (ingredient) => _updateIngredient(index, ingredient), 
              onQuantityChanged: (value) => _updateQuantity(index, value.toString()), 
              onRemove: () => _removeIngredientField(index)
            ),
          );
        }),
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: _addIngredientField,
            icon: Icon(Icons.add),
            iconSize: 16,
            color: c_pri_yellow,
            constraints: BoxConstraints(maxHeight: 32, maxWidth: 32),
          ),
        ),
      ],
    );
  }
}

final List<DropdownCategory> ingredientCategories = [
  DropdownCategory(categoryName: 'Protein'),
  DropdownCategory(categoryName: 'Vegetables'),
  DropdownCategory(categoryName: 'Baking Essentials'),
  DropdownCategory(categoryName: 'Liquids'),
  DropdownCategory(categoryName: 'Condiments'),
];

final List<DropdownCategory> foodCategories = [
  DropdownCategory(categoryName: 'Mains'),
  DropdownCategory(categoryName: 'Appetizers'),
  DropdownCategory(categoryName: 'Pastries'),
  DropdownCategory(categoryName: 'Beverages'),
];

class DropdownCategory {
  final String categoryName;
  
  DropdownCategory({required this.categoryName});
}

class DropdownMenuCategories<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) getLabel;
  final Function(T?) onChanged;
  final T? initialValue;

  const DropdownMenuCategories({
    super.key, 
    required this.items,
    required this.getLabel,
    required this.onChanged, 
    this.initialValue, 
  });

  @override
  State<DropdownMenuCategories> createState() => _DropdownMenuCategoriesState<T>();
}

class _DropdownMenuCategoriesState<T> extends State<DropdownMenuCategories<T>> {
  T? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      initialSelection: selectedCategory,
      onSelected: (value) {
        setState(() {
          selectedCategory = value;
        });
        widget.onChanged(value);
      },
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: c_sec_yellow, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: c_sec_yellow, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: c_sec_yellow, width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      dropdownMenuEntries: widget.items.map((item) {
        return DropdownMenuEntry<T>(
          value: item,
          label: widget.getLabel(item),
          style: ButtonStyle(
            maximumSize: WidgetStatePropertyAll(Size(double.infinity, double.infinity))
          )
        );
      }).toList(),
    );
  }
}

class ImageUploader extends StatefulWidget {
  final Function(String) onImageUploaded;
  final String? initialImageUrl;
  final String bucketName;

  const ImageUploader({super.key, required this.onImageUploaded, this.initialImageUrl, required this.bucketName});

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? _image;
  String? _uploadedImageUrl;
  bool _hasRemovedImage = false;

  @override
  void initState() {
    super.initState();
    _uploadedImageUrl = widget.initialImageUrl;
  }

  Future<void> _pickImage(dynamic imageSource) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileName = '${DateTime.now().millisecondsSinceEpoch}-${pickedFile.name}';
  
      try {
        final storageResponse = await Supabase.instance.client.storage
            .from(widget.bucketName) // bucket name
            .upload(fileName, file);
        
        if (storageResponse.isNotEmpty) {
          final imageUrl = Supabase.instance.client.storage
              .from(widget.bucketName)
              .getPublicUrl(fileName);
        
          setState(() {
            _image = file;
            _uploadedImageUrl = imageUrl;
            _hasRemovedImage = false;
          });
        
          // Notify parent widget
          widget.onImageUploaded(imageUrl);
        } 
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload image')),
        );
      }
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
      _uploadedImageUrl = null;
      _hasRemovedImage = true;
    });
    widget.onImageUploaded('');
  }

  @override
  Widget build(BuildContext context) {
    final showNetworkImage = _uploadedImageUrl != null && !_hasRemovedImage && _image == null;

    return GestureDetector(
      onTap: () => _pickImage(ImageSource.gallery),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: (_image != null || showNetworkImage) ? 
        Stack(
          children: [
            SizedBox(
              height: 180,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _image != null ? Image.file(
                  _image!,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                ) 
                : Image.network(_uploadedImageUrl!, width: double.infinity, fit: BoxFit.fitHeight)
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: _removeImage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: c_white, size: 20),
                ),
              ),
            )
          ],
        ) : DottedBorder(
          color: c_pri_yellow,
          dashPattern: const [6, 3],
          borderType: BorderType.RRect,
          radius: const Radius.circular(16),
          child: SizedBox(
            height: 180,
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 32, color: c_pri_yellow),
                  bodyText(text: 'Upload Image', color: c_pri_yellow),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}

class TitlewithImage extends StatelessWidget {
  final String title;
  final String image;

  const TitlewithImage({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.50,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned(
            top: 25,
            child: TitleText(title: title, color: c_pri_yellow),
          ),
        ],
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(image, width: double.infinity, height: 300, fit: BoxFit.cover);
  }
}


class CustomerAvatar extends StatelessWidget {
  const CustomerAvatar({super.key, required this.assetName, required this.radius});

  final String assetName;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[300],
      child: ClipOval(
        child: Image.network(
          assetName ?? '', 
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.person, size: radius, color: Colors.grey[600]);
          },
        ),
      )
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SizedBox(
          height: 40,
          child: SearchBar(
            elevation: MaterialStateProperty.all(0.5),
            controller: controller,
            backgroundColor: MaterialStateProperty.all(c_white),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 8)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            onTap: () {
              controller.openView();
            },
            trailing: [
              Icon(Icons.search, color: c_pri_yellow),
            ],
          ),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return [
          ListTile(
            title: Text('Suggestion 1'),
            onTap: () {
              controller.closeView('Suggestion 1');
            },
          ),
          ListTile(
            title: Text('Suggestion 2'),
            onTap: () {
              controller.closeView('Suggestion 2');
            },
          ),
        ];
      },
    );
  }
}

class CustomTabBar extends StatelessWidget {
  final List<String> tabLabels;
  final List<Widget> tabContents;
  final double fontSize;
  final Color indicatorColor;
  final Color textColor;

  const CustomTabBar({
    super.key,
    required this.tabLabels,
    required this.tabContents,
    this.fontSize = 12,
    this.indicatorColor = c_pri_yellow,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabLabels.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            isScrollable: true,
            indicatorColor: indicatorColor,
            tabAlignment: TabAlignment.start,
            labelColor: textColor,
            splashBorderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            tabs: tabLabels.map((label) => 
              Text(label, style: TextStyle(fontSize: fontSize))
            ).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: tabContents,
            ),
          ),
        ],
      ),
    );
  }
}

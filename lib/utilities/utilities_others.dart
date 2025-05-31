import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/utilities_buttons.dart';
import 'utilities_texts.dart';
import 'utilities_cards.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IngredientsInputSection extends StatefulWidget {
  const IngredientsInputSection({super.key});

  @override
  State<IngredientsInputSection> createState() => _IngredientsInputSectionState();
}

class _IngredientsInputSectionState extends State<IngredientsInputSection> {
  List<TextEditingController> _ingredientControllers = [];

  void _addIngredientField() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  @override
  void dispose() {
    for (var controller in _ingredientControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bodyText(text: 'Ingredients', color: c_pri_yellow),
          ..._ingredientControllers.map((controller) => Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: c_sec_yellow),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: c_pri_yellow),
                      )
                    ),
                  ),
                ),
                SizedBox(width: 40),
                Expanded(
                  flex: 1,
                  child: AddRemoveButton(onChanged: (int) {  },)),
              ],
            ),
            ),
          ),
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
      ),
    );
  }
}

final List<DropdownCategory> _dropdownCategories = [
  DropdownCategory(categoryName: 'Pending'),
  DropdownCategory(categoryName: 'Accepted'),
  DropdownCategory(categoryName: 'Preparing '),
  DropdownCategory(categoryName: 'Completed'),
  DropdownCategory(categoryName: 'Cancelled'),
];

class DropdownCategory {
  final String categoryName;
  
  DropdownCategory({required this.categoryName});
}

class DropdownMenuCategories extends StatefulWidget {
  final Function(DropdownCategory?) onChanged;
  final String? initialValue;

  const DropdownMenuCategories({super.key, required this.onChanged, this.initialValue});

  @override
  State<DropdownMenuCategories> createState() => _DropdownMenuCategoriesState();
}

class _DropdownMenuCategoriesState extends State<DropdownMenuCategories> {
  DropdownCategory? selectedCategory;

  @override
  void initState() {
    super.initState();
    // If editing, set the initial selection from the passed initialValue
    if (widget.initialValue != null) {
      selectedCategory = _dropdownCategories.firstWhere(
        (cat) => cat.categoryName == widget.initialValue,
        orElse: () => _dropdownCategories.first,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<DropdownCategory>(
      initialSelection: selectedCategory,
      onSelected: (value) {
        setState(() {
          selectedCategory = value;
        });
        widget.onChanged(value);
      },
      dropdownMenuEntries: _dropdownCategories.map((category) {
        return DropdownMenuEntry<DropdownCategory>(
          value: category,
          label: category.categoryName,
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

  const ImageUploader({super.key, required this.onImageUploaded, this.initialImageUrl});

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
            .from('ingredient-images') // bucket name
            .upload(fileName, file);
        
        if (storageResponse.isNotEmpty) {
          final imageUrl = Supabase.instance.client.storage
              .from('ingredient-images')
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
      backgroundImage: AssetImage(assetName),
      radius: radius,
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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            isScrollable: true,
            indicatorColor: c_pri_yellow,
            tabAlignment: TabAlignment.start,
            splashBorderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            tabs: [
              Text('Pending', style: TextStyle(fontSize: 12)),
              Text('Accepted', style: TextStyle(fontSize: 12)),
              Text('Preparing', style: TextStyle(fontSize: 12)),
              Text('To Deliver', style: TextStyle(fontSize: 12)),
              Text('Completed', style: TextStyle(fontSize: 12)),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                CheckoutCards(),
                CheckoutCards(),
                CheckoutCards(),
                CheckoutCards(),
                CheckoutCards(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

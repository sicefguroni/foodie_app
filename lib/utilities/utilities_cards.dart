import 'package:flutter/material.dart';
import 'package:foodie_app/utilities/color_palette.dart';
import 'utilities_others.dart';
import '../UI_pages/Templates/food_Order.dart';

final List<Category> _categories = [
  Category(assetName: 'lib/images/opening-image.png', name: 'Vegetables', status: 'Available', detail: 'By kilo', isSelected: false),
  Category(assetName: 'lib/images/opening-image.png', name: 'Vegetables', status: 'Available', detail: 'By kilo', isSelected: false),
  Category(assetName: 'lib/images/opening-image.png', name: 'Vegetables', status: 'Available', detail: 'By kilo', isSelected: false),
  Category(assetName: 'lib/images/opening-image.png', name: 'Vegetables', status: 'Available', detail: 'By kilo', isSelected: false),
  Category(assetName: 'lib/images/opening-image.png', name: 'Vegetables', status: 'Available', detail: 'By kilo', isSelected: false),
  Category(assetName: 'lib/images/opening-image.png', name: 'Vegetables', status: 'Available', detail: 'By kilo', isSelected: false),
  Category(assetName: 'lib/images/opening-image.png', name: 'Vegetables', status: 'Available', detail: 'By kilo', isSelected: false),
  Category(assetName: 'lib/images/opening-image.png', name: 'Vegetables', status: 'Available', detail: 'By kilo', isSelected: false),
];

class Category {
  final String assetName;
  final String name;
  final String status;
  final String detail;
  bool isSelected;
  
  Category({required this.assetName, required this.name, required this.status, required this.detail, this.isSelected = false});
}

class FoodCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .9,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      padding: EdgeInsets.all(8),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        return FoodCard(category: _categories[index]);
      },
    );
  }
}

class FoodCard extends StatefulWidget {
  final Category category;

  const FoodCard({
    required this.category, 
    Key? key,
  }) : super(key: key);
  
  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.04;
    double subtitleFontSize = screenWidth * 0.04;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FoodTemplate())
          );
        },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(widget.category.assetName, fit: BoxFit.cover),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 4, 0, 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      widget.category.name,
                      style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: titleFontSize),
                    ),
                    Text(
                      widget.category.status,
                      style: TextStyle(fontFamily: 'Inter', fontSize: subtitleFontSize),
                    ),
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}

class CategoryCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _categories.length,
      padding: EdgeInsets.symmetric(horizontal: 8),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: CategoryCard(category: _categories[index]),
        );
      },
    );
  }
}

class CategoryCard extends StatefulWidget {
  final Category category;

  const CategoryCard({
    required this.category, 
    Key? key,
  }) : super(key: key);
  
  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image container
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset(
                widget.category.assetName,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Name text below the container
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              widget.category.name,
              style: const TextStyle(fontFamily: 'Inter', fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}


// class IngredientCards extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: _categories.length,
//       padding: EdgeInsets.symmetric(horizontal: 8),
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 4),
//           child: IngredientCard(category: _categories[index]),
//         );
//       },
//     );
//   }
// }

class IngredientCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      childAspectRatio: 3.5,
      mainAxisSpacing: 2,
      ), 
      padding: EdgeInsets.all(8),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        return IngredientCard(category: _categories[index]);
      }
    );
  }
}

class IngredientCard extends StatefulWidget {
  final Category category;

  const IngredientCard({
    required this.category, 
    Key? key,
  }) : super(key: key);
   
  @override
  State<IngredientCard> createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.2;
    double titleFontSize = screenWidth * 0.045;
    double subtitleFontSize = screenWidth * 0.04;
    double quantityBoxSize = screenWidth * 0.06;
    double iconButtonSize = screenWidth * 0.05;


    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(4, 2, 0, 2), // Add the required padding
            child: Row(// Image container
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    width: imageWidth,
                    child: Image.asset(
                      widget.category.assetName,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Name text below the container
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.category.name,
                        style: TextStyle(fontFamily: 'Inter', fontSize: titleFontSize),
                      ),
                      Text(
                        widget.category.detail,
                        style: TextStyle(fontFamily: 'Inter', fontSize: subtitleFontSize),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 4, 0), // Add the required padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {}, icon: Icon(Icons.remove), iconSize: iconButtonSize
                  ),
                Card.outlined(
                  borderOnForeground: true,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: c_pri_yellow,
                      width: 1,
                    ),
                  ),
                  child: SizedBox(
                    width: quantityBoxSize,
                    child: Text(
                      '00',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: subtitleFontSize),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {}, icon: Icon(Icons.add), iconSize: iconButtonSize
                  
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 

class CartCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      childAspectRatio: 3,

      ), 
      padding: EdgeInsets.symmetric(horizontal: 8),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        return CartCard(category: _categories[index], index: index);
      }
    );
  }
}

class CartCard extends StatefulWidget {
  final Category category;
  final int index;

  const CartCard({
    required this.category, 
    required this.index,
    Key? key,
  }) : super(key: key);
   
  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.25;
    double titleFontSize = screenWidth * 0.045;
    double subtitleFontSize = screenWidth * 0.04;
    double quantityBoxSize = screenWidth * 0.06;
    double iconButtonSize = screenWidth * 0.04;

    bool isAllSelected = false;

    void toggleSelectAll() {
    setState(() {
      isAllSelected = !isAllSelected;
      for (var category in _categories) {
        category.isSelected = isAllSelected;
      }
      });
    }

    void toggleSelection() {
      setState(() {
        _categories[widget.index].isSelected = !_categories[widget.index].isSelected;
        isAllSelected = _categories.every((category) => category.isSelected);
      }
      );
    }

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(4, 2, 0, 2), // Add the required padding
            child: Row(// Image container
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    width: imageWidth,
                    child: Image.asset(
                      widget.category.assetName,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Name text below the container
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 12, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.category.name,
                        style: TextStyle(fontFamily: 'Inter', fontSize: titleFontSize),
                      ),
                      Text(
                        widget.category.detail,
                        style: TextStyle(fontFamily: 'Inter', fontSize: subtitleFontSize),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 4, 4, 4), // Add the required padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Checkbox(value: widget.category.isSelected, onChanged: (_) => toggleSelection()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {}, icon: Icon(Icons.remove), iconSize: iconButtonSize,
                      constraints: BoxConstraints(minWidth: 24,maxWidth: 32, minHeight: 24, maxHeight: 32),
                      ),
                    Card.outlined(
                      borderOnForeground: true,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: c_pri_yellow,
                          width: 1,
                        ),
                      ),
                      child: SizedBox(
                        width: quantityBoxSize,
                        child: Text(
                          '00',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: subtitleFontSize),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {}, icon: Icon(Icons.add), iconSize: iconButtonSize,
                      constraints: BoxConstraints(minWidth: 24,maxWidth: 32, minHeight: 24, maxHeight: 32),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 

class CheckoutCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      childAspectRatio: 3,

      ), 
      padding: EdgeInsets.symmetric(horizontal: 8),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        return CheckoutCard(category: _categories[index], index: index);
      }
    );
  }
}

class CheckoutCard extends StatefulWidget {
  final Category category;
  final int index;

  const CheckoutCard({
    required this.category, 
    required this.index,
    Key? key,
  }) : super(key: key);
   
  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.25;
    double titleFontSize = screenWidth * 0.045;
    double subtitleFontSize = screenWidth * 0.04;
    double quantityBoxSize = screenWidth * 0.06;
    double iconButtonSize = screenWidth * 0.04;

    bool isAllSelected = false;

    void toggleSelection() {
      setState(() {
        _categories[widget.index].isSelected = !_categories[widget.index].isSelected;
        isAllSelected = _categories.every((category) => category.isSelected);
      }
      );
    }

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(4, 2, 0, 2), // Add the required padding
            child: Row(// Image container
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    width: imageWidth,
                    child: Image.asset(
                      widget.category.assetName,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Name text below the container
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 12, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.category.name,
                        style: TextStyle(fontFamily: 'Inter', fontSize: titleFontSize),
                      ),
                      Text(
                        widget.category.detail,
                        style: TextStyle(fontFamily: 'Inter', fontSize: subtitleFontSize),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 12, 8), // Add the required padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('x1', style: TextStyle(fontFamily: 'Inter', fontSize: subtitleFontSize)),
                Text('P100', style: TextStyle(fontFamily: 'Inter', fontSize: titleFontSize)),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 

// class AvatarCards extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: _categories.length,
//       padding: EdgeInsets.symmetric(horizontal: 8),
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 4),
//           child: AvatarCard(category: _categories[index]),
//         );
//       },
//     );
//   }
// }

class AvatarCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2.8,
        mainAxisSpacing: 2,
      ),
      padding: EdgeInsets.all(8),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        return AvatarCard(category: _categories[index]);
      },
    );
  }
}

class AvatarCard extends StatefulWidget {
  final Category category;

  const AvatarCard({
    required this.category, 
    Key? key,
  }) : super(key: key);
  
  @override
  State<AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> {
  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double avatarRadius = screenWidth * .12;
    double titleFontSize = screenWidth * 0.04;
    double descriptionFontSize = screenWidth * 0.038;
    double buttonFontSize = screenWidth * 0.035;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(2,2,8,2),
          margin: EdgeInsets.zero,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: CustomerAvatar(
                  assetName: widget.category.assetName,
                  radius: avatarRadius,
                ),
              ),
              Expanded(
                child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                    child: Text(widget.category.name, style: TextStyle(fontSize: titleFontSize)),
                  ),
                  Padding(    
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 7),
                    child: Text(widget.category.status, style: TextStyle(fontSize: descriptionFontSize)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child:
                      ElevatedButton(onPressed: () {}, child: Text('Accept'), 
                        style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: buttonFontSize))),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: 
                      ElevatedButton(onPressed: () {}, child: Text('Deny'), 
                        style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: buttonFontSize))),
                      ),
                    ],
                  ),
                ],
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 

final List<Status> _statuses = [
  Status(statusName: 'Pending'),
  Status(statusName: 'Accepted'),
  Status(statusName: 'Preparing'),
  Status(statusName: 'Completed'),
  Status(statusName: 'Cancelled'),
];

class Status {
  final String statusName;
  
  Status({required this.statusName});
}

class StatusCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _statuses.length,
     
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: StatusCard(status: _statuses[index]),
        );
      },
    );
  }
}

class StatusCard extends StatefulWidget {
  final Status status;

  const StatusCard({
    required this.status, 
    Key? key,
  }) : super(key: key);
  
  @override
  State<StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
      child: Text(widget.status.statusName, style: TextStyle(fontSize: 12)),
    );
  }
}

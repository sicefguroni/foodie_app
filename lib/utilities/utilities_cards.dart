import 'package:flutter/material.dart';
import 'package:foodie_app/UI_pages/Templates/ad_food_Order.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'package:foodie_app/Utilities/utilities_buttons.dart';
import 'utilities_others.dart';
import '../UI_pages/Templates/cust_food_Order.dart';


// SAMPLE CARD INPUTS
// SAMPLE CARD INPUTS
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

// FOUND IN ad_IngredientsTab 
// FOUND IN ad_IngredientsTab 
class IngredientCategoryCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _categories.length,
      padding: EdgeInsets.symmetric(horizontal: 8),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: IngredientCategoryCard(category: _categories[index]),
        );
      },
    );
  }
}

class IngredientCategoryCard extends StatefulWidget {
  final Category category;

  const IngredientCategoryCard({
    required this.category, 
    Key? key,
  }) : super(key: key);
  
  @override
  State<IngredientCategoryCard> createState() => _IngredientCategoryCardState();
}

class _IngredientCategoryCardState extends State<IngredientCategoryCard> {
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


// FOUND IN ad_IngredientsTab && ad_FoodTab && cust_HomeTab
// FOUND IN ad_IngredientsTab && ad_FoodTab && cust_HomeTab
class FoodCategoryCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _categories.length,
      padding: EdgeInsets.symmetric(horizontal: 8),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: FoodCategoryCard(category: _categories[index]),
        );
      },
    );
  }
}

class FoodCategoryCard extends StatefulWidget {
  final Category category;

  const FoodCategoryCard({
    required this.category, 
    Key? key,
  }) : super(key: key);
  
  @override
  State<FoodCategoryCard> createState() => _FoodCategoryCardState();
}

class _FoodCategoryCardState extends State<FoodCategoryCard> {
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


// FOUND IN ad_IngredientsTab
// FOUND IN ad_IngredientsTab
class AdminIngredientCards extends StatelessWidget {
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
        return AdminIngredientCard(category: _categories[index]);
      }
    );
  }
}

class AdminIngredientCard extends StatefulWidget {
  final Category category;

  const AdminIngredientCard({
    required this.category, 
    Key? key,
  }) : super(key: key);
   
  @override
  State<AdminIngredientCard> createState() => _AdminIngredientCardState();
}

class _AdminIngredientCardState extends State<AdminIngredientCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.2;
    double titleFontSize = screenWidth * 0.045;
    double subtitleFontSize = screenWidth * 0.04;

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
            padding: EdgeInsets.fromLTRB(0, 0, 8, 0), // Add the required padding
            child: AddRemoveButton(onChanged: (int ) {  },),
          ),
        ],
      ),
    );
  }
} 


// FOUND IN ad_FoodTab
// FOUND IN ad_FoodTab
class AdminFoodCards extends StatelessWidget {
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
        return AdminFoodCard(category: _categories[index]);
      },
    );
  }
}

class AdminFoodCard extends StatefulWidget {
  final Category category;

  const AdminFoodCard({
    required this.category, 
    Key? key,
  }) : super(key: key);
  
  @override
  State<AdminFoodCard> createState() => _AdminFoodCardState();
}

class _AdminFoodCardState extends State<AdminFoodCard> {
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
            MaterialPageRoute(builder: (context) => AdminFoodTemplate())
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


// FOUND IN cust_HomeTab
// FOUND IN cust_HomeTab
class CustomerFoodCards extends StatelessWidget {
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
        return AdminFoodCard(category: _categories[index]);
      },
    );
  }
}

class CustomerFoodCard extends StatefulWidget {
  final Category category;

  const CustomerFoodCard({
    required this.category, 
    Key? key,
  }) : super(key: key);
  
  @override
  State<CustomerFoodCard> createState() => _CustomerFoodCardState();
}

class _CustomerFoodCardState extends State<CustomerFoodCard> {
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
            MaterialPageRoute(builder: (context) => CustomerFoodTemplate())
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


// FOUND IN ad_OrdersTab
// FOUND IN ad_OrdersTab
class AdminOrdersCards extends StatelessWidget {
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
        return AdminOrdersCard(category: _categories[index]);
      },
    );
  }
}

class AdminOrdersCard extends StatefulWidget {
  final Category category;

  const AdminOrdersCard({
    required this.category, 
    Key? key,
  }) : super(key: key);
  
  @override
  State<AdminOrdersCard> createState() => _AdminOrdersCardState();
}

class _AdminOrdersCardState extends State<AdminOrdersCard> {
  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double avatarRadius = screenWidth * .12;
    double titleFontSize = screenWidth * 0.045;
    double descriptionFontSize = screenWidth * 0.04;
    double buttonFontSize = screenWidth * 0.04;
    double sizedboxHeight = screenWidth * 0.09;

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: 
                      SizedBox(
                        height: sizedboxHeight,
                        child:
                      ElevatedButton(onPressed: () {}, child: Text('Accept', style: TextStyle(fontSize: buttonFontSize)), 
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          backgroundColor: MaterialStateProperty.all(c_pri_yellow),  
                          foregroundColor: MaterialStateProperty.all(c_white),                        
                          )),
                      ),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: 
                      SizedBox(
                        height: sizedboxHeight,
                        child: 
                      ElevatedButton(onPressed: () {}, child: Text('Deny', style: TextStyle(fontSize: buttonFontSize),), 
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          backgroundColor: MaterialStateProperty.all(c_sec_yellow),  
                          foregroundColor: MaterialStateProperty.all(c_white),                        
                          )
                        ),
                      ),
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

// SAMPLE STATUS INPUTS
// SAMPLE STATUS INPUTS
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


// FOUND IN ad_OrdersTab
// FOUND IN ad_OrdersTab
class OrderStatusCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _statuses.length,
     
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: OrderStatusCard(status: _statuses[index]),
        );
      },
    );
  }
}

class OrderStatusCard extends StatefulWidget {
  final Status status;

  const OrderStatusCard({
    required this.status, 
    Key? key,
  }) : super(key: key);
  
  @override
  State<OrderStatusCard> createState() => _OrderStatusCardState();
}

class _OrderStatusCardState extends State<OrderStatusCard> {
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


// NAMED cust_Cart && FOUND IN cust_HomeTab & cust_OrdersTab
// NAMED cust_Cart && FOUND IN cust_HomeTab & cust_OrdersTab
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 4),
                  child: AddRemoveButton(onChanged: (int ) {  },),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 


// NAMED cust_Checkout && FOUND AFTER cust_Cart via Button
// NAMED cust_Checkout && FOUND AFTER cust_Cart via Button
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


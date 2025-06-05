import 'package:flutter/material.dart';
import 'package:foodie_app/UI_pages/Templates/ad_food_Order.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'package:foodie_app/Utilities/utilities_buttons.dart';
import 'utilities_others.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../UI_pages/Templates/cust_food_Order.dart';
import '../UI_pages/Schemas/Ingredient.dart';
import '../UI_pages/Schemas/Food.dart';
import '../UI_pages/Templates/AddIngredient_Form.dart';
import '../UI_pages/Templates/AddFood_Form.dart';
import 'package:foodie_app/UI_pages/Templates/cust_food_Order.dart';
import '../UI_pages/Schemas/Order.dart';

// SAMPLE CARD INPUTS
// SAMPLE CARD INPUTS
final List<Category> _categories = [
  Category(
      assetName: 'lib/images/opening-image.png',
      name: 'Mains',
      status: 'Available',
      isSelected: false),
  Category(
      assetName: 'lib/images/opening-image.png',
      name: 'Appetizers',
      status: 'Available',
      isSelected: false),
  Category(
      assetName: 'lib/images/opening-image.png',
      name: 'Pastries',
      status: 'Available',
      isSelected: false),
  Category(
      assetName: 'lib/images/opening-image.png',
      name: 'Beverages',
      status: 'Available',
      isSelected: false),
];

class Category {
  final String assetName;
  final String name;
  final String status;
  bool isSelected;

  Category(
      {required this.assetName,
      required this.name,
      required this.status,
      this.isSelected = false});
}


final List<IngredientsCategory> _ingredientCategories = [
  IngredientsCategory(
      assetName: 'lib/images/opening-image.png',
      name: 'Vegetables',
      isSelected: false),
  IngredientsCategory(
      assetName: 'lib/images/opening-image.png',
      name: 'Protein',
      isSelected: false),
  IngredientsCategory(
      assetName: 'lib/images/opening-image.png',
      name: 'Liquids',
      isSelected: false),
  IngredientsCategory(
      assetName: 'lib/images/opening-image.png',
      name: 'Condiments',
      isSelected: false),
  IngredientsCategory(
      assetName: 'lib/images/opening-image.png',
      name: 'Baking Essentials',
      isSelected: false),
];

class IngredientsCategory {
  final String assetName;
  final String name;
  bool isSelected;

  IngredientsCategory(
      {required this.assetName,
      required this.name,
      this.isSelected = false});
}

// FOUND IN ad_IngredientsTab
// FOUND IN ad_IngredientsTab
class IngredientCategoryCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _ingredientCategories.length,
      padding: EdgeInsets.symmetric(horizontal: 8),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: IngredientCategoryCard(category: _ingredientCategories[index]),
        );
      },
    );
  }
}

class IngredientCategoryCard extends StatefulWidget {
  final IngredientsCategory category;

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
// Updated AdminIngredientCards with proper error handling
class AdminIngredientCards extends StatefulWidget {
  final String categoryFilter;

  const AdminIngredientCards({
    required this.categoryFilter,
    Key? key,
  }) : super(key: key);

  @override
  State<AdminIngredientCards> createState() => _AdminIngredientCardsState();
}

class _AdminIngredientCardsState extends State<AdminIngredientCards> {
  List<Ingredient> ingredients = [];
  bool isLoading = true;
  RealtimeChannel? _channel;

  @override
  void initState() {
    super.initState();
    fetchIngredients();
    setupRealtimeListener();
  }

  @override
  void didUpdateWidget(covariant AdminIngredientCards oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryFilter != widget.categoryFilter) {
      fetchIngredients();
    }
  }

  @override
  void dispose() {
    // Clean up the subscription when widget is disposed
    _channel?.unsubscribe();
    super.dispose();
  }

  Future<void> fetchIngredients() async {
    try {
      final response = await Supabase.instance.client
          .from('ingredients')
          .select('*')
          .eq('category', widget.categoryFilter)
          .order('name', ascending: true);

      print('Supabase response: $response');

      setState(() {
        ingredients = response
            .map<Ingredient>((json) => Ingredient.fromJson(json))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching ingredients: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void setupRealtimeListener() {
    _channel = Supabase.instance.client
        .channel('public:ingredients')
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'ingredients',
            callback: (payload) {
              fetchIngredients();
            })
        .subscribe();
  }

  void updateIngredientQuantity(String ingredientId, int newQuantity) {
    final index = ingredients
        .indexWhere((ingredient) => ingredient.id.toString() == ingredientId);
    if (index != -1) {
      setState(() {
        ingredients[index].quantity = newQuantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        // Main ingredients list
        Expanded(
          child: RefreshIndicator(
            onRefresh: fetchIngredients,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3.5,
                mainAxisSpacing: 2,
              ),
              padding: EdgeInsets.all(8),
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditIngredientTemplate(
                                ingredient: ingredients[index])));
                  },
                  child: AdminIngredientCard(
                    key: ValueKey(ingredients[index].id),
                    ingredient: ingredients[index],
                    onQuantityChanged: updateIngredientQuantity,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// Updated AdminIngredientCard with better error handling
class AdminIngredientCard extends StatelessWidget {
  final Ingredient ingredient;
  final Function(String, int) onQuantityChanged;

  const AdminIngredientCard(
      {required this.ingredient, required this.onQuantityChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.2;
    double imageHeight = screenHeight * 0.2;
    double titleFontSize = screenWidth * 0.045;
    double subtitleFontSize = screenWidth * 0.04;
    double iconButtonSize = screenWidth * 0.07;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LEFT: Name and Unit
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ingredient.name,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: titleFontSize,
                  ),
                ),
                Text(
                  ingredient.unit,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: subtitleFontSize,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          // RIGHT: Quantity + Delete + Category (side by side)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AddRemoveButton(
                  initialValue: ingredient.quantity,
                  onChanged: (quantity) async {
                    try {
                      await Supabase.instance.client
                          .from('ingredients')
                          .update({'quantity': quantity})
                          .eq('id', ingredient.id)
                          .select();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Failed to update ${ingredient.name}: ${e.toString()}')),
                      );
                    }
                  },
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        ingredient.category ?? 'Uncategorized',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.delete, size: iconButtonSize),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      color: c_pri_yellow,
                      onPressed: () async {
                        try {
                          await Supabase.instance.client
                              .from('ingredients')
                              .delete()
                              .eq('id', ingredient.id);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Failed to delete ${ingredient.name}: ${e.toString()}')),
                          );
                        }
                      },
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

// FOUND IN ad_FoodTab
// FOUND IN ad_FoodTab
class AdminFoodCards extends StatefulWidget {
  final String categoryFilter;

  const AdminFoodCards({
    required this.categoryFilter,
    Key? key,
  }) : super(key: key);
  @override
  State<AdminFoodCards> createState() => _AdminFoodCardsState();
}

class _AdminFoodCardsState extends State<AdminFoodCards> {
  List<Food> foods = [];
  bool isLoading = true;
  RealtimeChannel? _channel;

  @override
  void initState() {
    super.initState();
    fetchFoods();
    setupRealtimeListener();
  }

  @override
  void didUpdateWidget(covariant AdminFoodCards oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryFilter != widget.categoryFilter) {
      fetchFoods();
    }
  }

  @override
  void dispose() {
    _channel?.unsubscribe();
    super.dispose();
  }

  Future<void> fetchFoods() async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category', widget.categoryFilter)
          .order('product_name', ascending: true);

      print('Supabase response: $response');

      setState(() {
        foods = response.map<Food>((json) => Food.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching food: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
  

  void setupRealtimeListener() {
    _channel = Supabase.instance.client
        .channel('public:products')
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'products',
            callback: (payload) {
              fetchFoods();
            })
        .subscribe();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .9,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      padding: EdgeInsets.all(8),
      itemCount: foods.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EditFoodTemplate(food: foods[index])));
            },
            child: AdminFoodCard(
                key: ValueKey(foods[index].id), food: foods[index]));
      },
    );
  }
}

class AdminFoodCard extends StatelessWidget {
  final Food food;

  const AdminFoodCard({
    required this.food,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double imageHeight = screenHeight * 0.13;
    double titleFontSize = screenWidth * 0.04;
    double subtitleFontSize = screenWidth * 0.04;
    double iconButtonSize = screenWidth * 0.07;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            margin: EdgeInsets.all(4),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: imageHeight,
              child: Image.network(
                food.imageUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 4, 0, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.product_name,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: titleFontSize),
                ),
                Text(
                  food.availability ? 'Available' : 'Unavailable',
                  style: TextStyle(
                      fontFamily: 'Inter', fontSize: subtitleFontSize),
                ),
                IconButton(
                  icon: Icon(Icons.delete, size: iconButtonSize),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  color: c_pri_yellow,
                onPressed: () async {
                    final client = Supabase.instance.client;

                    try {
                      // Delete all recipes using this product (assuming FK: recipe.product_id → products.id)
                      final recipeResponse = await client
                          .from('recipes')
                          .delete()
                          .eq('recipes.product_id', food.id);

                      if (recipeResponse.error != null) {
                        throw Exception(
                            'Failed to delete related recipes: ${recipeResponse.error!.message}');
                      }

                      // Delete the product itself
                      final productResponse = await client
                          .from('products')
                          .delete()
                          .eq('id', food.id);

                      if (productResponse.error != null) {
                        throw Exception(
                            'Failed to delete product: ${productResponse.error!.message}');
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${food.product_name} deleted successfully.'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Deletion error: ${e.toString()}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// FOUND IN cust_HomeTab
// FOUND IN cust_HomeTab
class CustomerFoodCards extends StatefulWidget {
  final String categoryFilter;

  const CustomerFoodCards({
    required this.categoryFilter,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerFoodCards> createState() => _CustomerFoodCardsState();
}

class _CustomerFoodCardsState extends State<CustomerFoodCards> {
  List<Food> foods = [];
  bool isLoading = true;
  RealtimeChannel? _channel;

  @override
  void initState() {
    super.initState();
    fetchFoods();
    setupRealtimeListener();
  }

  @override
  void didUpdateWidget(covariant CustomerFoodCards oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryFilter != widget.categoryFilter) {
      fetchFoods();
    }
  }

  @override
  void dispose() {
    _channel?.unsubscribe();
    super.dispose();
  }

  Future<void> fetchFoods() async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category', widget.categoryFilter)
          .order('created_at', ascending: false);

      print('Supabase response: $response');

      setState(() {
        foods = response.map<Food>((json) => Food.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching food: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void setupRealtimeListener() {
    _channel = Supabase.instance.client
        .channel('public:products')
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'products',
            callback: (payload) {
              fetchFoods();
            })
        .subscribe();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .9,
        crossAxisSpacing: 4,
        mainAxisSpacing: 8,
      ),
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      itemCount: foods.length,
      itemBuilder: (context, index) {
        return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CustomerFoodTemplate(food: foods[index])));
            },
            child: CustomerFoodCard(
                key: ValueKey(foods[index].id), food: foods[index]));
      },
    );
  }
}

class CustomerFoodCard extends StatefulWidget {
  final Food food;

  const CustomerFoodCard({
    required this.food,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerFoodCard> createState() => _CustomerFoodCardState();
}

class _CustomerFoodCardState extends State<CustomerFoodCard> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double imageHeight = screenHeight * 0.14;
    double titleFontSize = screenWidth * 0.045;
    double subtitleFontSize = screenWidth * 0.04;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            margin: EdgeInsets.all(4),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: imageHeight,
              child: Image.network(
                widget.food.imageUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 0, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.food.product_name,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: titleFontSize),
                ),
                Text(
                  widget.food.price.toString(),
                  style: TextStyle(
                      fontFamily: 'Inter', fontSize: subtitleFontSize),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// FOUND IN ad_OrdersTab
// FOUND IN ad_OrdersTab
class AdminOrdersCards extends StatefulWidget {
  final String statusFilter;

  const AdminOrdersCards({
    required this.statusFilter,
    Key? key,
  }) : super(key: key);

  @override
  State<AdminOrdersCards> createState() => _AdminOrdersCardsState();
}

class _AdminOrdersCardsState extends State<AdminOrdersCards> {
  List<OrderModel> orders = [];
  bool isLoading = true;
  RealtimeChannel? _channel;

  @override 
  void initState() {
    super.initState();
    fetchOrders();
    setupRealtimeListener();
  }

  @override
  void dispose() {
    _channel?.unsubscribe();
    super.dispose();
  }
  
  Future<void> fetchOrders() async {
    try {
      final response = await Supabase.instance.client
        .from('orders')
        .select('''
          id,
          order_total,
          order_status,
          customers(first_name, last_name),
          order_items(product_id, products(product_name))
        ''')
        .eq('order_status', widget.statusFilter)
        .order('created_at', ascending: false);

      setState(() {
        orders = response.map<OrderModel>((json) => OrderModel.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching orders: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void setupRealtimeListener() {
    _channel = Supabase.instance.client
      .channel('public:orders')
      .onPostgresChanges(
        event: PostgresChangeEvent.all, 
        schema: 'public',
        table: 'orders',
        callback: (payload) {
          fetchOrders();
        })
      .subscribe();
  }


  @override
  Widget build(BuildContext context) {
    if (isLoading) return Center(child: CircularProgressIndicator());

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2.3,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), 
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return AdminOrdersCard(order: orders[index], onStatusChanged: fetchOrders);
      },
    );
  }
}

class AdminOrdersCard extends StatefulWidget {
  final OrderModel order;
  final VoidCallback onStatusChanged;

  const AdminOrdersCard({

    required this.order, 
    required this.onStatusChanged,

    Key? key,
  }) : super(key: key);

  @override
  State<AdminOrdersCard> createState() => _AdminOrdersCardState();
}

class _AdminOrdersCardState extends State<AdminOrdersCard> {

  bool isLoading = false;

  void updateOrderStatus(String newStatus) async {
    setState(() {
      isLoading = false;
    });

    try {
      final response = await Supabase.instance.client
        .from('orders')
        .update({'order_status': newStatus})
        .eq('id', widget.order.id);
      
      if (response.error == null) {
        widget.onStatusChanged();
      }
    } catch (e) {
      print('Error updating order status: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildActionButtons(String status) {
    switch (status) {
      case 'Pending':
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => updateOrderStatus('Accepted'),
                child: Text('Accept'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: c_pri_yellow,
                  foregroundColor: c_white,
                ),
              ),
            ),
            SizedBox(width: 6),
            Expanded(
              child: ElevatedButton(
                onPressed: () => updateOrderStatus('Denied'),
                child: Text('Deny'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: c_sec_yellow,
                  foregroundColor: c_white,
                ),
              ),
            ),
          ],
        );

      case 'Accepted':
        return ElevatedButton(
          onPressed: () => updateOrderStatus('To Deliver'),
          child: Text('Deliver'),
          style: ElevatedButton.styleFrom(
            backgroundColor: c_pri_yellow,
            foregroundColor: c_white,
          ),
        );

      case 'To Deliver':
        return ElevatedButton(
          onPressed: () => updateOrderStatus('Completed'),
          child: Text('Complete'),
          style: ElevatedButton.styleFrom(
            backgroundColor: c_pri_yellow,
            foregroundColor: c_white,
          ),
        );

      case 'Completed':
        return Container(); // No buttons needed

      default:
        return Container(); // fallback
    }
  }

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
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(2, 2, 8, 2),
          margin: EdgeInsets.zero,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: ClipOval(
                  child:
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.network(
                      widget.order.imageUrl ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Icon(Icons.image_not_supported),
                        );
                      },
                    ),
                  ),
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
                      child: Text(widget.order.customerName, style: TextStyle(fontSize: titleFontSize)),
                    ),
                    Padding(    
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            spacing: 4,
                            runSpacing: -6,
                            children: widget.order.orderedItems.map((item) {
                              return Chip(
                                label: Text(
                                  '${item.productName} x${item.quantity}',
                                  style: TextStyle(fontSize: 10), // smaller font
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 4, vertical: -2),
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              );
                            }).toList(),
                          ),
                          Text('₱${widget.order.totalAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: descriptionFontSize)),
                        ],
                      ),
                    ),
                    buildActionButtons(widget.order.status),
                  ],
                ),
              ),
            ],
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
class CartCards extends StatefulWidget {
  final Function(Set<int>) onSelectionChanged;
  final Function(List<Map<String, dynamic>>) onCartItemsChanged;

  const CartCards({
    required this.onSelectionChanged,
    required this.onCartItemsChanged,
  });

  @override
  State<CartCards> createState() => _CartCardsState();
}

class _CartCardsState extends State<CartCards> {
  List<Map<String, dynamic>> cartItems = [];
  Set<int> selectedCartItemIds = {}; // Track selected cart item IDs
  bool isLoading = true;
  RealtimeChannel? _channel;

  @override
  void initState() {
    super.initState();
    fetchCartItems();
    setupRealtimeListener();
  }

  @override
  void dispose() {
    _channel?.unsubscribe();
    super.dispose();
  }

  Future<void> fetchCartItems() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        setState(() {
          cartItems = [];
          isLoading = false;
        });
        widget.onCartItemsChanged(cartItems);
        return;
      }

      final response = await Supabase.instance.client
          .from('cart_items')
          .select('*, products(*)')
          .eq('cust_id', userId);

      setState(() {
        cartItems = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
      widget.onCartItemsChanged(cartItems);
    } catch (e) {
      print('Error fetching cart items: $e');
      setState(() {
        isLoading = false;
      });
      widget.onCartItemsChanged(cartItems);
    }
  }

  void setupRealtimeListener() {
    _channel = Supabase.instance.client
        .channel('public:cart_items')
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'cart_items',
            callback: (payload) {
              fetchCartItems();
            })
        .subscribe();
  }

  Future<void> updateCartItemQuantity(int cartItemId, int newQuantity) async {
    try {
      await Supabase.instance.client
          .from('cart_items')
          .update({'quantity': newQuantity}).eq('id', cartItemId);
    } catch (e) {
      print('Error updating cart item quantity: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update quantity: ${e.toString()}')));
    }
  }

  void toggleSelection(int cartItemId) {
    setState(() {
      if (selectedCartItemIds.contains(cartItemId)) {
        selectedCartItemIds.remove(cartItemId);
      } else {
        selectedCartItemIds.add(cartItemId);
      }
      print('Toggled selection. New selected IDs: $selectedCartItemIds');
      widget.onSelectionChanged(selectedCartItemIds);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3,
      ), 
      padding: EdgeInsets.symmetric(horizontal: 8),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final cartItem = cartItems[index];
        final food = Food.fromJson(cartItem['products']);
        final cartItemId = cartItem['id'] as int;
        return CartCard(
          key: ValueKey(cartItemId),
          food: food,
          cartItemId: cartItemId,
          quantity: cartItem['quantity'],
          onQuantityChanged: updateCartItemQuantity,
          isSelected: selectedCartItemIds.contains(cartItemId),
          onSelected: () => toggleSelection(cartItemId),
        );
      }
    );

  }
}

class CartCard extends StatelessWidget {
  final Food food;
  final int cartItemId;
  final int quantity;
  final Function(int, int) onQuantityChanged;
  final bool isSelected;
  final VoidCallback onSelected;

  const CartCard({
    required this.food,
    required this.cartItemId,
    required this.quantity,
    required this.onQuantityChanged,
    required this.isSelected,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.25;
    double titleFontSize = screenWidth * 0.045;
    double subtitleFontSize = screenWidth * 0.04;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(4, 2, 0, 2),
            child: Row(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    width: imageWidth,
                    child: Image.network(
                      food.imageUrl ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Icon(Icons.image_not_supported),
                        );
                      },
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
                        food.product_name,
                        style: TextStyle(
                            fontFamily: 'Inter', fontSize: titleFontSize),
                      ),
                      Text(
                        'P${food.price.toString()}',
                        style: TextStyle(
                            fontFamily: 'Inter', fontSize: subtitleFontSize),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(0, 4, 4, 4), // Add the required padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Checkbox(
                  value: isSelected,
                  onChanged: (_) => onSelected(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 4),
                  child: AddRemoveButton(
                      initialValue: quantity,
                      onChanged: (int value) {
                        onQuantityChanged(cartItemId, value);
                      }),
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
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return CheckoutCard(category: _categories[index], index: index);
        });
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
        _categories[widget.index].isSelected =
            !_categories[widget.index].isSelected;
        isAllSelected = _categories.every((category) => category.isSelected);
      });
    }

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(4, 2, 0, 2), // Add the required padding
            child: Row(
              // Image container
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
                        style: TextStyle(
                            fontFamily: 'Inter', fontSize: titleFontSize),
                      ),                     
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(0, 12, 12, 8), // Add the required padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('x1',
                    style: TextStyle(
                        fontFamily: 'Inter', fontSize: subtitleFontSize)),
                Text('P100',
                    style: TextStyle(
                        fontFamily: 'Inter', fontSize: titleFontSize)),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 

// FOUND IN cust_OrdersTab
// FOUND IN cust_OrdersTab
class CustomerOrdersCards extends StatefulWidget {
  final String statusFilter;

  const CustomerOrdersCards({
    required this.statusFilter,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerOrdersCards> createState() => _CustomerOrdersCardsState();
}

class _CustomerOrdersCardsState extends State<CustomerOrdersCards> {
  List<OrderModel> orders = [];
  bool isLoading = true;
  RealtimeChannel? _channel;

  @override 
  void initState() {
    super.initState();
    fetchOrders();
    setupRealtimeListener();
  }

  @override
  void dispose() {
    _channel?.unsubscribe();
    super.dispose();
  }
  
  Future<void> fetchOrders() async {
    try {
      final response = await Supabase.instance.client
        .from('orders')
        .select('''
          id,
          order_total,
          order_status,
          customers(first_name, last_name),
          order_items(quantity, products(product_name, image_url))
        ''')
        .eq('order_status', widget.statusFilter)
        .order('created_at', ascending: false);

      setState(() {
        orders = response.map<OrderModel>((json) => OrderModel.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching orders: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void setupRealtimeListener() {
    _channel = Supabase.instance.client
      .channel('public:orders')
      .onPostgresChanges(
        event: PostgresChangeEvent.all, 
        schema: 'public',
        table: 'orders',
        callback: (payload) {
          fetchOrders();
        })
      .subscribe();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return Center(child: CircularProgressIndicator());

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), 
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return CustomerOrdersCard(order: orders[index], onStatusChanged: fetchOrders);
      },
    );
  }
}

class CustomerOrdersCard extends StatefulWidget {
  final OrderModel order;
  final VoidCallback onStatusChanged;

  const CustomerOrdersCard({
    required this.order, 
    required this.onStatusChanged,
    Key? key,
  }) : super(key: key);
  
  @override
  State<CustomerOrdersCard> createState() => _CustomerOrdersCardState();
}

class _CustomerOrdersCardState extends State<CustomerOrdersCard> {
  bool isLoading = false;

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
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(2,2,8,2),
          margin: EdgeInsets.zero,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: ClipOval(
                  child:
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.network(
                      widget.order.imageUrl ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Icon(Icons.image_not_supported),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...widget.order.orderedItems.map((item) => Text(
                      '${item.productName} x${item.quantity}',
                      style: TextStyle(fontSize: 14),
                    )),
                    SizedBox(height: 6),
                    Text(
                      '₱${widget.order.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
} 


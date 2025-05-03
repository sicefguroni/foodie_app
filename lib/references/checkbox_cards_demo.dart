import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FoodGridScreen(),
    );
  }
}

class FoodItem {
  final String name;
  final String description;
  final String imageUrl;
  bool isSelected;

  FoodItem({
    required this.name,
    required this.description,
    required this.imageUrl,
    this.isSelected = false,
  });
}

class FoodGridScreen extends StatefulWidget {
  @override
  _FoodGridScreenState createState() => _FoodGridScreenState();
}

class _FoodGridScreenState extends State<FoodGridScreen> {
  List<FoodItem> foods = List.generate(
    8,
    (index) => FoodItem(
      name: 'Food $index',
      description: 'Tasty food number $index',
      imageUrl: 'https://via.placeholder.com/100',
    ),
  );

  bool isAllSelected = false;

  void toggleSelectAll() {
    setState(() {
      isAllSelected = !isAllSelected;
      for (var food in foods) {
        food.isSelected = isAllSelected;
      }
    });
  }

  void toggleSelection(int index) {
    setState(() {
      foods[index].isSelected = !foods[index].isSelected;
      isAllSelected = foods.every((food) => food.isSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Food'),
        actions: [
          Row(
            children: [
              Text('Select All'),
              Checkbox(
                value: isAllSelected,
                onChanged: (_) => toggleSelectAll(),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: foods.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final food = foods[index];
            return Stack(
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(food.imageUrl),
                        radius: 30,
                      ),
                      SizedBox(height: 8),
                      Text(food.name, style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(food.description, style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Checkbox(
                    value: food.isSelected,
                    onChanged: (_) => toggleSelection(index),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

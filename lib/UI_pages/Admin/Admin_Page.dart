import 'package:flutter/material.dart';
import 'package:foodie_app/utilities/color_palette.dart';
import 'ad_FoodTab.dart';
import 'ad_IngredientsTab.dart';
import 'ad_OrdersTab.dart';


class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => AdminPageStates();
}

class AdminPageStates extends State<AdminPage> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    AdminIngredientsTab(),
    AdminFoodTab(),
    AdminOrdersTab(),
  ];

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        selectedItemColor: c_pri_yellow,
        unselectedItemColor: const Color.fromARGB(255, 109, 109, 109),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Ingredients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lunch_dining),
            label: 'Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Orders',
          ),
        ],
      ),
    );
  }
}
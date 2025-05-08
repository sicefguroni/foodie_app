import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'cust_HomeTab.dart';
import 'cust_OrdersTab.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => CustomerPageStates();
}

class CustomerPageStates extends State<CustomerPage> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    CustomerHomeTab(),
    CustomerOrdersTab(),
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
            icon: Icon(Icons.home),
            label: 'Home',
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





import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'UI_pages/Opening/First_Route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setWindowFrame(Rect.fromLTWH(0, 75, 360, 800));
  
  runApp(const FoodieApp());
} 

class FoodieApp extends StatelessWidget {
  const FoodieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodie',
      home: FirstRoute(),
    );
  }
}
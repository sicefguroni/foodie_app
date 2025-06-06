import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:window_size/window_size.dart';
import 'UI_pages/Opening/First_Route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setWindowFrame(Rect.fromLTWH(0, 75, 360, 800));

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("⚠️ Failed to load .env: $e");
  }

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const FoodieApp());
} 

final supabase = Supabase.instance.client;

class FoodieApp extends StatelessWidget {
  const FoodieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodie',
      home: FirstRoute(),
    );
  }
}
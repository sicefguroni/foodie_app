import 'package:flutter/material.dart';
import 'package:foodie_app/UI_pages/Admin/Admin_Page.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_texts.dart';
import '../../auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminSignInRoute extends StatefulWidget {
  const AdminSignInRoute({super.key});

  @override
  State<AdminSignInRoute> createState() => _AdminSignInRouteState();
}

class _AdminSignInRouteState extends State<AdminSignInRoute> {
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter email and password')),
        );
      }
      return;
    }

    try {
      final response =
          await authService.signInWithEmailPassword(email, password);
      final user = response.user;

      if (user != null) {
        // Check if user is in 'admins' table
        final supabase = Supabase.instance.client;
        final admin = await supabase
            .from('admins')
            .select()
            .eq('id', user.id)
            .maybeSingle();

        if (admin != null) {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminPage()),
            );
          }
        } else {
          await authService.signOut();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Access denied: Account is not an admin.')),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Login failed. Account does not exist')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  // UI Part
  // UI Part
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, left: 0), // already padded horizontally
            child: YellowBackButton(),
          ),
          TitleText(title: 'Foodie', color: c_pri_yellow),
          Heading3_Text(text: 'Welcome Back!', color: c_pri_yellow),
          bodyText(text: 'Admin Sign In', color: c_pri_yellow),
          const SizedBox(height: 75),
          Container(
            width: double.infinity,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InputTextField(
                    hintText: 'Email',
                    controller: _emailController,
                    obscureText: false),
                const SizedBox(height: 25),
                InputTextField(
                    hintText: 'Password',
                    controller: _passwordController,
                    obscureText: true),
                const SizedBox(height: 25),
                ActionButton(
                  buttonName: 'Sign In',
                  backgroundColor: c_pri_yellow,
                  onPressed: login,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

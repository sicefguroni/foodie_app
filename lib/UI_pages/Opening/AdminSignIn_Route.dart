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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/images/foodie_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 4.0, left: 4), // already padded horizontally
            child: YellowBackButton(),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TitleText(title: 'Foodie', color: c_pri_yellow),
                Heading3_Text(text: 'Welcome to Foodie!', color: c_pri_yellow),
                bodyText(text: 'Sign in your account', color: c_pri_yellow),
              ],
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InputTextField(
                            hintText: 'Email',
                            labelText: 'Email',
                            controller: _emailController,
                            obscureText: false),
                        const SizedBox(height: 15),
                        InputTextField(
                            hintText: 'Password',
                            labelText: 'Password',
                            controller: _passwordController,
                            isPassword: true),
                        const SizedBox(height: 25),
                        NormalButton(
                          buttonName: 'Sign In',
                          backgroundColor: c_pri_yellow,
                          fontColor: c_white,
                          onPressed: login,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foodie_app/UI_pages/Customer/Customer_Page.dart';
import 'package:foodie_app/UI_pages/Opening/SignUp_Route.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_texts.dart';
import '../Admin/Admin_Page.dart';
import '../../auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInRoute extends StatefulWidget {
  const SignInRoute({super.key});

  @override
  State<SignInRoute> createState() => _SignInRouteState();
}

class _SignInRouteState extends State<SignInRoute> {
  // get auth service
  final authService = AuthService();

  // text controllerse
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Sign In button pressed
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
        // Check if user is in 'customers' table
        final supabase = Supabase.instance.client;
        final customer = await supabase
            .from('customers')
            .select()
            .eq('id', user.id)
            .maybeSingle();

        if (customer != null) {
          // Navigate to CustomerPage
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CustomerPage()),
            );
          }
        } else {
          // Not a customer: sign out and show error
          await authService.signOut();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Access denied: not a customer')),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login failed')),
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
          Heading3_Text(text: 'Welcome to Foodie!', color: c_pri_yellow),
          bodyText(text: 'Sign in your account', color: c_pri_yellow),
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
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpRoute_1st()),
                      );
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DefaultTextStyle.merge(
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: c_pri_yellow,
                            color: c_pri_yellow,
                          ),
                          child: bodyText(
                            text: "Don't have an account? Sign Up",
                            color: c_pri_yellow,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

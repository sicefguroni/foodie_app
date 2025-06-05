import 'package:flutter/material.dart';
import 'package:foodie_app/UI_pages/Customer/Customer_Page.dart';
import 'package:foodie_app/UI_pages/Opening/CustomerSignUp_Route.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_texts.dart';
import '../../auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerSignInRoute extends StatefulWidget {
  const CustomerSignInRoute({super.key});

  @override
  State<CustomerSignInRoute> createState() => _CustomerSignInRouteState();
}

class _CustomerSignInRouteState extends State<CustomerSignInRoute> {
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
              const SnackBar(content: Text('Access denied: Account is not a customer.')),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login failed. Account does not exist.')),
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/images/foodie_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
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
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Don't have an account? ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins',
                                          fontSize: 12
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Sign Up",
                                        style: TextStyle(
                                          color: c_pri_yellow,
                                          fontFamily: 'Poppins',
                                          decoration: TextDecoration.underline,
                                          decorationColor: c_pri_yellow,
                                          fontSize: 12
                                        ),
                                      ),
                                    ],
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
            ),
          ),
        ],
      ),
    );
  }
}

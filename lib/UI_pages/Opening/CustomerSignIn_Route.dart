import 'package:flutter/material.dart';
import 'package:foodie_app/UI_pages/Customer/Customer_Page.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_texts.dart';
import '../../auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'CustomerSignUp_Route.dart';

class CustomerSignInRoute extends StatefulWidget {
  const CustomerSignInRoute({super.key});

  @override
  State<CustomerSignInRoute> createState() => _CustomerSignInRouteState();
}

class _CustomerSignInRouteState extends State<CustomerSignInRoute> {
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Add error message state
  String? _errorMessage;

  void login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Clear previous error message
    setState(() {
      _errorMessage = null;
    });

    // Input validation
    if (email.isEmpty && password.isEmpty) {
      setState(() {
        _errorMessage = '*Please enter email and password';
      });
      return;
    }
    
    if (email.isEmpty) {
      setState(() {
        _errorMessage = '*Please enter email';
      });
      return;
    } 
    
    if (password.isEmpty) {
      setState(() {
        _errorMessage = '*Please enter password';
      });
      return;
    }

    try {
      final response = await authService.signInWithEmailPassword(email, password);
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
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CustomerPage()),
            );
          }
        } else {
          await authService.signOut();
          setState(() {
            _errorMessage = 'Access denied: Account is not a customer';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Login failed. Account does not exist';
        });
      }
    } on AuthApiException catch (e) {
      // Handle specific authentication errors
      String errorMessage;
      
      if (e.statusCode == '400') {
        // Invalid email or password
        errorMessage = 'Invalid email or password';
      } else if (e.statusCode == '422') {
        // Email not confirmed or other validation errors
        errorMessage = 'Please check your email and password';
      } else {
        // Other auth errors
        errorMessage = 'Login failed. Please try again';
      }
      
      setState(() {
        _errorMessage = errorMessage;
      });
    } catch (e) {
      // Handle other general errors
      setState(() {
        _errorMessage = 'An error occurred. Please try again';
      });
    }
  }

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
                Heading3_Text(text: 'Welcome Back!', color: c_pri_yellow),
                bodyText(text: 'Sign in to your Account', color: c_pri_yellow),
              ],
            ),
          ),
          SafeArea(
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
                          controller: _emailController,
                          obscureText: false),
                      const SizedBox(height: 15),
                      InputTextField(
                          hintText: 'Password',
                          controller: _passwordController,
                          isPassword: true),
                      
                      // Error message display
                      if (_errorMessage != null) ...[
                        const SizedBox(height: 10),
                        Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      
                      const SizedBox(height: 25),
                      ActionButton(
                        buttonName: 'Sign In',
                        backgroundColor: c_pri_yellow,
                        onPressed: login,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 12,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpRoute_1st()));
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                color: c_pri_yellow,
                                fontFamily: 'Poppins',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
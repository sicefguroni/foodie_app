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
        _errorMessage = 'Please enter email and password';
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
          setState(() {
            _errorMessage = 'Access denied: Account is not an admin';
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
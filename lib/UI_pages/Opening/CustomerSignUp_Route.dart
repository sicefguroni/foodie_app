import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_texts.dart';
import '../../Utilities/color_palette.dart';
import '../../auth/auth_service.dart';
import 'Second_Route.dart';

class SignUpRoute_1st extends StatefulWidget {
  const SignUpRoute_1st({super.key});

  @override
  State<SignUpRoute_1st> createState() => _SignUpRoute_1stState();
}

class _SignUpRoute_1stState extends State<SignUpRoute_1st> {
  final authService = AuthService();

  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _suffixController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _suffixController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
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
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: YellowBackButton(),
                  ),
                ),
                TitleText(title: 'Foodie', color: c_pri_yellow),
                Heading3_Text(text: 'Welcome to Foodie!', color: c_pri_yellow),
                bodyText(text: 'Create your account', color: c_pri_yellow),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputTextField(hintText: 'First Name', labelText: 'First Name', controller: _firstNameController),
                        const SizedBox(height: 15),
                        InputTextField(hintText: 'Middle Name', labelText: 'Middle Name', controller: _middleNameController),
                        const SizedBox(height: 15),
                        InputTextField(hintText: 'Last Name', labelText: 'Last Name', controller: _lastNameController),
                        const SizedBox(height: 15),
                        InputTextField(hintText: 'Suffix (Optional)', labelText: 'Suffix', controller: _suffixController),
                        const SizedBox(height: 15),
                        InputTextField(hintText: 'Phone Number', labelText: 'Phone Number', controller: _phoneController),
                        const SizedBox(height: 15),
                        InputTextField(hintText: 'Email', labelText: 'Email', controller: _emailController),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: NormalButton(
            buttonName: 'Next',
            backgroundColor: c_pri_yellow,
            fontColor: c_white,
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpRoute_2nd(
                      email: _emailController.text.trim(),
                      firstName: _firstNameController.text.trim(),
                      middleName: _middleNameController.text.trim(),
                      lastName: _lastNameController.text.trim(),
                      suffix: _suffixController.text.trim(),
                      phone: _phoneController.text.trim(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpRoute_2nd extends StatefulWidget {
  final String email;
  final String firstName;
  final String middleName;
  final String lastName;
  final String suffix;
  final String phone;

  const SignUpRoute_2nd({
    super.key,
    required this.email,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.suffix,
    required this.phone,
  });

  @override
  State<SignUpRoute_2nd> createState() => _SignUpRoute_2ndState();
}

class _SignUpRoute_2ndState extends State<SignUpRoute_2nd> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> _handleSignUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      final authService = AuthService();
      final response =
          await authService.signUpWithEmailPassword(email, password);

      final user = response.user;

      if (user != null) {
        final supabase = Supabase.instance.client;

        await supabase.from('customers').insert({
          'id': user.id,
          'email': email,
          'first_name': widget.firstName,
          'middle_name': widget.middleName,
          'last_name': widget.lastName,
          'suffix': widget.suffix.isEmpty ? null : widget.suffix,
          'phone_number': widget.phone,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup successful!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SecondRoute()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign up failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: YellowBackButton(),
                  ),
                ),
                const SizedBox(height: 16),
                    TitleText(title: 'Foodie', color: c_pri_yellow),
                    Heading3_Text(text: 'Welcome!', color: c_pri_yellow),
                    bodyText(text: 'Create your account', color: c_pri_yellow),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.zero,  
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 15),
                      InputTextField(
                        hintText: 'Email',
                        labelText: 'Email',
                        controller: _emailController,
                        obscureText: false,
                      ),
                      const SizedBox(height: 15),
                      InputTextField(
                        hintText: 'Password',
                        labelText: 'Password',
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 15),
                      InputTextField(
                        hintText: 'Confirm Password',
                        labelText: 'Confirm Password',
                        controller: _confirmPasswordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 25),
                      NormalButton(
                        buttonName: 'Sign Up',
                        fontColor: c_white,
                        backgroundColor: c_pri_yellow,
                        onPressed: _handleSignUp,
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
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
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
  final ImagePicker _picker = ImagePicker();

  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _suffixController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  // Form validation state
  final Map<String, String> _errors = {};
  bool _hasAttemptedSubmit = false;

  File? _selectedImage;

  // Validation methods
  void _validateField(String fieldName, String value, String displayName) {
    setState(() {
      if (value.trim().isEmpty) {
        _errors[fieldName] = '$displayName is required';
      } else {
        _errors.remove(fieldName);
      }
    });
  }

  void _validateEmail(String email) {
    setState(() {
      if (email.trim().isEmpty) {
        _errors['email'] = 'Email is required';
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        _errors['email'] = 'Please enter a valid email address';
      } else {
        _errors.remove('email');
      }
    });
  }

  void _validatePhone(String phone) {
    setState(() {
      if (phone.trim().isEmpty) {
        _errors['phone'] = 'Phone number is required';
      } else if (phone.trim().length < 10) {
        _errors['phone'] = 'Phone number must be at least 10 digits';
      } else {
        _errors.remove('phone');
      }
    });
  }

  bool _isFormValid() {
    // Clear all errors first
    _errors.clear();
    
    // Validate all required fields
    _validateField('firstName', _firstNameController.text, 'First Name');
    _validateField('middleName', _middleNameController.text, 'Middle Name');
    _validateField('lastName', _lastNameController.text, 'Last Name');
    _validatePhone(_phoneController.text);
    _validateEmail(_emailController.text);
    
    return _errors.isEmpty;
  }

  void _handleNext() {
    setState(() {
      _hasAttemptedSubmit = true;
    });

    if (_isFormValid()) {
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
            profileImage: _selectedImage,
          ),
        ),
      );
    } else {
      // Show general error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all required fields correctly'),
          backgroundColor: Colors.red[400],
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    // Check if running on mobile (Android/iOS) or desktop
    if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      // For desktop/web platforms, show options but handle camera differently
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Photo Library'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _getImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _openCamera();
                  },
                ),
              ],
            ),
          );
        },
      );
    } else {
      // For mobile platforms, show standard options
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Photo Library'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _getImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Take Photo'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _openCamera();
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Future<void> _openCamera() async {
    try {
      if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        // For desktop/web platforms, show a dialog explaining camera access
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Camera Access'),
              content: Text(
                'Your camera will now open. Please allow camera access when prompted by your browser/system.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _getImage(ImageSource.camera);
                  },
                  child: Text('Open Camera'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      } else {
        // For mobile platforms, directly open camera
        _getImage(ImageSource.camera);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error accessing camera: $e')),
      );
    }
  }

  Future<void> _getImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 70,
        maxHeight: 500,
        maxWidth: 500,
        preferredCameraDevice: CameraDevice.front, // Default to front camera for profile pics
      );
      
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile picture selected successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Handle different types of errors
      String errorMessage = 'Error selecting image';
      
      if (e.toString().contains('camera_access_denied')) {
        errorMessage = 'Camera access denied. Please enable camera permissions.';
      } else if (e.toString().contains('photo_access_denied')) {
        errorMessage = 'Photo library access denied. Please enable photo permissions.';
      } else {
        errorMessage = 'Error: ${e.toString()}';
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red[400],
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // Helper widget to build input field with validation
  Widget _buildValidatedTextField({
    required String hintText,
    required String labelText,
    required TextEditingController controller,
    required String fieldKey,
    required Function(String) validator,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTextField(
          hintText: hintText,
          labelText: labelText,
          controller: controller,
          obscureText: obscureText,
        ),
        if (_hasAttemptedSubmit && _errors.containsKey(fieldKey))
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 12.0),
            child: Text(
              _errors[fieldKey]!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

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
                        // Profile Image Section
                        Center(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: c_pri_yellow,
                                      width: 3,
                                    ),
                                  ),
                                  child: _selectedImage != null
                                      ? ClipOval(
                                          child: Image.file(
                                            _selectedImage!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Icon(
                                          Icons.add_a_photo,
                                          size: 40,
                                          color: Colors.grey[600],
                                        ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tap to add profile picture (Optional)',
                                style: TextStyle(
                                  color: c_pri_yellow,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        
                        // Form fields with validation
                        _buildValidatedTextField(
                          hintText: 'First Name',
                          labelText: 'First Name *',
                          controller: _firstNameController,
                          fieldKey: 'firstName',
                          validator: (value) => _validateField('firstName', value, 'First Name'),
                        ),
                        const SizedBox(height: 15),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputTextField(
                              hintText: 'Middle Name',
                              labelText: 'Middle Name',
                              controller: _middleNameController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        
                        _buildValidatedTextField(
                          hintText: 'Last Name',
                          labelText: 'Last Name *',
                          controller: _lastNameController,
                          fieldKey: 'lastName',
                          validator: (value) => _validateField('lastName', value, 'Last Name'),
                        ),
                        const SizedBox(height: 15),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputTextField(
                              hintText: 'Suffix (Optional)',
                              labelText: 'Suffix',
                              controller: _suffixController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        
                        _buildValidatedTextField(
                          hintText: 'Phone Number',
                          labelText: 'Phone Number *',
                          controller: _phoneController,
                          fieldKey: 'phone',
                          validator: (value) => _validatePhone(value),
                        ),
                        const SizedBox(height: 15),
                        
                        _buildValidatedTextField(
                          hintText: 'Email',
                          labelText: 'Email *',
                          controller: _emailController,
                          fieldKey: 'email',
                          validator: (value) => _validateEmail(value),
                        ),
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
              onPressed: _handleNext,
            ),
          ),
        ],
      ),
    );
  }
}

// Keep the SignUpRoute_2nd class unchanged
class SignUpRoute_2nd extends StatefulWidget {
  final String email;
  final String firstName;
  final String middleName;
  final String lastName;
  final String suffix;
  final String phone;
  final File? profileImage;

  const SignUpRoute_2nd({
    super.key,
    required this.email,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.suffix,
    required this.phone,
    this.profileImage,
  });

  @override
  State<SignUpRoute_2nd> createState() => _SignUpRoute_2ndState();
}

class _SignUpRoute_2ndState extends State<SignUpRoute_2nd> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<String?> _uploadProfileImage(String userId) async {
    if (widget.profileImage == null) return null;

    try {
      final supabase = Supabase.instance.client;
      final bytes = await widget.profileImage!.readAsBytes();
      final fileExt = widget.profileImage!.path.split('.').last.toLowerCase();
      final fileName = 'profile_$userId.${fileExt}';
      final filePath = 'profiles/$fileName';
      
      // Upload to Supabase Storage using the File directly
      await supabase.storage.from('user-images').upload(
        filePath,
        widget.profileImage!,  // Pass the File object directly
        fileOptions: FileOptions(
          cacheControl: '3600',
          upsert: true,
          contentType: _getContentType(fileExt),
        ),
      );

      // Get the public URL
      final imageUrl = supabase.storage.from('user-images').getPublicUrl(filePath);
      
      print('Image uploaded successfully: $imageUrl');
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      
      // Show user-friendly error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload profile picture. Please try again.'),
          backgroundColor: Colors.red[400],
        ),
      );
      return null;
    }
  }

  String _getContentType(String fileExtension) {
    switch (fileExtension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'image/jpeg'; // Default fallback
    }
  }

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
        // Show loading indicator
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                SizedBox(width: 16),
                Text('Creating account and uploading image...'),
              ],
            ),
            duration: Duration(seconds: 10),
          ),
        );

        // Upload profile image if selected
        String? imageUrl;
        if (widget.profileImage != null) {
          imageUrl = await _uploadProfileImage(user.id);
        }

        final supabase = Supabase.instance.client;

        // Insert user data with image URL
        await supabase.from('customers').insert({
          'id': user.id,
          'email': email,
          'first_name': widget.firstName,
          'middle_name': widget.middleName,
          'last_name': widget.lastName,
          'suffix': widget.suffix.isEmpty ? null : widget.suffix,
          'phone_number': widget.phone,
          'image_url': imageUrl,
          'created_at': DateTime.now().toIso8601String(),
        });

        // Clear the loading snackbar
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Account created successfully!'),
            backgroundColor: Colors.green,
          ),
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
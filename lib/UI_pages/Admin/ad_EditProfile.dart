import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'package:foodie_app/Utilities/utilities_texts.dart';
import '../../Utilities/utilities_buttons.dart';
import 'package:foodie_app/Utilities/utilities_others.dart';

class AdminEditProfile extends StatefulWidget {
  @override
  State<AdminEditProfile> createState() => _AdminEditProfileState();
}

class _AdminEditProfileState extends State<AdminEditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController suffixController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    final response = await Supabase.instance.client
        .from('admins')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (response != null) {
      setState(() {
        firstNameController.text = response['first_name'] ?? '';
        middleNameController.text = response['middle_name'] ?? '';
        lastNameController.text = response['last_name'] ?? '';
        suffixController.text = response['suffix'] ?? '';
        phoneController.text = response['phone_number'] ?? '';
        emailController.text = response['email'] ?? '';
        roleController.text = response['role'] ?? '';
        _imageUrl = response['image_url'];
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) return;

      final updates = {
        'first_name': firstNameController.text.trim(),
        'middle_name': middleNameController.text.trim(),
        'last_name': lastNameController.text.trim(),
        'suffix': suffixController.text.trim(),
        'phone_number': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'role': roleController.text.trim(),
        'image_url': _imageUrl, // Will be null if removed
      };

      await Supabase.instance.client
          .from('admins')
          .update(updates)
          .eq('id', userId);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );

      Navigator.pop(context, true);
    }
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    bool requiredField = false,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bodyText(text: label, color: c_pri_yellow),
          SizedBox(height: 4),
          TextFormField(
            controller: controller,
            enabled: enabled,
            validator: requiredField
                ? (value) =>
                    value == null || value.trim().isEmpty ? 'Required' : null
                : null,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: c_sec_yellow),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: c_pri_yellow),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    suffixController.dispose();
    phoneController.dispose();
    emailController.dispose();
    roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            TitleSectionButton(
              leftmost: YellowBackButton(),
              left: Heading4_Text(text: 'Edit Profile', color: c_pri_yellow),
            ),
            SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundImage: _imageUrl != null
                                ? NetworkImage(_imageUrl!)
                                : AssetImage(
                                        'lib/images/admin_default_profile.png')
                                    as ImageProvider,
                          ),
                          if (_imageUrl != null)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: Icon(Icons.close,
                                      size: 16, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      _imageUrl = null;
                                    });
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 12),
                      ImageUploader(
                        initialImageUrl: _imageUrl,
                        onImageUploaded: (url) {
                          setState(() {
                            _imageUrl = url;
                          });
                        },
                      ),
                      SizedBox(height: 12),
                      buildTextField(
                          label: 'First Name',
                          controller: firstNameController,
                          requiredField: true),
                      buildTextField(
                          label: 'Middle Name',
                          controller: middleNameController,
                          requiredField: true),
                      buildTextField(
                          label: 'Last Name',
                          controller: lastNameController,
                          requiredField: true),
                      buildTextField(
                          label: 'Suffix', controller: suffixController),
                      buildTextField(label: 'Role', controller: roleController),
                      buildTextField(
                          label: 'Phone Number',
                          controller: phoneController,
                          requiredField: true),
                      buildTextField(
                          label: 'Email',
                          controller: emailController,
                          requiredField: true),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ActionButton(
                buttonName: 'Save Changes',
                backgroundColor: c_pri_yellow,
                onPressed: _saveProfile,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import 'package:foodie_app/Utilities/utilities_texts.dart';
import '../../Utilities/utilities_buttons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerEditProfile extends StatefulWidget {
  @override
  State<CustomerEditProfile> createState() => _CustomerEditProfileState();
}

class _CustomerEditProfileState extends State<CustomerEditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController suffixController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    final response = await Supabase.instance.client
        .from('customers')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (response != null) {
      setState(() {
        // Add Profile Pic
        firstNameController.text = response['first_name'] ?? '';
        middleNameController.text = response['middle_name'] ?? '';
        lastNameController.text = response['last_name'] ?? '';
        suffixController.text = response['suffix'] ?? '';
        phoneController.text = response['phone_number'] ?? '';
        emailController.text = response['email'] ?? '';
        addressController.text = response['address'] ?? '';
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) return;

      final updates = {
        // Add Profile Pic
        'first_name': firstNameController.text.trim(),
        'middle_name': middleNameController.text.trim(),
        'last_name': lastNameController.text.trim(),
        'suffix': suffixController.text.trim(),
        'phone_number': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'address': addressController.text.trim(),
      };

      await Supabase.instance.client
          .from('customers')
          .update(updates)
          .eq('id', userId);

      if (!mounted) return;
    
      Navigator.pop(context, true);
    }
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    bool requiredField = false,
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
    addressController.dispose();
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
                      // Add Profile Pic
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
                          label: 'Suffix',
                          controller: suffixController,
                          requiredField: false),
                      buildTextField(
                          label: 'Phone Number',
                          controller: phoneController,
                          requiredField: true),
                      buildTextField(
                          label: 'Email',
                          controller: emailController,
                          requiredField: true),
                      buildTextField(
                          label: 'Address',
                          controller: addressController,
                          requiredField: false),
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

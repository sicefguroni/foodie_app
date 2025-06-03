import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_others.dart';
import '../../Utilities/utilities_texts.dart';
import '../Opening/Second_Route.dart';
import 'cust_EditProfile.dart';

class CustomerProfilePage extends StatefulWidget {
  @override
  _CustomerProfilePageState createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  Map<String, dynamic>? profileData;
  bool isLoading = true;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  String customerFirstName = '';

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      setState(() => isLoading = false);
      return;
    }

    final data = await Supabase.instance.client
        .from('customers')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (data != null) {
      // Add Profile Pic
      final firstName = data['first_name'] ?? '';
      final middleName = data['middle_name'] ?? '';
      final lastName = data['last_name'] ?? '';

      setState(() {
        profileData = data;
        isLoading = false;
        customerFirstName = firstName;

        nameController.text = [firstName, middleName, lastName]
            .where((s) => s.isNotEmpty)
            .join(' ');
        emailController.text = user.email ?? '';
        phoneController.text = data['phone_number'] ?? '';
        addressController.text = data['address'] ?? '';
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: c_pri_yellow,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TitleSectionButton(
                    leftmost: WhiteBackButton(),
                    left: Heading4_Text(text: 'Profile', color: c_white),
                    rightmost: IconButton(
                      onPressed: () async {
                        final updated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CustomerEditProfile()),
                        );
                        if (updated == true) {
                          await fetchProfile();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Profile updated')),
                          );
                        }
                      },
                      icon: Icon(Icons.edit),
                      color: c_white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomerAvatar(
                            assetName: 'lib/images/opening-image.png',
                            radius: 40),
                        Heading4_Text(
                          text: customerFirstName.isNotEmpty
                              ? customerFirstName
                              : 'Customer',
                          color: c_white,
                        ),
                        bodyText(text: 'Welcome!', color: c_white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        // Add Profile Pic
                        _buildReadOnlyField('Name', nameController),
                        _buildReadOnlyField('Email', emailController),
                        _buildReadOnlyField('Phone Number', phoneController),
                        _buildReadOnlyField('Address', addressController),
                      ],
                    ),
                    NormalButton(
                      buttonName: 'Logout',
                      fontColor: c_pri_yellow,
                      backgroundColor: c_white,
                      outlineColor: c_pri_yellow,
                      onPressed: () async {
                        await Supabase.instance.client.auth.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondRoute()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bodyText(text: label, color: c_pri_yellow),
          SizedBox(height: 4),
          TextField(
            readOnly: true,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
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
}

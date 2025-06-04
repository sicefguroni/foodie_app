import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:foodie_app/Utilities/color_palette.dart';
import '../../Utilities/utilities_buttons.dart';
import '../../Utilities/utilities_texts.dart';
import '../Opening/Second_Route.dart';
import 'ad_EditProfile.dart';

class AdminProfilePage extends StatefulWidget {
  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  bool isLoading = true;
  String? profileUrl;
  String adminFirstName = '';
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final roleController = TextEditingController();

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
        .from('admins')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (data != null) {
      final fetchedProfileUrl = data['image_url'] ?? '';
      final firstName = data['first_name'] ?? '';
      final middleName = data['middle_name'] ?? '';
      final lastName = data['last_name'] ?? '';

      setState(() {
        profileUrl = fetchedProfileUrl;
        adminFirstName = firstName;
        nameController.text = [firstName, middleName, lastName]
            .where((s) => s.isNotEmpty)
            .join(' ');
        emailController.text = user.email ?? '';
        phoneController.text = data['phone_number'] ?? '';
        roleController.text = data['role'] ?? '';
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    roleController.dispose();
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
            _buildHeader(context),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        _buildReadOnlyField('Name', nameController),
                        _buildReadOnlyField('Role', roleController),
                        _buildReadOnlyField('Email', emailController),
                        _buildReadOnlyField('Phone Number', phoneController),
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
                          MaterialPageRoute(builder: (_) => SecondRoute()),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: c_pri_yellow,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
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
                  MaterialPageRoute(builder: (_) => AdminEditProfile()),
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
              children: [
                buildProfileImage(profileUrl),
                SizedBox(height: 8),
                Heading4_Text(
                  text: adminFirstName.isNotEmpty
                      ? adminFirstName
                      : 'Admin',
                  color: c_white,
                ),
                bodyText(text: 'Welcome!', color: c_white),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileImage(String? imageUrl) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: (imageUrl != null && imageUrl.isNotEmpty)
              ? NetworkImage(imageUrl)
              : AssetImage('lib/images/admin_default_profile.png')
                  as ImageProvider,
          fit: BoxFit.cover,
        ),
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
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

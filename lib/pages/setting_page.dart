import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/home/bottom_menu.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile_app/pages/profile_page.dart';
import 'package:mobile_app/pages/signin_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 102, 86),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
         onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavBar(),
              ),
            );
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Profile'),
            const Divider(height: 5, color: Colors.black,),
            _buildListItem(
              context,
              Icons.account_circle,
              'Update Profile',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            ),
            const Divider(height: 5, color: Colors.black,),
            _buildSectionTitle('Preferences'),
            const Divider(height: 5, color: Colors.black,),
            _buildListItem(
              context,
              Icons.info,
              'About Us',
              () {
                _launchURL('https://www.google.com');
              },
            ),
            _buildListItem(
              context,
              Icons.description,
              'Terms & Conditions',
              () {
                _launchURL('https://www.google.com');
              },
            ),
            _buildListItem(
              context,
              Icons.privacy_tip,
              'Privacy Policy',
              () {
                _launchURL('https://www.google.com');
              },
            ),
            const Divider(height: 5, color: Colors.black,),
            _buildSectionTitle('Account'),
            const Divider(height: 5, color: Colors.black,),
            _buildListItem(
              context,
              Icons.exit_to_app_outlined,
              'Logout',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0), 
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }

  _launchURL(String url) async {
    final Uri url = Uri.parse('https://www.google.com');
   if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
    }
  }
}

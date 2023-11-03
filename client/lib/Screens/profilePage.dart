import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'aboutBarangay.dart';
import 'feedbackpage.dart';
import 'requestSummary.dart';
import '../Screens/Profile/editProfile.dart';
import '../../Screens/Login/login_screen.dart';

class ProfilePage extends StatefulWidget {
  final String? token;

  const ProfilePage({Key? key, this.token}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? firstName;
  String? middleName;
  String? lastName;
  String? suffix;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      final Map<String, dynamic> userData = JwtDecoder.decode(widget.token!);
      print('User Data: $userData');

      if (userData.containsKey('filename')) {
        final Map<String, dynamic> filenameData = userData['filename'];
        print('Image URL from userData: ${filenameData['url']}');
        imageUrl = filenameData['url'];
      }

      firstName = userData['firstName'];
      middleName = userData['middleName'];
      lastName = userData['lastName'];
      suffix = userData['suffix'];
    }
  }

  Widget buildProfileImage() {
    if (imageUrl != null) {
      print('Image URL: $imageUrl');
      return SizedBox(
        width: 120,
        height: 120,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(imageUrl!),
        ),
      );
    } else {
      print('Image URL is null');
      return SizedBox(
        width: 120,
        height: 120,
        child: Image.asset('assets/images/bot.png'),
      );
    }
  }

  Widget buildButton(String text, void Function()? onPressed) {
    return SizedBox(
      width: 150,
      height: 30,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildMenuTile(IconData icon, String title, void Function() onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 2, 95, 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildProfileImage(),
            const SizedBox(height: 10),
            Text(
              '$firstName $middleName $lastName $suffix',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            buildButton('Edit Profile', () {
              if (widget.token?.isNotEmpty == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditIconPage(token: widget.token),
                  ),
                );
              } else {
                print('Token is null or empty. Cannot proceed.');
              }
            }),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 228, 228),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildMenuTile(Icons.info, 'About Barangay', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutBarangayPage(),
                        ),
                      );
                    }),
                    buildMenuTile(Icons.view_list, 'View Request', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RequestSummary(token: widget.token),
                        ),
                      );
                    }),
                    buildMenuTile(Icons.feedback, 'Send Feedback', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FeedbackPage(token: widget.token),
                        ),
                      );
                    }),
                    buildMenuTile(Icons.logout, 'Logout', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(token: null),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

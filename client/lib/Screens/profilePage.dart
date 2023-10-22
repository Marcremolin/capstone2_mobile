import 'package:client/Screens/feedbackpage.dart';
import 'package:flutter/material.dart';
import 'aboutBarangay.dart';
import '../Screens/Profile/editProfile.dart';
import 'requestSummary.dart';
import '../../Screens/Login/login_screen.dart';

class ProfilePage extends StatefulWidget {
  final String? token;
  const ProfilePage({Key? key, this.token}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
//------------------------------------------------------------------------------------------------------------

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      print('Token in ProfilePage: ${widget.token}');
    } else {
      print('Token in ProfilePage is null');
    }
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
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: const Image(
                  image: AssetImage('assets/images/Announcement1.jpg'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'PROFILE NAME',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 150,
              height: 30,
              child: ElevatedButton(
// ------------------------ TOKEN FOR EditIconPage ------------------------------------------------
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditIconPage(token: widget.token), //TOKEN TO PASS
                    ),
                  );
                },
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
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
                    ListTile(
                      leading: const Icon(Icons.info, color: Colors.black),
                      title: const Text('About Barangay',
                          style: TextStyle(color: Colors.black)),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.black),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutBarangayPage()),
                        );
                      },
                    ),
                    // REQUEST SUMMARY ------------------------------------------------------------------------------------
                    ListTile(
                      leading: const Icon(Icons.view_list, color: Colors.black),
                      title: const Text('View Request',
                          style: TextStyle(color: Colors.black)),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.black),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RequestSummary(
                                token: widget.token), //TOKEN TO PASS
                          ),
                        );
                      },
                    ),
                    // FEEDBACK ------------------------------------------------------------------------------------
                    ListTile(
                      leading: const Icon(Icons.feedback, color: Colors.black),
                      title: const Text('Send Feedback',
                          style: TextStyle(color: Colors.black)),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.black),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeedbackPage(
                                token: widget.token), //TOKEN TO PASS
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.black),
                      title: const Text('Logout',
                          style: TextStyle(color: Colors.black)),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.black),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen(
                                    token: null,
                                  )),
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
}

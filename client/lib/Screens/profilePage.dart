// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'aboutBarangay.dart';
import 'feedbackpage.dart';
import 'requestSummary.dart';
import '../Screens/Profile/editProfile.dart';
import '../../Screens/Login/login_screen.dart';
import 'package:http/http.dart' as http;

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
  File? selectedProfilePicture;

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
      return Column(
        // Wrap the content in a Column
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                  '$imageUrl?timestamp=${DateTime.now().millisecondsSinceEpoch}'),
            ),
          ),
          const SizedBox(height: 10),
        ],
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

  void updateProfilePicture() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedProfilePicture = File(result.files.first.path!);
      });

      try {
        var url = Uri.parse(
            'https://dbarangay-mobile-e5o1.onrender.com/updateProfile');

        var request = http.MultipartRequest('POST', url);
        request.files.add(
          await http.MultipartFile.fromPath(
            'userImage',
            selectedProfilePicture!.path,
          ),
        );

        request.headers['Authorization'] = 'Bearer ${widget.token}';

        var response = await request.send();

        print('Response status code: ${response.statusCode}');

        if (response.statusCode == 200) {
          final responseJson = await response.stream.bytesToString();
          final parsedResponse = json.decode(responseJson);

          if (parsedResponse != null && parsedResponse['filename'] != null) {
            // Parse the Cloudinary response and update the UI
            setState(() {
              imageUrl = parsedResponse['filename']['url'];
            });
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: const Text(
                    'Failed to update profile picture. Please try again later.',
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        } else {
          // Handle HTTP error from the backend
          print('HTTP Error: ${response.statusCode}');
          print(await response.stream.bytesToString());
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text(
                  'Failed to update profile picture. Please try again later.',
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        // Handle other errors
        print('Error: $e');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('An error occurred. Please try again later.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  Widget buildButton(String text, void Function()? onPressed) {
    return SizedBox(
      width: 200,
      height: 40,
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
            buildButton('View Profile', () {
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
            buildButton('Update Profile Picture', () {
              updateProfilePicture();
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

// ignore_for_file: avoid_print

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
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(imageUrl!),
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

  Widget buildEditImageButton() {
    return SizedBox(
      width: 200,
      height: 40,
      child: ElevatedButton(
        onPressed: updateProfilePicture,
        child: const Text(
          'Edit User Image',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
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

  Future<void> updateProfilePicture() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File imageFile = File(result.files.single.path!);

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('https://dbarangay-mobile-e5o1.onrender.com/updateUserImage'),
      );
      // Verify and format the token
      String? formattedToken = widget.token;
      if (!formattedToken!.startsWith("Bearer ")) {
        formattedToken = "Bearer $formattedToken";
      }

      request.headers['Authorization'] = formattedToken;
      request.files
          .add(await http.MultipartFile.fromPath('userImage', imageFile.path));

      try {
        var response = await request.send();

        if (response.statusCode == 200) {
          final responseJson = await response.stream.bytesToString();
          final responseData = json.decode(responseJson);

          if (responseData['status'] == true) {
            String newImageUrl = responseData['user']['userImage'];
            setState(() {
              imageUrl = newImageUrl;
            });

            updateSuccessDialog();
          } else {
            print('Failed to update user image.');
          }
        } else {
          print(
              'Failed to update user image. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error during image upload: $error');
      }
    }
  }

  // Future<void> updateProfilePicture() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //   );

  //   if (result != null) {
  //     File imageFile = File(result.files.single.path!);

  //     var request = http.MultipartRequest(
  //       'PUT',
  //       Uri.parse('https://dbarangay-mobile-e5o1.onrender.com/updateUserImage'),
  //     );

  //     request.files
  //         .add(await http.MultipartFile.fromPath('userImage', imageFile.path));

  //     try {
  //       var response = await request.send();

  //       if (response.statusCode == 200) {
  //         final responseJson = await response.stream.bytesToString();
  //         final responseData = json.decode(responseJson);

  //         if (responseData['status'] == true) {
  //           String newImageUrl = responseData['user']['userImage'];
  //           setState(() {
  //             imageUrl = newImageUrl;
  //           });

  //           updateSuccessDialog();
  //         } else {
  //           print('Failed to update user image.');
  //         }
  //       } else {
  //         print(
  //             'Failed to update user image. Status code: ${response.statusCode}');
  //       }
  //     } catch (error) {
  //       print('Error during image upload: $error');
  //     }
  //   }
  // }

  void updateSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Text(
                    'PROFILE PICTURE UPDATED SUCCESFULLY!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Center(
                  child: Text(
                    'Your profile picture has been updated.',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
            const SizedBox(height: 10),
            buildEditImageButton(),
            const SizedBox(height: 10),
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

// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../Screens/Homepage/bottom_nav.dart';
// iMPORTANT IMPORTS
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfile extends StatefulWidget {
  final token;
  const EditProfile({Key? key, this.token}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Map<String, dynamic>? userData;
  String? firstName;
  String? lastName;
  String? middleName;
  String? houseNumber;
  String? barangay;
  String? district;
  String? city;
  String? region;
  String? nationality;
  String? birthplace;
  String? dateOfBirth;
  String? age;
  String? civilStatus;
  String? highestEducation;
  String? employmentStatus;
  String? gender;
  String? homeOwnership;
  String? residentClass;
  String? email;
  String? votersRegistration;
  String? suffix;
  String? companyName;
  String? position;
  String? secondNumber;

  @override
  void initState() {
    super.initState();
    final token = widget.token;
    if (token != null && token.isNotEmpty) {
      // Decode the token and fetch user data
      try {
        userData = JwtDecoder.decode(token);
        if (userData != null) {
          // Now you can access user data from the decoded token
          print("Received token: $userData");

          // Fetch user profile data after decoding the token
          fetchUserProfileData(token);
        } else {
          print("Token is not a valid JWT.");
        }
      } catch (e) {
        print("Error decoding token: $e");
      }
    } else {
      print("Token is null or empty.");
    }
  }

// Function to fetch user profile data
  Future<void> fetchUserProfileData(String token) async {
    const apiUrl =
        'http://192.168.0.28:8000/profile'; // Replace with your API URL
    print('Token: ${widget.token}');

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        // Process the fetched user profile data
        final lastName = jsonResponse['lastName'];
        final firstName = jsonResponse['firstName'];
        final middleName = jsonResponse['middleName'];
        final houseNumber = jsonResponse['houseNumber'];
        final barangay = jsonResponse['barangay'];
        final district = jsonResponse['district'];
        final city = jsonResponse['city'];
        final region = jsonResponse['region'];
        final nationality = jsonResponse['nationality'];
        final birthplace = jsonResponse['birthplace'];
        final dateOfBirth = jsonResponse['dateOfBirth'];
        final age = jsonResponse['age'];
        final civilStatus = jsonResponse['civilStatus'];
        final highestEducation = jsonResponse['highestEducation'];
        final employmentStatus = jsonResponse['employmentStatus'];
        final gender = jsonResponse['gender'];
        final homeOwnership = jsonResponse['homeOwnership'];
        final residentClass = jsonResponse['residentClass'];
        final email = jsonResponse['email'];
        final votersRegistration = jsonResponse['votersRegistration'];
        final suffix = jsonResponse['suffix'];
        final companyName = jsonResponse['companyName'];
        final position = jsonResponse['position'];
        final secondNumber = jsonResponse['secondNumber'];

        // Extract other user profile data fields as needed

        // You can setState to update the UI with the fetched data
        setState(() {
          this.firstName = jsonResponse['firstName'];
          this.lastName = jsonResponse['lastName'];
          this.middleName = jsonResponse['middleName'];
          this.houseNumber = jsonResponse['houseNumber'];
          this.barangay = jsonResponse['barangay'];
          this.district = jsonResponse['district'];
          this.city = jsonResponse['city'];
          this.region = jsonResponse['region'];
          this.nationality = jsonResponse['nationality'];
          this.birthplace = jsonResponse['birthplace'];
          this.dateOfBirth = jsonResponse['dateOfBirth'];
          this.age = jsonResponse['age'];
          this.civilStatus = jsonResponse['civilStatus'];
          this.highestEducation = jsonResponse['highestEducation'];
          this.employmentStatus = jsonResponse['employmentStatus'];
          this.gender = jsonResponse['gender'];
          this.homeOwnership = jsonResponse['homeOwnership'];
          this.residentClass = jsonResponse['residentClass'];
          this.email = jsonResponse['email'];
          this.votersRegistration = jsonResponse['votersRegistration'];
          this.suffix = jsonResponse['suffix'];
          this.companyName = jsonResponse['companyName'];
          this.position = jsonResponse['position'];
          this.secondNumber = jsonResponse['secondNumber'];

          // Update other relevant state variables
        });
      } else {
        print('Failed to fetch user profile data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user profile data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'RESIDENCE PROFILE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),

            //display the user's First Name and Last Name in a read-only form. This code assumes that you have fetched the user's profile data and populated the firstName and lastName variables with the user's actual data.
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['firstName'] ??
                  '', // Populate with user's first name
              decoration: InputDecoration(
                hintText: "$firstName",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue:
                  userData?['lastName'] ?? '', // Populate with user's last name
              decoration: const InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['middleName'] ?? '',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['suffix'] ?? '',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),

// Address Fields (2 Columns)
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      initialValue: userData?['houseNumber'] ?? '',
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.home),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      initialValue: userData?['city'] ?? '',
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.home),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      initialValue: userData?['street'] ?? '',
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.home),
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),

              // 2nd Column
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      initialValue: userData?['barangay'] ?? '',
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.home),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      initialValue: userData?['district'] ?? '',
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.home),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      initialValue: userData?['region'] ?? '',
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.home),
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ],
          ),

          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),

// PERSONAL INFORMATION -----------------------------------------------------------
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'PERSONAL INFORMATION',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),

// GENDER
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),

// CIVIL STATUS
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),

// NATIONALITY
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['nationality'] ?? '',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),

// BIRTHPLACE
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['birthplace'] ?? '',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),

// AGE
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['age'] ?? '',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),

// Highest Educational Attainment
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['highestEducation'] ?? '',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.school),
              ),
            ),
          ),

// Employment Status
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['employmentStatus'] ?? '',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.work),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['companyName'] ?? '',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.business),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['position'] ?? '',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),

// HOME OWNERSHIP
          const SizedBox(height: defaultPadding),
          const Text(
            'HOME OWNERSHIP',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['isOwner'] == true ? "Owner" : "Renting",
              decoration: const InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.home),
                ),
              ),
            ),
          ),

// CONTACT INFORMATION
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'CONTACT DETAILS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),

// PHONE NUMBER
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['phoneNumber'] ?? '',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),

// 2nd Number (Optional)
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['secondNumber'] ?? '',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),

// Email Address
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['email'] ?? '',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),

// OTHER INFORMATION
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'OTHER INFORMATION',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),

          const SizedBox(height: defaultPadding),

// RESIDENT CLASS
          const Text(
            'RESIDENT CLASS',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['residentClass'] ?? '',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),

// Voters Registration Number
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: userData?['votersRegistration'] ?? '',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const BottomNav();
                  },
                ),
              );
            },
            child: Text("Save".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}

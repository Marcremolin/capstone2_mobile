// ignore_for_file: unused_local_variable, avoid_print, library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../Screens/Homepage/bottom_nav.dart';
// iMPORTANT IMPORTS
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  final token;
  const EditProfile({super.key, required this.token});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Map<String, dynamic> userProfile = {};

  Future<void> fetchUserProfile() async {
    var token = widget.token;
    if (token.startsWith('Bearer ')) {
      token = token.substring(7);
    }

    try {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
      final response = await http.get(
        Uri.parse('http://192.168.0.28:8000/profile/user'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (jwtDecodedToken['_id'] == data['_id']) {
          if (data.containsKey('lastName') &&
              data.containsKey('firstName') &&
              data.containsKey('email') &&
              data.containsKey('phoneNumber')) {
            setState(() {
              userProfile = data;
            });
          } else {
            print('Incomplete or unexpected user profile data: $data');
          }
        } else {
          print('User ID from token does not match the user profile data.');
        }
      } else {
        print(
            'Failed to load user profile. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Widget buildTextFormField(String fieldName, String initialValue) {
    return Row(
      children: [
        Container(
          width: 120,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            '$fieldName:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              initialValue: initialValue,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String dateOfBirthString = userProfile['dateOfBirth']; // FOR DATE OF BIRTH
    DateTime dateOfBirth = DateTime.parse(dateOfBirthString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateOfBirth);

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Resident USER ID:  ${userProfile['_id']}',
              style: const TextStyle(
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
          const SizedBox(height: 8),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'RESIDENCE PROFILE',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const SizedBox(height: 8),

          buildTextFormField('Last Name', userProfile['lastName']),
          buildTextFormField('First Name', userProfile['firstName']),
          buildTextFormField('Middle Name', userProfile['middleName']),
          buildTextFormField('Suffix', userProfile['suffix']),
          const SizedBox(height: 12),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          // ---------------- ADDRESS ----------------
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'COMPLETE ADDRESS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const SizedBox(height: 8),

          Column(
            children: [
              buildTextFormField('House Number', userProfile['houseNumber']),
              buildTextFormField('Barangay', userProfile['barangay']),
              buildTextFormField('City', userProfile['cityMunicipality']),
              buildTextFormField('District', userProfile['district']),
              buildTextFormField('Province', userProfile['province']),
              buildTextFormField('Region', userProfile['region']),
              const SizedBox(height: 18),
            ],
          ),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
// PERSONAL INFORMATION -----------------------------------------------------------
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'PERSONAL INFORMATION',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const SizedBox(height: 8),
          buildTextFormField('Gender', userProfile['sex']),
          buildTextFormField('Civil Status', userProfile['civilStatus']),
          buildTextFormField('Nationality', userProfile['nationality']),
          buildTextFormField('Date of Birth', formattedDate),
          buildTextFormField('BirthPlace', userProfile['birthPlace']),
          buildTextFormField('Age', userProfile['age'].toString()),
          buildTextFormField('Company Name', userProfile['companyName']),
          buildTextFormField('Position', userProfile['position']),
          buildTextFormField('Home Ownership', userProfile['homeOwnership']),
          const SizedBox(height: 8),

// CONTACT INFORMATION
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'CONTACT INFORMATION',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const SizedBox(height: 8),
          buildTextFormField('Phone Number', userProfile['phoneNumber']),
          buildTextFormField('Email', userProfile['email']),
          const SizedBox(height: 8),

// OTHER INFORMATION
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'OTHER INFORMATION',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const SizedBox(height: 8),

          buildTextFormField('Resident Class', userProfile['residentClass']),
          buildTextFormField(
              'Voters Number', userProfile['votersRegistration']),
          buildTextFormField('Status', userProfile['status']),

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

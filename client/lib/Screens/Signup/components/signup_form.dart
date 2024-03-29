// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print, missing_required_param, library_private_types_in_public_api

import 'package:client/Screens/Login/components/already_have_an_account_acheck.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//FOR EMAIL VALIDATION
import 'dart:io';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class ComplianceItem {
  final String title;
  final String description;
  ComplianceItem({required this.title, required this.description});
}

// Privacy compliance data
final List<ComplianceItem> complianceItems = [
  ComplianceItem(
    title: "Data Collection",
    description:
        "When you register on the Barangay Harapin ang Bukas App, we collect certain personal information to facilitate your access and usage of our services. This includes, but is not limited to, your name, address, contact information, and other relevant details required for registration.",
  ),
  ComplianceItem(
    title: "Data Usage",
    description:
        "We use the information you provide during registration solely for the purpose of enabling you to access and use the features and services offered by the app. Your data will not be used for any other purpose without your explicit consent.",
  ),
  ComplianceItem(
      title: "Data Security",
      description:
          "We implement robust security measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction. These measures include data encryption, access controls, and regular security assessments"),
  ComplianceItem(
      title: "Data Retention",
      description:
          "Your personal data will be retained for as long as necessary to fulfill the purposes for which it was collected, or as required by applicable laws and regulations. We will delete your data when it is no longer needed."),
  ComplianceItem(
    title: "User Rights",
    description:
        "You have the right to access, correct, delete, or export your personal data stored on our app. If you have any such requests or inquiries, please contact us through the provided channels.",
  ),
  ComplianceItem(
    title: "Consent Mechanism",
    description:
        "By registering on the BARANGAY HARAPIN ANG BUKAS App, you give your informed consent for the collection and use of your personal information as outlined in this statement.",
  ),
  ComplianceItem(
    title: "Data Breach Response",
    description:
        "In the unlikely event of a data breach, we have a comprehensive data breach response plan in place. We will promptly notify affected individuals and relevant authorities as required by law.",
  ),
  ComplianceItem(
    title: "Third-Party Vendors",
    description:
        "We may use third-party services to enhance the functionality of our app. Rest assured, any third-party service providers we engage with are carefully selected and vetted for their commitment to data protection and privacy compliance.",
  ),
  ComplianceItem(
    title: "Updates and Amendments",
    description:
        "We will regularly review and update this Privacy Compliance Statement to stay in compliance with changing privacy laws and best practices. Any significant changes will be communicated to you through the app.",
  ),
];

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final dateController = TextEditingController();
  String? selectedDate;
  String? selectedImage;

  bool _checkBoxValue1 = false;
  bool _checkBoxValue2 = false;
  bool _homeOwnershipValue1 = false;
  bool _homeOwnershipValue2 = false;
  bool _residentClassValue1 = false;
  bool _residentClassValue2 = false;
  bool _residentClassValue3 = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
// Define a variable to store the age
  int age = 0;
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final suffixController = TextEditingController();
  final houseNumberController = TextEditingController();
  final cityMunicipalityController = TextEditingController(text: 'Mandaluyong');
  final provinceController = TextEditingController();
  final nationalityController = TextEditingController(text: 'Filipino');
  final birthPlaceController = TextEditingController();
  final ageController = TextEditingController();
  final companyNameController = TextEditingController();
  final positionController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final votersRegistrationController = TextEditingController();
  final barangayController = TextEditingController(text: 'Harapin ang Bukas');
  final passwordController = TextEditingController();
  final birthplaceController = TextEditingController();

  //FOR EMAIL VALIDATION ---------------
  bool isEmailValid(String email) {
    final emailRegExp =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    return emailRegExp.hasMatch(email);
  }

  Future<bool> doesDomainExist(String domain) async {
    try {
      final result = await InternetAddress.lookup(domain);
      return result.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  bool isValidTLD(String tld) {
    return validTLDs.contains(tld);
  }

  List<String> validTLDs = [
    'com',
    'net',
    'org',
    'io',
  ];
// FOR DROPDOWNS ---------------------------------------------
  late String? selectedDistrict;
  List<String> districtOptions = [
    '1st District',
    '2nd District',
    '3rd District',
    '4th District',
    '5th District',
    '6th District',
    'Lone District',
  ];

  late String? selectedRegion;
  List<String> regionOptions = [
    'NCR',
    'CAR',
    'Region I - Ilocos Region',
    'Region II - Cagayan Valley',
    'Region III - Central Luzon',
    'Region IV-A - CALABARZON',
    'MIMAROPA Region',
    'Region V - Bicol Region',
    'Region VI - Western Visayas',
    'Region VII - Central Visayas',
    'Region VIII - Eastern Visayas',
    'Region IX - Zamboanga Peninsula',
    'Region X - Northern Mindanao',
    'Region XI -  Davao Region',
    'Region XII - SOCCSKSARGEN',
    'Region XIII - Caraga',
  ];

  late String selectedCivilStatus;
  List<String> civilStatusOptions = [
    'Single',
    'Married',
    'Widowed',
    'Separated'
  ];

  late String selectedHighestEducation;
  List<String> highestEducationOptions = [
    'Undergraduate',
    'Elementary',
    'Highschool',
    'Bachelor',
    'Postgrad',
    'Doctoral',
    'No Formal Education',
  ];

  late String selectedEmploymentStatus;
  List<String> employmentStatusOptions = [
    'Employed',
    'Unemployed',
    'Student',
  ];

  late String? selectedRegistrationStatus;
  List<String> registrationStatusOptions = [
    'Registered',
    'Unregistered',
  ];
  @override
  // Function to handle dropdowns selection
  void initState() {
    super.initState();
    selectedCivilStatus = civilStatusOptions[0];
    selectedHighestEducation = highestEducationOptions[0];
    selectedEmploymentStatus = employmentStatusOptions[0];
    selectedDistrict = districtOptions[0];
    selectedRegion = regionOptions[0];
    selectedRegistrationStatus = registrationStatusOptions[0];
  }

// Function to handle checkbox selection
  void handleGenderSelection() {
    if (_checkBoxValue1) {
      setState(() {});
    } else if (_checkBoxValue2) {
      setState(() {});
    } else {
      setState(() {});
    }
  }

  void handleHomeOwnershipSelection() {
    if (_homeOwnershipValue1) {
    } else if (_homeOwnershipValue2) {
    } else {}
  }

  Future<void> handleResidentClassSelection(int checkboxNumber) async {
    setState(() {
      if (checkboxNumber == 1) {
        _residentClassValue1 = true;
        _residentClassValue2 = false;
        _residentClassValue3 = false;
      } else if (checkboxNumber == 2) {
        _residentClassValue1 = false;
        _residentClassValue2 = true;
        _residentClassValue3 = false;
      } else if (checkboxNumber == 3) {
        _residentClassValue1 = false;
        _residentClassValue2 = false;
        _residentClassValue3 = true;
      }
    });
  }

// Add a method to validate form fields
  bool _validateForm() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

// Add a method to handle registration errors
  void _handleRegistrationError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Registration Error"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

//FUNCTION TO PASS THE DATA TO BACKEND ---------------------------------------------------
  void _registerUser() async {
    var defaultStatus = "active";
    var type = "resident";
    var url =
        Uri.parse('https://dbarangay-mobile-e5o1.onrender.com/registration');
    var request = http.MultipartRequest('POST', url);

    try {
      if (selectedImage != null) {
        request.files.add(
            await http.MultipartFile.fromPath('userImage', selectedImage!));
      }

      // Add debug logs to print the values being sent to the server
      print('Registration data:');
      print('Last Name: ${lastNameController.text}');
      print('First Name: ${firstNameController.text}');
      print('Middle Name: ${middleNameController.text}');
      print('Suffix: ${suffixController.text}');
      print('House Number: ${houseNumberController.text}');
      print('Barangay: ${barangayController.text}');
      print('City/Municipality: ${cityMunicipalityController.text}');
      print('District: $selectedDistrict');
      print('Province: ${provinceController.text}');
      print('Region: $selectedRegion');
      print('Nationality: ${nationalityController.text}');
      print('Birth Place: ${birthPlaceController.text}');
      print('Age: ${ageController.text}');
      print('Company Name: ${companyNameController.text}');
      print('Position: ${positionController.text}');
      print('Phone Number: ${phoneNumberController.text}');
      print('Email: ${emailController.text}');
      print('Civil Status: $selectedCivilStatus');
      print('Highest Education: $selectedHighestEducation');
      print('Employment Status: $selectedEmploymentStatus');
      print('Password: ${passwordController.text}');
      print('Date of Birth: $selectedDate');
      print('Sex: ${_checkBoxValue1 ? "Male" : "Female"}');
      print('Home Ownership: ${_homeOwnershipValue1 ? "Own" : "Rent"}');
      print(
          'Resident Class: ${_residentClassValue1 ? "PWD" : (_residentClassValue2 ? "Solo Parent" : "Out of School Youth")}');
      print('Voters Registration: $selectedRegistrationStatus');
      print('Status: $defaultStatus');
      print('Type: $type');

      // Set request fields
      request.fields['lastName'] = lastNameController.text;
      request.fields['firstName'] = firstNameController.text;
      request.fields['middleName'] = middleNameController.text;
      request.fields['suffix'] = suffixController.text;
      request.fields['houseNumber'] = houseNumberController.text;
      request.fields['barangay'] = barangayController.text;
      request.fields['cityMunicipality'] = cityMunicipalityController.text;
      request.fields['district'] = selectedDistrict!;
      request.fields['province'] = provinceController.text;
      request.fields['region'] = selectedRegion!;
      request.fields['nationality'] = nationalityController.text;
      request.fields['birthPlace'] = birthPlaceController.text;
      request.fields['age'] = ageController.text;
      request.fields['companyName'] = companyNameController.text;
      request.fields['position'] = positionController.text;
      request.fields['phoneNumber'] = phoneNumberController.text;
      request.fields['email'] = emailController.text;
      request.fields['civilStatus'] = selectedCivilStatus;
      request.fields['highestEducation'] = selectedHighestEducation;
      request.fields['employmentStatus'] = selectedEmploymentStatus;
      request.fields['password'] = passwordController.text;
      request.fields['dateOfBirth'] = selectedDate!;
      request.fields['sex'] = _checkBoxValue1 ? "Male" : "Female";
      request.fields['homeOwnership'] = _homeOwnershipValue1 ? "Own" : "Rent";
      request.fields['residentClass'] = _residentClassValue1
          ? "PWD"
          : (_residentClassValue2 ? "Solo Parent" : "Out of School Youth");
      request.fields['votersRegistration'] = selectedRegistrationStatus!;
      request.fields['status'] = defaultStatus;
      request.fields['type'] = type;

      // Send the request
      var response = await request.send();

      // Check the HTTP response status
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(await response.stream.bytesToString());
        showSuccessDialog(context);
      } else {
        _handleRegistrationError(
            "Failed to register user. HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exceptions
      _handleRegistrationError("An error occurred while registering user: $e");
    }
  }

  // void _registerUser() async {
  //   var defaultStatus = "active";
  //   var type = "resident";
  //   var url =
  //       Uri.parse('https://dbarangay-mobile-e5o1.onrender.com/registration');
  //   var request = http.MultipartRequest('POST', url);

  //   // Add try-catch block to handle errors
  //   try {
  //     if (selectedImage != null) {
  //       request.files.add(
  //           await http.MultipartFile.fromPath('userImage', selectedImage!));
  //     }

  //     request.fields['lastName'] = lastNameController.text;
  //     request.fields['firstName'] = firstNameController.text;
  //     request.fields['middleName'] = middleNameController.text;
  //     request.fields['suffix'] = suffixController.text;
  //     request.fields['houseNumber'] = houseNumberController.text;
  //     request.fields['barangay'] = barangayController.text;
  //     request.fields['cityMunicipality'] = cityMunicipalityController.text;
  //     request.fields['district'] = selectedDistrict!;
  //     request.fields['province'] = provinceController.text;
  //     request.fields['region'] = selectedRegion!;
  //     request.fields['nationality'] = nationalityController.text;
  //     request.fields['birthPlace'] = birthPlaceController.text;
  //     request.fields['age'] = ageController.text;
  //     request.fields['companyName'] = companyNameController.text;
  //     request.fields['position'] = positionController.text;
  //     request.fields['phoneNumber'] = phoneNumberController.text;
  //     request.fields['email'] = emailController.text;
  //     request.fields['civilStatus'] = selectedCivilStatus;
  //     request.fields['highestEducation'] = selectedHighestEducation;
  //     request.fields['employmentStatus'] = selectedEmploymentStatus;
  //     request.fields['password'] = passwordController.text;
  //     request.fields['dateOfBirth'] = selectedDate!;
  //     request.fields['sex'] = _checkBoxValue1 ? "Male" : "Female";
  //     request.fields['homeOwnership'] = _homeOwnershipValue1 ? "Own" : "Rent";
  //     request.fields['residentClass'] = _residentClassValue1
  //         ? "PWD"
  //         : (_residentClassValue2 ? "Solo Parent" : "Out of School Youth");
  //     request.fields['votersRegistration'] = selectedRegistrationStatus!;
  //     request.fields['status'] = defaultStatus;
  //     request.fields['type'] = type;

  //     var response = await request.send();

  //     if (response.statusCode == 200) {
  //       var jsonResponse = jsonDecode(await response.stream.bytesToString());
  //       showSuccessDialog(context);
  //     } else {
  //       _handleRegistrationError(
  //           "Failed to register user. HTTP Error: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     _handleRegistrationError("An error occurred while registering user: $e");
  //   }
  // }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

// Function to show the privacy compliance dialog
  Future<void> _showPrivacyComplianceDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              "Privacy Compliance",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var item in complianceItems)
                    ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.description),
                    ),
                  const SizedBox(height: 20.0),
                  Container(
                    margin: const EdgeInsets.only(right: 20.0, left: 30.0),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(
                            text:
                                "By registering on the BARANGAY HARAPIN ANG BUKAS App, you acknowledge that you have read, understood, and agree to the terms outlined in this Privacy Compliance Statement. ",
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          TextSpan(
                            text:
                                "If you have any questions, concerns, or requests regarding your privacy or data, please do not hesitate to contact our Data Protection Officer (DPO) at 536-7492. Thank you for choosing the Barangay Harapin ang Bukas App. Your trust and privacy are our top priorities.",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          ),
          actions: <Widget>[
            Container(
              margin:
                  const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
              child: TextButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
              child: TextButton(
                child: const Text(
                  "Accept",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _registerUser();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              title: const Center(
                child: Text(
                  'REGISTRATION SUCCESSFUL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text(
                  'You can now enjoy all the features and benefits of our community platform!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 6, 140, 6), // Change the button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              backgroundColor: const Color.fromARGB(255, 57, 172, 61),
              actions: const [],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int age;
    return Form(
      key: _formKey,
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
          //  ---------------------- Profile Picture ----------------------
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 300,
              height: 280,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: kPrimaryColor,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: selectedImage != null
                          ? Image.file(
                              File(selectedImage!),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              Icons.person,
                              size: 160,
                              color: kPrimaryColor,
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.image,
                          allowCompression: true,
                        );
                        if (result != null && result.files.isNotEmpty) {
                          setState(() {
                            selectedImage = result.files.first.path!;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(width: 2, color: Colors.blue),
                      ),
                      child: const Text(
                        'Select Image',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
// --------------- START OF INPUTR FIELDS FOR USER -------------------------
// LAST NAME ---------------------
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: lastNameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Last Name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Last Name is required';
                }
                return null;
              },
            ),
          ),
// FIRST NAME ---------------------
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: firstNameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "First Name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'First Name is required';
                }
                return null;
              },
            ),
          ),

// MIDDLE INITIAL ---------------------
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: middleNameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Middle Name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Middle Initial is required';
                }
                return null;
              },
            ),
          ),
// SUFFIX ---------------------
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: suffixController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Suffix",
                prefixIcon: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),

// Additional spacing
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
          ),

// --------------------------------------------- COMPLETE ADDRESS ---------------------------------------------
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'COMPLETE ADDRESS',
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

          Row(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Align columns at the start of the row
            children: [
              Expanded(
                child: Column(
                  children: [
// HOUSE #---------------------
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: houseNumberController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType
                          .text, // Use to TextInputType.number for numeric input
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: "House # / Street",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.home),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'House # / Street is required';
                        }
                        return null;
                      },
                    ),

// CITY---------------------
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: cityMunicipalityController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.home),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value == 'MANDALUYONG') {
                          return 'City is required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // 2ND COLUMN
              Expanded(
                child: Column(
                  children: [
                    // PROVINCE  ---------------------
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: provinceController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: "Province",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.home),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Province is required';
                        }
                        return null;
                      },
                    ),
// BARANGAY ---------------------
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: barangayController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.home),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // DISTRICT---------------------
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'District',
                hintStyle: TextStyle(fontSize: 12),
              ),
              value: selectedDistrict,
              icon: const Icon(Icons.arrow_drop_down),
              items: districtOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDistrict = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'District is Required';
                }
                return null;
              },
            ),
          ),

// REGION---------------------
          const SizedBox(height: 12),
          SizedBox(
            width: 450,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    hintText: 'Region',
                    hintStyle: TextStyle(fontSize: 12),
                  ),
                  value: selectedRegion,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: regionOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRegion = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Region is Required';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
// Additional spacing
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
          ),

          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),

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

// GENDER---------------------

          const SizedBox(height: defaultPadding),
          Row(
            children: [
              Checkbox(
                value: _checkBoxValue1,
                onChanged: (value) {
                  setState(() {
                    _checkBoxValue1 = value ?? false;
                    _checkBoxValue2 = !_checkBoxValue1;
                    handleGenderSelection();
                  });
                },
              ),
              const Text('Male'),
              Checkbox(
                value: _checkBoxValue2,
                onChanged: (value) {
                  setState(() {
                    _checkBoxValue2 = value ?? false;
                    _checkBoxValue1 = !_checkBoxValue2;
                    handleGenderSelection();
                  });
                },
              ),
              const Text('Female'),
            ],
          ),
// CIVIL STATUS ---------------------
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Civil Status',
                hintStyle: TextStyle(fontSize: 12),
              ),
              value: selectedCivilStatus,
              icon: const Icon(Icons.arrow_drop_down),
              items: civilStatusOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCivilStatus = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Civil Status is Required';
                }
                return null;
              },
            ),
          ),
// NATIONALITY ---------------------
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: nationalityController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),

// DATE OF BIRTH ---------------------
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color.fromARGB(255, 152, 191, 223),
              ),
              child: InkWell(
                onTap: () async {
                  final currentDate = DateTime.now();
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: currentDate,
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      // Calculate age based on selected date of birth and current date
                      DateTime currentDate = DateTime.now();
                      DateTime birthDate = pickedDate;
                      age = currentDate.year - birthDate.year;
                      if (currentDate.month < birthDate.month ||
                          (currentDate.month == birthDate.month &&
                              currentDate.day < birthDate.day)) {
                        age--;
                      }

                      // Set the calculated age to the ageController
                      ageController.text = age.toString();

                      // Check if the user is below 12 years old
                      if (age < 12) {
                        showDialog(
                          context: context,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              contentPadding: const EdgeInsets.all(24),
                              content: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                    child: Text(
                                      "Age Restriction",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Center(
                                    child: Text(
                                      "We're sorry, but registration is only available for individuals aged 12 and above.",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                Center(
                                  child: SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        );
                      }
                    });
                  }
                },
                child: ListTile(
                  title: const Text(
                    'Date of Birth',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  trailing: Text(
                    selectedDate ?? 'Select date',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),

// AGE ---------------------
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: ageController,
              readOnly: true, // Set readOnly to true
              keyboardType: TextInputType.number,
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                hintText: "Age",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Age is required';
                }
                if (int.tryParse(value) == null) {
                  return 'Age should be a number';
                }
                return null;
              },
            ),
          ),

// BIRTHPLACE ---------------------
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: birthPlaceController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Birthplace",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),
// Highest Educational Attaintment
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Highest Educational Attaintment',
                hintStyle: TextStyle(fontSize: 12),
              ),
              value: selectedHighestEducation,
              icon: const Icon(Icons.arrow_drop_down),
              items: highestEducationOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedHighestEducation = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Highest Educational Attaintment is Required';
                }
                return null;
              },
            ),
          ),
// EMPLOYMENT STATUS ---------------------
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Employment Status',
                hintStyle: TextStyle(fontSize: 12),
              ),
              value: selectedEmploymentStatus,
              icon: const Icon(Icons.arrow_drop_down),
              items: employmentStatusOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedEmploymentStatus = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Employment Status is Required';
                }
                return null;
              },
            ),
          ),
// COMPANY NAME ---------------------
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: companyNameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Company Name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),
// POSITION ---------------------
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: positionController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Position",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),

// HOME OWNERSHIP ---------------------
          const SizedBox(height: defaultPadding),
          const Text(
            'HOME OWNERSHIP',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: _homeOwnershipValue1,
                onChanged: (value) {
                  setState(() {
                    _homeOwnershipValue1 = value ?? false;
                    _homeOwnershipValue2 = !_homeOwnershipValue1;
                    handleHomeOwnershipSelection();
                  });
                },
              ),
              const Text('Owner'),
              Checkbox(
                value: _homeOwnershipValue2,
                onChanged: (value) {
                  setState(() {
                    _homeOwnershipValue2 = value ?? false;
                    _homeOwnershipValue1 = !_homeOwnershipValue2;
                    handleHomeOwnershipSelection();
                  });
                },
              ),
              const Text('Renting'),
            ],
          ),
// Additional spacing
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
          ),

// CONTACT INFORMATION  ----------------------------------------------------------
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
// PHONE NUMBER ---------------------
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: phoneNumberController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Phone Number",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.phone),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone Number is required';
                }

                // Define a regular expression for Philippine phone numbers (adjust as needed)
                final phoneRegExp = RegExp(r'^(09|\+639)\d{9}$');
                if (!phoneRegExp.hasMatch(value)) {
                  return 'Invalid Phone number';
                }

                return null;
              },
            ),
          ),

// EMAIL ADDRESS ---------------------
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Email Address",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email Address is required';
                }

                if (!isEmailValid(value)) {
                  return 'Invalid email address';
                }

                final domain = value.split('@').last;
                final domainParts = domain.split('.');

                if (domainParts.length < 2) {
                  return 'Invalid email domain';
                }

                doesDomainExist(domain).then((domainExists) {
                  if (!domainExists) {
                    return 'Invalid email domain';
                  }
                });

                final tld = domainParts.last;
                if (!isValidTLD(tld)) {
                  return 'Invalid TLD';
                }

                return null;
              },
            ),
          ),
// Additional spacing
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
          ),

// OTHER INFORMATION ----------------------------------------------------------
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
// RESIDENT CLASS ---------------------
          const Text(
            'RESIDENT CLASS (Optional)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: defaultPadding),
              Wrap(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _residentClassValue1,
                        onChanged: (value) {
                          handleResidentClassSelection(1);
                        },
                      ),
                      const Text('PWD'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _residentClassValue2,
                        onChanged: (value) {
                          handleResidentClassSelection(2);
                        },
                      ),
                      const Text('Solo Parent'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _residentClassValue3,
                        onChanged: (value) {
                          handleResidentClassSelection(3);
                        },
                      ),
                      const Text('Out of School Youth'),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // VOTERS REGISTRATION ---------------------
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Voters Registration Status',
                hintStyle: TextStyle(fontSize: 12),
              ),
              value: selectedRegistrationStatus,
              icon: const Icon(Icons.arrow_drop_down),
              items: registrationStatusOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRegistrationStatus = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Voters Registration Status is Required';
                }
                return null;
              },
            ),
          ),

// --------------------------------- PASSWORD -------------------------------

          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.next,
              obscureText: !isPasswordVisible,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: defaultPadding / 2),
                  child: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }

                // Add password validation criteria
                if (value.length < 8) {
                  return 'Password must be at least 8 characters long';
                }
                if (!value.contains(RegExp(r'[A-Z]'))) {
                  return 'Password must contain at least one uppercase letter';
                }
                if (!value.contains(RegExp(r'[a-z]'))) {
                  return 'Password must contain at least one lowercase letter';
                }
                if (!value.contains(RegExp(r'[0-9]'))) {
                  return 'Password must contain at least one number';
                }

                return null;
              },
            ),
          ),

          // Wrap the part where the keyboard may cover the text fields with a ListView.builder
          ListView.builder(
              shrinkWrap: true,
              itemCount:
                  1, // Adjust the itemCount based on the number of text fields
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    obscureText: !isConfirmPasswordVisible,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Confirm password",
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.lock),
                      ),
                      suffixIcon: Padding(
                        padding:
                            const EdgeInsets.only(right: defaultPadding / 2),
                        child: IconButton(
                          icon: Icon(
                            isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isConfirmPasswordVisible =
                                  !isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                );
              }),

// SIGN-UP BUTTON
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _showPrivacyComplianceDialog(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              elevation: 0,
              foregroundColor: Colors.white,
            ),
            child: Text(
              "Sign Up".toUpperCase(),
            ),
          ),
          const SizedBox(height: 16.0),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),

// Add a SizedBox to create space at the bottom for scrolling
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),

          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

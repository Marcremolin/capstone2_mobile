// ignore_for_file: library_private_types_in_public_api, avoid_print, use_key_in_widget_constructors, unnecessary_null_comparison, use_build_context_synchronously, unused_element, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, use_super_parameters
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:typed_data'; // Import Uint8List

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'profilePage.dart';
import '../../../Screens/mapPage.dart';
//ADD FOR DATABASE
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:io';

class Emergency extends StatefulWidget {
// FOR TOKEN -----------------------------
  final token;
  const Emergency({Key? key, this.token}) : super(key: key);
  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String _selectedCategory;
  late String userId; //FOR TOKEN
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? middleName;
  File? _image;
// Add the _imageBytes variable to store compressed image data
  Uint8List? _imageBytes;

// Add the _imageName variable to store the image name
  String? _imageName;
//ADD FOR DATABASE
  String? selectedDate;
  final dateController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final residentNameController = TextEditingController();

//--------------
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _selectedCategory = 'General Report';
    _tabController.addListener(_handleTabSelection);
    if (widget.token != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      userId = jwtDecodedToken['_id'];
      phoneNumber = jwtDecodedToken['phoneNumber'];
      firstName = jwtDecodedToken['firstName'];
      middleName = jwtDecodedToken['middleName'];
      lastName = jwtDecodedToken['lastName'];
      residentNameController.text = " $firstName, $middleName, $lastName";
      phoneNumberController.text = "$phoneNumber";
    }
  }

  void _handleTabSelection() {
    setState(() {
      _selectedCategory = _tabController.index == 0
          ? 'Evacuation Center'
          : _tabController.index == 1
              ? 'Emergency'
              : '';
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool validateFileSize(File file) {
    const maxSize = 5 * 1024 * 1024; // 5MB maximum file size
    if (file.lengthSync() > maxSize) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('The file size exceeds the limit (5MB).'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  Future<void> captureImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final compressedImage = await compressImage(imageFile);
      setState(() {
        _imageBytes = compressedImage;
        _imageName = imageFile.path.split('/').last;
      });
    }
  }

  Future<Uint8List?> compressImage(File file) async {
    return await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minHeight: 1920,
      minWidth: 1080,
      quality: 75,
    );
  }

//ADD FOR DATABASE ----------------------------------------------
  void sendDistressSignal(String emergencyType) async {
    var defaultStatus = "New";
    var now = DateTime.now();
    var formattedDate =
        "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";

    // Request location permission
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      Position userLocation = await getLocation();

      if (userLocation != null) {
        var latitude = userLocation.latitude;
        var longitude = userLocation.longitude;

        List<Placemark> placemarks =
            await placemarkFromCoordinates(latitude, longitude);
        if (placemarks.isNotEmpty) {
          var street = placemarks[0].street;
          var city = placemarks[0].locality;
          var postalCode = placemarks[0].postalCode;
          var country = placemarks[0].country;

          // Compress and encode the image as base64
          Uint8List? imageBytes;
          String? imageBase64;
          if (_image != null) {
            imageBytes = await compressImage(_image!);
            imageBase64 = base64Encode(imageBytes!);
          }

          Map<String, dynamic> reqBody = {
            "userId": userId,
            "residentName": residentNameController.text,
            "currentLocation": "${street}, ${city} ${postalCode}, ${country}",
            "emergencyType": emergencyType,
            "date": formattedDate,
            "status": defaultStatus,
            "phoneNumber": phoneNumberController.text,
          };

          if (_imageBytes != null && _imageName != null) {
            reqBody["emergencyProofImage"] = {
              "data": base64Encode(_imageBytes!),
              "fileName": _imageName,
            };
          }

          // Add verification of request body
          print('Request Body: $reqBody');

          var url = Uri.parse(
              'https://dbarangay-mobile-e5o1.onrender.com/emergencySignal');
          try {
            var response = await sendDistressSignalRequest(url, reqBody);

            if (response.statusCode == 200) {
              print('Request successful: ${response.body}');
              var jsonResponse = jsonDecode(response.body);
              var status = jsonResponse['status'];
              showSuccessDialog(context, status);
            } else {
              print('HTTP Error: ${response.statusCode}');
              print('Response body: ${response.body}');
            }
          } catch (e) {
            print('Error sending distress signal: $e');
          }
        } else {
          print('Phone number is empty.');
        }
      }
    } else if (status.isPermanentlyDenied) {
      showLocationPermissionDeniedDialog(context);
    }
  }

  bool isValidCoordinates(double latitude, double longitude) {
    return (latitude >= -90.0 && latitude <= 90.0) &&
        (longitude >= -180.0 && longitude <= 180.0);
  }

  Future<http.Response> sendDistressSignalRequest(
      Uri url, Map<String, dynamic> reqBody) async {
    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      if (response.statusCode == 413) {
        // Display an error message to the user
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('The file size exceeds the limit.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }

      return response;
    } catch (e) {
      print('Error sending distress signal request: $e');
      rethrow;
    }
  }

  Future<Position> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      return position;
    } catch (e) {
      print("Error getting location: $e");
      rethrow;
    }
  }

  Future<String?> getStreetAddress(Position userLocation) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        userLocation.latitude,
        userLocation.longitude,
      );
      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks[0];
        final String? street = placemark.street;
        final String? city = placemark.locality;
        final String? country = placemark.country;
        return '$street, $city, $country';
      }
      return null;
    } catch (e) {
      print("Error getting street address: $e");
      return null;
    }
  }

  void showNetworkErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Network Error'),
          content: const Text(
              'A network error occurred. Please check your internet connection and try again.'),
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

  showLocationPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Location Permission Denied'),
          content: const Text(
              'Please enable location permissions in your device settings to use this feature.'),
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

// -------------------------------------------------- ALERT DIALOGS --------------------------------------------------

// POPUP RED CONFIRNMATION DIALOG
  void showConfirmationDialog(BuildContext context, String emergencyType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 243, 76, 64),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(168, 255, 255, 255),
                      thickness: 2,
                      height: 15,
                    ),
                    const SizedBox(height: 20),
                    _image != null
                        ? Image.file(_image!, width: 200, height: 200)
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    // Add an option to take a picture
                    TextButton(
                      onPressed: () async {
                        // Open camera to take a picture
                        final pickedFile = await ImagePicker().pickImage(
                          source: ImageSource.camera,
                        );

                        if (pickedFile != null) {
                          setState(() {
                            _image = File(pickedFile.path);
                          });
                          print('Image Path: ${_image!.path}');
                        }
                      },
                      child: const Text(
                        'UPLOAD PROOF OF EMERGENCY (Optional)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Buttons for retake and proceed
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _image != null
                            ? TextButton(
                                onPressed: () {
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                child: const Text(
                                  'RETAKE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(width: 40),
                        TextButton(
                          onPressed: () {
                            sendDistressSignal(emergencyType);
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'PROCEED',
                            style: TextStyle(
                              color: Color.fromARGB(255, 15, 234, 22),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showSuccessDialog(BuildContext context, [status]) {
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
                  'SUCCESS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Distress signal sent successfully.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Rescuers are on their way to you. Stay alert and keep safe; assistance is coming',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.green,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
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

// FRONTEND CODE -------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Evacuation Center', 'Emergency Report '];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 239, 246),
      appBar: AppBar(
        title: Text(_selectedCategory),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle), // Profile Icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(token: widget.token)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: const Color.fromARGB(255, 8, 123, 218),
            tabs: tabs.map((String tab) {
              return Tab(
                text: tab,
              );
            }).toList(),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
// ------------------------- EVACUATION CENTER ----------------------------
              ListView(
                children: [
                  customListTile(
                    'assets/images/MagalonaCourt.jpg',
                    'MAGALONA COURT',
                    'Magalona St, Mandaluyong, Metro Manila',
                    context,
                    'assets/images/MobileMap.jpg',
                    '093749474929',
                    ' ',
                    [
                      'assets/images/NearbyLocations/ViviansBakery.jpg',
                      'assets/images/NearbyLocations/DaangBakal_BarangayHall.jpg',
                      'assets/images/NearbyLocations/JRU_ElementaryBuilding.jpg',
                      'assets/images/NearbyLocations/KimmyStore.jpg',
                    ],
                    [
                      'Vivians Bakery',
                      'Daang Bakal Brgy Hall',
                      'JRU Elementary Building',
                      'Kimmy Store',
                    ],
                  ),
                  customListTile(
                    'assets/images/BarangayHall.jpg',
                    'Barangay Hall',
                    '256 Daang Bakal St. Brgy Harapin ang Bukas, Mandaluyong City',
                    context,
                    'assets/images/MobileMap.jpg',
                    '093749474929',
                    ' ',
                    [
                      'assets/images/NearbyLocations/BPI_KalentongBranch.jpg',
                      'assets/images/NearbyLocations/Marketplace_Kalentong.jpg',
                      'assets/images/NearbyLocations/Mercury_Kalentong.jpg',
                      'assets/images/NearbyLocations/PalawanPawnshop_Kalentong.jpg',
                    ],
                    [
                      'BPI Kalentong',
                      'Marketplace Shopping Mall',
                      'Mercury Kalentong',
                      'Palawan Pawnshop Kalentong',
                    ],
                  ),
                  customListTile(
                    'assets/images/Playground.jpg',
                    'Barangay Playground',
                    '234 Senator Neptali A Gonzales St.',
                    context,
                    'assets/images/MobileMap.jpg',
                    '093749474929',
                    ' ',
                    [
                      'assets/images/NearbyLocations/AlmarezStore.jpg',
                      'assets/images/NearbyLocations/HarapinAngBukas.jpg',
                      'assets/images/NearbyLocations/DaangBakal_Alley5.jpg',
                      'assets/images/NearbyLocations/PalawanPawnshop_Kalentong.jpg',
                    ],
                    [
                      'Almarez Store',
                      'Brgy Hall of Harapin ang Bukas',
                      'Daang Bakal Alley5',
                      'Palawan Pawnshop Kalentong',
                    ],
                  ),
                ],
              ),

// ------------------------- EMERGENCY BUTTONS ----------------------------
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: const Text(
                        'Please make sure that the situation truly requires immediate assistance before clicking. Thank you!',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 8, 123, 218),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    color: Colors.blue,
                    text: 'POLICE',
                    icon: Icons.local_police_outlined,
                    emergencyType: 'POLICE Assistance',
                    onTapCallback: () {
                      showConfirmationDialog(context, 'POLICE Assistance');
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    color: Colors.red,
                    text: 'AMBULANCE',
                    icon: Icons.local_hospital_outlined,
                    emergencyType: 'AMBULANCE Assistance',
                    onTapCallback: () {
                      showConfirmationDialog(context, 'AMBULANCE Assistance');
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    color: Colors.orange,
                    text: 'FIRE TRUCK',
                    icon: Icons.fire_truck_outlined,
                    emergencyType: 'FIRE TRUCK Assistance',
                    onTapCallback: () {
                      showConfirmationDialog(context, 'FIRE TRUCK Assistance');
                    },
                  )
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }
}

// WIDGET FUNCTIONS -------------------------------------------------------------------
Widget customListTile(
  String imagePath,
  String evacName,
  String evacAddress,
  BuildContext context,
  String mapImage,
  String evacContact,
  String directionButton,
  List<String> imageList,
  List<String> imageName,
) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => mapPage(
            mapImage: mapImage,
            evacName: evacName,
            evacAddress: evacAddress,
            evacContact: evacContact,
            directionButton: directionButton,
            imageList: imageList,
            imageName: imageName,
          ),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              imagePath,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4.0),
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              evacName,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            evacAddress,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 6.0),
          const Text(
            'Additional details',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}

// ------------------------- EMERGENCY BUTTONS Design & Function ----------------------------
class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final IconData icon;
  final String emergencyType;
  final VoidCallback onTapCallback; // Callback function

  const CustomButton({
    Key? key,
    required this.color,
    required this.text,
    required this.icon,
    required this.emergencyType,
    required this.onTapCallback, // Pass the callback as a parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Emergency button tapped');
        print('context: $context');
        print('emergencyType: $emergencyType');

        onTapCallback();
      },
      child: Container(
        width: 350,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            Container(
              width: 400,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: color,
                  width: 4.0,
                ),
              ),
            ),

            // Inner Container with background color
            Container(
              width: 396,
              height: 146,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 80.0,
                    color: color,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

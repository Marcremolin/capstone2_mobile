// ignore_for_file: avoid_print, missing_required_param

import 'package:flutter/material.dart';
import '../../../Screens/Homepage/bottom_nav.dart';
import '../AdditionalContentPage.dart';
import '../../Screens/ProfilePage.dart';
import '../../Screens/Login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnnouncementPage extends StatefulWidget {
  final String? token; // Make the token parameter optional
  const AnnouncementPage({Key? key, this.token}) : super(key: key);

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String _selectedCategory;

  // late String email; //for TOKEN
  // ------- Part of GET Method-----------
  List<dynamic> announcementData = []; // Store the fetched data here
  List<dynamic> livelihoodData = [];
  List<dynamic> businessPromotionData = [];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _selectedCategory = 'Announcement';
    _tabController.addListener(_handleTabSelection);

    // ------- Part of GET Method (Make the API request when the app starts) -----------
    fetchAnnouncementData();
    fetchLivelihoodData();
    fetchbusinessPromotionData();

    // email = jwtDecodedToken['email'];
  }

  void _handleTabSelection() {
    setState(() {
      _selectedCategory = _tabController.index == 0
          ? 'Announcement'
          : _tabController.index == 1
              ? 'Livelihood '
              : _tabController.index == 2
                  ? 'Business'
                  : '';
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                // Navigate to the LoginScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

//--------------------------- FUNCTION TO HIT THE API ANNOUNCEMENT  --------------------------------
  void fetchAnnouncementData() async {
    final url = Uri.parse(
        'https://dbarangay-mobile-e5o1.onrender.com/get/announcements');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          announcementData = data;
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

//-------------------  FUNCTION TO HIT THE API LIVELIHOOD  ----------------------------

  void fetchLivelihoodData() async {
    final url =
        Uri.parse('https://dbarangay-mobile-e5o1.onrender.com/get/livelihood');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          livelihoodData = data;
        });
      } else {
        throw Exception(
            'Failed to load data from LIVELIHOOD: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

//--------------------------- FUNCTION TO HIT THE API BUSINESS PROMOTION  --------------------------------

  void fetchbusinessPromotionData() async {
    final url = Uri.parse(
        'https://dbarangay-mobile-e5o1.onrender.com/get/promoteBusiness');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          businessPromotionData = data;
        });
      } else {
        throw Exception(
            'Failed to load data from BUSINESS PROMOTION: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Announcement', 'Livelihood ', 'Business'];

    return WillPopScope(
        onWillPop: () async {
          showLogoutDialog(context);
          return false; // Prevents the default back button behavior
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 2, 95, 170),
          appBar: AppBar(
            title: Text(_selectedCategory),
            actions: [
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(token: widget.token),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: const Color.fromARGB(255, 252, 252, 252),
                tabs: tabs.map((String tab) {
                  return Tab(
                    text: tab,
                  );
                }).toList(),
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  ListView.builder(
                    itemCount: announcementData.length,
                    itemBuilder: (context, index) {
                      final announcement = announcementData[index];
                      if (announcement != null) {
                        return customListTile(
                          announcement, // Pass the announcement data here
                          context,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
// -------------------------------- LIVEHOOD LIST --------------------------------
                  ListView.builder(
                    itemCount: livelihoodData.length,
                    itemBuilder: (context, index) {
                      final livelihood = livelihoodData[index];
                      if (livelihood != null) {
                        final imageUrl = livelihood['filename']?['url'] ?? '';
                        final livelihoodCategory = livelihood['what'] ?? '';
                        final livelihoodLocation = livelihood['where'] ?? '';
                        final livelihoodParticipants = livelihood['who'] ?? '';
                        final livelihoodDate = livelihood['when'] ?? '';

                        return customLivelihoodListTile(
                          imageUrl,
                          livelihoodCategory,
                          livelihoodLocation,
                          livelihoodParticipants,
                          livelihoodDate,
                          context,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),

//  ------------------------------------------------- BUSINESS ADDITIONAL PAGE CONTENT  ----------------------------------------------------------
                  ListView.builder(
                    itemCount: businessPromotionData.length,
                    itemBuilder: (context, index) {
                      final business = businessPromotionData[index];
                      if (business != null) {
                        final filenameData = business['filename']
                            as Map<String, dynamic>?; // Cast to nullable Map
                        final imageUrl = filenameData?['url'] ?? '';

                        // The rest of your code remains the same
                        return customBusinessListTile(
                          imageUrl, // Use the imageUrl variable
                          business['businessName'] ?? '',
                          business['category'] ?? '',
                          context,
                          business['contact'] ?? '',
                          business['address'] ?? '',
                          business['hours'] ?? '',
                          business['contact'] ?? '',
                          business['contact'] ?? '',
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}

// -------------------------------- DESIGN IN BUSINESS CATEGORY --------------------------------
Widget customBusinessListTile(
  String imageUrl, //filename
  String sourceName, //BUSINESS NAME
  String title, //CATEGORY
  BuildContext context,
  String description, //residentName
  String operatingHours, //hours:
  String location, //address:
  String phone, //contact
  String owner, //residentName
) {
  // Print the imageUrl to check its value
  print('Debug: imageUrl = $imageUrl');

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdditionalContentPage(
            imagePath: imageUrl,
            sourceName: sourceName,
            title: title,
            description: description,
            operatingHours: operatingHours,
            location: location,
            phone: phone,
            owner: owner,
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
            child: Image.network(
              imageUrl,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/images/BusinessBanner.png');
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              sourceName,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 4.0),
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

// -------------------------------- FUNCTION AND DESIGN IN LIVELIHOOD CATEGORY --------------------------------
Widget customLivelihoodListTile(
  String imageUrl,
  String livelihoodCategory,
  String livelihoodLocation,
  String livelihoodParticipants,
  String livelihoodDate,
  BuildContext context,
) {
  return Container(
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            height: 150.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150.0,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/images/Livelihood.png');
              },
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Center(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 35, 19, 139),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              livelihoodCategory,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),

        // Rest of your widget content
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Location:',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    livelihoodLocation,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Participants:',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    livelihoodParticipants,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date:',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    livelihoodDate,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// -------------------------------- DESIGN IN ANNOUNCEMENT CATEGORY --------------------------------
Widget customListTile(
  Map<String, dynamic> announcement,
  BuildContext context,
) {
  final imageUrl = announcement['filename']['url'];
  final announcementCategory = announcement['what'];
  final announcementDate = announcement['when'];
  final announcementLocation = announcement['where'];
  final announcementParticipants = announcement['who'];

  return Container(
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
//  -------------- ANNOUNCEMENT IMAGE  ------------
          child: Container(
            height: 150.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150.0,
              errorBuilder: (context, error, stackTrace) {
                // Handle errors while loading the image
                return const Center(
                  child: Icon(Icons.error_outline, size: 48, color: Colors.red),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8.0), // Clip image to prevent overflow
//  -------------- ANNOUNCEMENT TITLE  ------------
        Center(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 35, 19, 139),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              announcementCategory,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),

        // Rest of your widget content

//  -------------- ANNOUNCEMENT COLUMNS  ------------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Location:',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    announcementDate,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                  const SizedBox(height: 8.0),
                  //LOCATION

                  const Text(
                    'Participants:',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    announcementLocation,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //------------- Time ------------------

                  const Text(
                    'Time:',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    announcementParticipants,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                  const SizedBox(height: 8.0),
                  //------------- Participants ------------------
                  const Text(
                    'Date:',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    announcementParticipants,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class AnnouncementDetailsPage extends StatelessWidget {
  final String imageUrl;
  final String announcementTitle;
  final String announcementCategory;
  final String announcementDesc;
  final String announcementLocation;
  final String announcementDate;
  final String announcementTime;
  final String announcementParticipants;
  final String announcementClosing;

  const AnnouncementDetailsPage({
    super.key,
    required this.imageUrl,
    required this.announcementTitle,
    required this.announcementCategory,
    required this.announcementDesc,
    required this.announcementDate,
    required this.announcementLocation,
    required this.announcementTime,
    required this.announcementParticipants,
    required this.announcementClosing,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcement Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageUrl),
            const SizedBox(height: 16.0),
            Text(
              announcementCategory,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              announcementTitle,
              style: const TextStyle(fontSize: 12.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              announcementDate,
              style: const TextStyle(fontSize: 12.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              announcementLocation,
              style: const TextStyle(fontSize: 12.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              announcementTime,
              style: const TextStyle(fontSize: 12.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              announcementParticipants,
              style: const TextStyle(fontSize: 12.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              announcementClosing,
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

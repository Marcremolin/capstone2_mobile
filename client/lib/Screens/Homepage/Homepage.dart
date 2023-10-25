import 'package:flutter/material.dart';
import '../../../Screens/Homepage/bottom_nav.dart';
import '../AdditionalContentPage.dart';
import '../../Screens/ProfilePage.dart';
import '../../Screens/Login/login_screen.dart';

import 'package:jwt_decoder/jwt_decoder.dart';
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

    // final String? token;

    // Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
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
    final url = Uri.parse('http://192.168.0.28:8000/get/announcements');

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
    final url = Uri.parse('http://192.168.0.28:8000/get/livelihood');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          livelihoodData = data;
        });
        for (var livelihood in livelihoodData) {
          final imageUrl = await fetchImageForLivelihood(livelihood['_id']);
          livelihood['imageUrl'] = imageUrl;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<String> fetchImageForLivelihood(String livelihoodId) async {
    final imageUrlUrl = Uri.parse(
        'http://192.168.0.28:8000/get/livelihood/$livelihoodId/image');

    try {
      final response = await http.get(imageUrlUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['imageUrl'];
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching image: $e');
      throw Exception('Failed to load image');
    }
  }

//--------------------------- FUNCTION TO HIT THE API BUSINESS PROMOTION  --------------------------------
  void fetchbusinessPromotionData() async {
    final url = Uri.parse('http://192.168.0.28:8000/get/promoteBusiness');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          businessPromotionData = data;
        });
        for (var promoteBusiness in businessPromotionData) {
          final imageUrl =
              await fetchImageForbusinessPromotion(promoteBusiness['_id']);
          promoteBusiness['imageUrl'] = imageUrl;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<String> fetchImageForbusinessPromotion(
      String promoteBusinessId) async {
    final imageUrlUrl = Uri.parse(
        'http://192.168.0.28:8000/get/promoteBusiness/$promoteBusinessId/image');

    try {
      final response = await http.get(imageUrlUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['imageUrl'];
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching image: $e');
      throw Exception('Failed to load image');
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
                icon: const Icon(Icons.account_circle), // Profile Icon
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfilePage(token: widget.token), // Pass the token
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
                        // final imageUrl =
                        //     'http://192.168.0.28:8000/get/announcement/${announcement['filename']}';

                        return customListTile(
                          announcement['filename'] ?? '',
                          announcement['what'] ?? '',
                          announcement['when'] ?? '',
                          announcement['where'] ?? '',
                          announcement['who'] ?? '',
                          announcement['when'] ?? '',
                          context,
                        );
                      } else {
                        return const SizedBox(); // Handle the case when data is null
                      }
                    },
                  ),
// -------------------------------- LIVEHOOD LIST --------------------------------
                  ListView.builder(
                    itemCount: livelihoodData.length,
                    itemBuilder: (context, index) {
                      final livelihood = livelihoodData[index];
                      if (livelihood != null) {
                        return customLivelihoodListTile(
                          livelihood['imageUrl'] ?? '', // URL for the image
                          livelihood['what'] ?? '',

                          livelihood['where'] ?? '',
                          livelihood['when'] ?? '',
                          livelihood['who'] ?? '',
                          context,
                        );
                      } else {
                        return const SizedBox(); // Handle the case when data is null
                      }
                    },
                  ),
//  ------------------------------------------------- BUSINESS ADDITIONAL PAGE CONTENT  ----------------------------------------------------------
                  ListView.builder(
                    itemCount: businessPromotionData
                        .length, // Replace with your list of businesses
                    itemBuilder: (context, index) {
                      final business = businessPromotionData[index];
                      if (business != null) {
                        return customBusinessListTile(
                          business['imageUrl'] ?? '', // URL for the image
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
                        return const SizedBox(); // Handle the case when data is null
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
  String imagePath, //filename
  String sourceName, //BUSINESS NAME
  String title, //CATEGORY
  BuildContext context,
  String description, //residentName
  String operatingHours, //hours:
  String location, //address:
  String phone, //contact
  String owner, //residentName
) {
  return InkWell(
    onTap: () {
      Navigator.push(
        //NEXT PAGE
        context,
        MaterialPageRoute(
          builder: (context) => AdditionalContentPage(
            imagePath: imagePath,
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
            child: Image.asset(
              imagePath,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
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
  String imagePath,
  String what,
  String when,
  String where,
  String who,
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
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            imagePath,
            height: 200.0,
            width: 200.0, // Set the desired width for the image
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  what,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),

              // WHEN
              Row(
                children: [
                  const Text(
                    'WHEN:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    when,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),

              // WHERE
              Row(
                children: [
                  const Text(
                    'WHERE:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Color.fromARGB(255, 1, 30, 53),
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    where,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),

              // WHO
              Row(
                children: [
                  const Text(
                    'WHO:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    who,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const SizedBox(height: 4.0),
            ],
          ),
        ),
      ],
    ),
  );
}

// -------------------------------- DESIGN IN ANNOUNCEMENT CATEGORY --------------------------------
Widget customListTile(
  String filename,
  String announcementCategory,
  String announcementTitle,
  String announcementDate,
  String announcementLocation,
  String announcementParticipants,
  BuildContext context,
) {
  final imageUrl =
      'http://192.168.0.28:8000/uploads/$filename'; // Construct the URL to fetch the image

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
      bottomNavigationBar:
          const BottomNav(), // No need to provide the token parameter
    );
  }
}

import 'package:flutter/material.dart';
import '../../../Screens/Homepage/bottom_nav.dart';
import '../AdditionalContentPage.dart';
import '../../Screens/ProfilePage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        // home: Announcement(
        //   token: null,
        // ),
        );
  }
}

class Announcement extends StatefulWidget {
  final token;
  const Announcement({@required this.token, Key? key}) : super(key: key);

  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String _selectedCategory;
  late String emailAddress;

  @override
  void initState() {
    super.initState();
    // Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    _tabController = TabController(length: 3, vsync: this);
    _selectedCategory = 'Announcement';
    _tabController.addListener(_handleTabSelection);

    // emailAddress = jwtDecodedToken['email'];
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

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Announcement', 'Livelihood ', 'Business'];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 95, 170),
      appBar: AppBar(
        title: Text(_selectedCategory),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle), // Profile Icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
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
              ListView(
                // -------------------------------- ANNOUNCEMENT --------------------------------
                children: [
                  customListTile(
                    'assets/images/Announcement1.jpg',
                    'General Announcement',
                    'Community Cleanup Day',
                    'Join us for a Community Cleanup Day on Saturday, September 24, 2023, from 8:00 AM to 12:00 PM at the Barangay Park. We invite all residents, young and old, to come together for a day of community service and environmental stewardship.  (Announcement Description) ',
                    'Date: Saturday, September 24, 2023 ',
                    'Time: 8:00 AM - 12:00 PM',
                    'Location: Barangay Park',
                    'EVERYONE CAN PARTICIPATE',
                    'This event is a great opportunity to connect with your neighbors, make a positive impact on our community, and enjoy the outdoors. Lets work together to keep our barangay clean and beautiful.(Closing Tags)',
                    context,
                  ),
                  customListTile(
                    'assets/images/Announcement1.jpg',
                    'General Announcement',
                    'Community Cleanup Day',
                    'Join us for a Community Cleanup Day on Saturday, September 24, 2023, from 8:00 AM to 12:00 PM at the Barangay Park. We invite all residents, young and old, to come together for a day of community service and environmental stewardship.  (Announcement Description) ',
                    'Date: Saturday, September 24, 2023 ',
                    'Time: 8:00 AM - 12:00 PM',
                    'Location: Barangay Park',
                    'EVERYONE CAN PARTICIPATE',
                    'This event is a great opportunity to connect with your neighbors, make a positive impact on our community, and enjoy the outdoors. Lets work together to keep our barangay clean and beautiful.(Closing Tags)',
                    context,
                  ),
                  customListTile(
                    'assets/images/Announcement1.jpg',
                    'General Announcement',
                    'Community Cleanup Day',
                    'Join us for a Community Cleanup Day on Saturday, September 24, 2023, from 8:00 AM to 12:00 PM at the Barangay Park. We invite all residents, young and old, to come together for a day of community service and environmental stewardship.  (Announcement Description) ',
                    'Date: Saturday, September 24, 2023 ',
                    'Time: 8:00 AM - 12:00 PM',
                    'Location: Barangay Park',
                    'EVERYONE CAN PARTICIPATE',
                    'This event is a great opportunity to connect with your neighbors, make a positive impact on our community, and enjoy the outdoors. Lets work together to keep our barangay clean and beautiful.(Closing Tags)',
                    context,
                  ),
                  customListTile(
                    'assets/images/Announcement1.jpg',
                    'General Announcement',
                    'Community Cleanup Day',
                    'Join us for a Community Cleanup Day on Saturday, September 24, 2023, from 8:00 AM to 12:00 PM at the Barangay Park. We invite all residents, young and old, to come together for a day of community service and environmental stewardship.  (Announcement Description) ',
                    'Date: Saturday, September 24, 2023 ',
                    'Time: 8:00 AM - 12:00 PM',
                    'Location: Barangay Park',
                    'EVERYONE CAN PARTICIPATE',
                    'This event is a great opportunity to connect with your neighbors, make a positive impact on our community, and enjoy the outdoors. Lets work together to keep our barangay clean and beautiful.(Closing Tags)',
                    context,
                  ),
                  customListTile(
                    'assets/images/Announcement1.jpg',
                    'General Announcement',
                    'Community Cleanup Day',
                    'Join us for a Community Cleanup Day on Saturday, September 24, 2023, from 8:00 AM to 12:00 PM at the Barangay Park. We invite all residents, young and old, to come together for a day of community service and environmental stewardship.  (Announcement Description) ',
                    'Date: Saturday, September 24, 2023 ',
                    'Time: 8:00 AM - 12:00 PM',
                    'Location: Barangay Park',
                    'EVERYONE CAN PARTICIPATE',
                    'This event is a great opportunity to connect with your neighbors, make a positive impact on our community, and enjoy the outdoors. Lets work together to keep our barangay clean and beautiful.(Closing Tags)',
                    context,
                  ),
                  customListTile(
                    'assets/images/Announcement1.jpg',
                    'General Announcement',
                    'Community Cleanup Day',
                    'Join us for a Community Cleanup Day on Saturday, September 24, 2023, from 8:00 AM to 12:00 PM at the Barangay Park. We invite all residents, young and old, to come together for a day of community service and environmental stewardship.  (Announcement Description) ',
                    'Date: Saturday, September 24, 2023 ',
                    'Time: 8:00 AM - 12:00 PM',
                    'Location: Barangay Park',
                    'EVERYONE CAN PARTICIPATE',
                    'This event is a great opportunity to connect with your neighbors, make a positive impact on our community, and enjoy the outdoors. Lets work together to keep our barangay clean and beautiful.(Closing Tags)',
                    context,
                  ),
                  customListTile(
                    'assets/images/Announcement1.jpg',
                    'Business News',
                    'Community Cleanup Day',
                    'Join us for a Community Cleanup Day on Saturday, September 24, 2023, from 8:00 AM to 12:00 PM at the Barangay Park. We invite all residents, young and old, to come together for a day of community service and environmental stewardship.  (Announcement Description) ',
                    'Date: Saturday, September 24, 2023 ',
                    'Time: 8:00 AM - 12:00 PM',
                    'Location: Barangay Park',
                    'EVERYONE CAN PARTICIPATE',
                    'This event is a great opportunity to connect with your neighbors, make a positive impact on our community, and enjoy the outdoors. Lets work together to keep our barangay clean and beautiful.(Closing Tags)',
                    context,
                  )
                ],
              ),

// -------------------------------- LIVEHOOD LIST --------------------------------
              ListView(
                children: [
                  customLivelihoodListTile(
                    'assets/images/Livelihood1.png',
                    'PROGRAM 1',
                    'Title of the Announcement',
                    context,
                  ),
                  customLivelihoodListTile(
                    'assets/images/Livelihood2.png',
                    'PROGRAM 1',
                    'Title of the Announcement',
                    context,
                  ),
                  customLivelihoodListTile(
                    'assets/images/Livelihood1.png',
                    'PROGRAM 1',
                    'Title of the Announcement',
                    context,
                  ),
                  customLivelihoodListTile(
                    'assets/images/Livelihood2.png',
                    'PROGRAM 8',
                    'Title of the Announcement',
                    context,
                  ),
                  customLivelihoodListTile(
                    'assets/images/Livelihood1.png',
                    'PROGRAM 4',
                    'Title of the Announcement',
                    context,
                  ),
                  customLivelihoodListTile(
                    'assets/images/Livelihood2.png',
                    'Source Name',
                    'Title of the Announcement',
                    context,
                  ),
                  customLivelihoodListTile(
                    'assets/images/Livelihood1.png',
                    'PROGRAM 49',
                    'Title of the Announcement',
                    context,
                  ),
                  customLivelihoodListTile(
                    'assets/images/Livelihood2.png',
                    'PROGRAM 93',
                    'Title of the Announcement',
                    context,
                  ),
                  customLivelihoodListTile(
                    'assets/images/Livelihood1.png',
                    'PROGRAM 76',
                    'Title of the Announcement',
                    context,
                  ),
                  customLivelihoodListTile(
                    'assets/images/Livelihood2.png',
                    'PROGRAM 84',
                    'Title of the Announcement',
                    context,
                  )
                ],
              ),
//  ------------------------------------------------- BUSINESS ADDITIONAL PAGE CONTENT  ----------------------------------------------------------
              ListView(
                children: [
                  customBusinessListTile(
                    'assets/images/BAKE2.jpg',
                    'JERICHOS BAKERY',
                    'Bakery',
                    context,
                    'KEMEMKEEN  ENDJDEICJDKIJCIDJCIJDICJIDJCIJDICJD JDICJDICJIDJCIDJIDCJIJDICJDIJCIDJCD',
                    'Pag Asa st. Mandaluyong',
                    'MONDAY - SUNDAY / 7am-10pm',
                    '09874839938333',
                    [
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                    ],
                    [
                      'Review 1',
                      'Review 2',
                      'Review 3',
                    ],
                  ),
                  customBusinessListTile(
                    'assets/images/Business2.jpg',
                    'Your Source Name',
                    'Your Title',
                    context,
                    'KEMEMKEEN  ENDJDEICJDKIJCIDJCIJDICJIDJCIJDICJD JDICJDICJIDJCIDJIDCJIJDICJDIJCIDJCD',
                    'Pag Asa st. Mandaluyong',
                    'MONDAY - SUNDAY / 7am-10pm',
                    '09874839938333',
                    [
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                    ],
                    [
                      'Review 1',
                      'Review 2',
                      'Review 3',
                    ],
                  ),
                  customBusinessListTile(
                    'assets/images/Business2.jpg',
                    'Your Source Name',
                    'Your Title',
                    context,
                    'KEMEMKEEN  ENDJDEICJDKIJCIDJCIJDICJIDJCIJDICJD JDICJDICJIDJCIDJIDCJIJDICJDIJCIDJCD',
                    'Pag Asa st. Mandaluyong',
                    'MONDAY - SUNDAY / 7am-10pm',
                    '09874839938333',
                    [
                      'assets/images/Announcement1.jpg',
                      'assets/images/Announcement1.jpg',
                      'assets/images/Announcement1.jpg',
                    ],
                    [
                      'Review 1',
                      'Review 2',
                      'Review 3',
                    ],
                  ),
                  customBusinessListTile(
                    'assets/images/Business2.jpg',
                    'Your Source Name',
                    'Your Title',
                    context,
                    'KEMEMKEEN  ENDJDEICJDKIJCIDJCIJDICJIDJCIJDICJD JDICJDICJIDJCIDJIDCJIJDICJDIJCIDJCD',
                    'Pag Asa st. Mandaluyong',
                    'MONDAY - SUNDAY / 7am-10pm',
                    '09874839938333',
                    [
                      'assets/images/BarangayPlayground.png'
                          'assets/images/BarangayPlayground.png'
                          'assets/images/BarangayPlayground.png'
                    ],
                    [
                      'Review 1',
                      'Review 2',
                      'Review 3',
                    ],
                  ),
                  customBusinessListTile(
                    'assets/images/Business2.jpg',
                    'Your Source Name',
                    'Your Title',
                    context,
                    'KEMEMKEEN  ENDJDEICJDKIJCIDJCIJDICJIDJCIJDICJD JDICJDICJIDJCIDJIDCJIJDICJDIJCIDJCD',
                    'Pag Asa st. Mandaluyong',
                    'MONDAY - SUNDAY / 7am-10pm',
                    '09874839938333',
                    [
                      'assets/images/BarangayPlayground.png'
                          'assets/images/BarangayPlayground.png'
                          'assets/images/BarangayPlayground.png'
                    ],
                    [
                      'Review 1',
                      'Review 2',
                      'Review 3',
                    ],
                  ),
                  customBusinessListTile(
                    'assets/images/Business2.jpg',
                    'Your Source Name',
                    'Your Title',
                    context,
                    'KEMEMKEEN  ENDJDEICJDKIJCIDJCIJDICJIDJCIJDICJD JDICJDICJIDJCIDJIDCJIJDICJDIJCIDJCD',
                    'Pag Asa st. Mandaluyong',
                    'MONDAY - SUNDAY / 7am-10pm',
                    '09874839938333',
                    [
                      'assets/images/Livelihood1.png',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                    ],
                    [
                      'Review 1',
                      'Review 2',
                      'Review 3',
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// -------------------------------- DESIGN IN BUSINESS CATEGORY --------------------------------
Widget customBusinessListTile(
  String imagePath,
  String sourceName,
  String title,
  BuildContext context,
  String description,
  String operatingHours,
  String location,
  String phone,
  List<String> imageList,
  List<String> socmeds,
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
            imageList: imageList,
            socmeds: socmeds,
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
  String sourceName,
  String title,
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
      ],
    ),
  );
}

// -------------------------------- DESIGN IN ANNOUNCEMENT CATEGORY --------------------------------
Widget customListTile(
  String imagePath,
  String announcementCategory,
  String announcementTitle,
  String announcementDesc,
  String announcementDate,
  String announcementLocation,
  String announcementTime,
  String announcementParticipants,
  String announcementClosing,
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
//  -------------- ANNOUNCEMENT IMAGE  ------------
          child: Container(
            height: 150.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0), // Clip image to prevent overflow
//  -------------- ANNOUNCEMENT TITLE  ------------
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                announcementTitle.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 8.0),

              //  -------------- ANNOUNCEMENT CATEGORY  ------------
              Container(
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
            ],
          ),
        ),

        // Divider below the title
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(
            height: 6,
          ),
        ),

//  -------------- ANNOUNCEMENT DESCRIPTION  ------------

        Text(
          announcementDesc,
          style: const TextStyle(fontSize: 12.0),
        ),
        const SizedBox(height: 8.0),

//  -------------- ANNOUNCEMENT COLUMNS  ------------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                    announcementDate,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Location:',
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
                  const Text(
                    'Time:',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    announcementTime,
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
                    announcementParticipants,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ],
        ),
//  -------------- ANNOUNCEMENT CLOSING  ------------
        const SizedBox(height: 16.0),
        Text(
          announcementClosing,
          style: const TextStyle(fontSize: 12.0),
        ),
      ],
    ),
  );
}

class AnnouncementDetailsPage extends StatelessWidget {
  final String imagePath;
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
    required this.imagePath,
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
            Image.asset(imagePath),
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

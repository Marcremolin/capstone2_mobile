import 'package:flutter/material.dart';
import 'profilePage.dart';
import '../../../Screens/mapPage.dart';

class Emergency extends StatefulWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _selectedCategory = 'General Report';
    _tabController.addListener(_handleTabSelection);
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

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Evacuation Center', 'Emergency Report '];

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
        body: Column(children: [
          TabBar(
            controller: _tabController,
            labelColor: const Color.fromARGB(255, 255, 255, 255),
            tabs: tabs.map((String tab) {
              return Tab(
                text: tab,
              );
            }).toList(),
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [
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
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
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
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
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
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
                      'assets/images/Business2.jpg',
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
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CustomButton(
                    color: Colors.blue,
                    text: 'POLICE',
                    icon: Icons.local_police_outlined,
                  ),
                  const SizedBox(height: 10),
                  const CustomButton(
                    color: Colors.red,
                    text: 'AMBULANCE',
                    icon: Icons.local_hospital_outlined,
                  ),
                  const SizedBox(height: 10),
                  const CustomButton(
                    color: Colors.orange,
                    text: 'FIRE TRUCK',
                    icon: Icons.fire_truck_outlined,
                  ),
                ],
              )
            ],
          ))
        ]));
  }
}

// ------------------------- EMERGENCY BUTTONS Design & Function ----------------------------
class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final IconData icon;

  const CustomButton(
      {super.key, required this.color, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showConfirmationDialog(context);
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
                color: const Color.fromRGBO(233, 238, 249, 1),
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

// ----------------------------------- POPUP RED CONFIRNMATION DIALOG -----------------------------------
void showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors
            .transparent, // Make the background transparent kasi White yung deafult
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
              const SizedBox(
                  height: 20), // height space between title and content

              const Text(
                ' ARE YOU SURE YOU WANT TO SEND DISTRESS SIGNAL? ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20), // space between content and buttons
              const Divider(
                color: Color.fromARGB(168, 255, 255, 255),
                thickness: 2,
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showSuccessDialog(context);
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
                  const SizedBox(width: 40), // Add space between buttons
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'DISCARD',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
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
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(16.0), // Equal margin on all sides
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

// ------------------------- EVACUATION Design & Function ----------------------------
Widget customListTile(
  String imagePath,
  String evacName,
  String evacAddress,
  BuildContext context,
  String mapImage,
  String evacContact,
  String directionButton,
  List<String> imageList,
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

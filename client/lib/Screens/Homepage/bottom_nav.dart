// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:client/Screens/faq.dart';
import 'package:client/Screens/emergency.dart';
import 'package:client/Screens/Homepage/Homepage.dart';
import '../request_document.dart';

class BottomNav extends StatefulWidget {
  final String? token;
  const BottomNav({Key? key, this.token}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  var currentIndex = 0;

  List<Widget> screens = [];
//FOR TOKEN ---------------------------
  @override
  void initState() {
    super.initState();
    ('Token in BottomNav: ${widget.token}');
//reference to the token property that you passed to the BottomNav widget when you created an instance of it. The widget property is a reference to the current instance of the widget, and you can access its properties and methods using the widget keyword.
    screens = [
      AnnouncementPage(token: widget.token),
      Documentation(token: widget.token),
      Emergency(token: widget.token),
      const ChatApp(),
    ];
  }
//---------------------------------------------------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 239, 246),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        height: size.width * 0.155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -3),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: listOfIcons.asMap().entries.map((entry) {
            final index = entry.key;
            final icon = entry.value;
            final isSelected = index == currentIndex;

            return InkWell(
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: size.width * 0.066,
                    color: isSelected ? Colors.blueAccent : Colors.black38,
                  ),
                  SizedBox(height: size.width * 0.01),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: size.width * 0.108,
                    height: isSelected ? size.width * 0.014 : 0,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.document_scanner_outlined,
    Icons.emergency_share_outlined,
    Icons.message_outlined,
  ];
}

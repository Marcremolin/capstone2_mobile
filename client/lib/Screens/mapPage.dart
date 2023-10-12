import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class mapPage extends StatelessWidget {
  final String evacName;
  final String evacAddress;
  final String evacContact;
  final String mapImage;

  final String directionButton;
  final List<String> imageList;

  const mapPage({
    Key? key,
    required this.mapImage,
    required this.evacName,
    required this.evacAddress,
    required this.evacContact,
    required this.directionButton,
    required this.imageList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color secondaryTextColor = Colors.grey;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Map to Evacuation Center'),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          evacName,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Text(
                    evacAddress,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),

                  // MAIN IMAGE
                  Image.asset(
                    mapImage,
                    width: 300,
                    height: 500,
                    fit: BoxFit.cover,
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  // CONTACT NUMBER AND BUTTON
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Contact",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                evacContact,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: secondaryTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Move the InkWell here
                      InkWell(
                        onTap: () async {
                          const url =
                              'https://www.google.com/maps/place/Magalona+St,+Mandaluyong,+Metro+Manila/@14.5931888,121.0298685,17z/data=!3m1!4b1!4m6!3m5!1s0x3397c9cd88270ea9:0x48ccddf8a2ffb3ff!8m2!3d14.5931888!4d121.0298685!16s%2Fg%2F1vd6zw89?entry=ttu'; // Replace with your desired URL
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 40),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: const Column(
                            children: [
                              Text(
                                "GET DIRECTIONS",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),

                  // IMAGES SECTION
                  const Text(
                    "Nearby Location",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: imageList.take(2).map((imagePath) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              imagePath,
                              width: 140,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: imageList.take(2).map((imagePath) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              imagePath,
                              width: 140,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }
}

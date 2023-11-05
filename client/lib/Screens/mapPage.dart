import 'package:flutter/material.dart';

class mapPage extends StatelessWidget {
  final String evacName;
  final String evacAddress;
  final String evacContact;
  final String mapImage;
  final String directionButton;
  final List<String> imageList;
  final List<String> imageName;

  List<Map<String, String>> imageAndNameList = [];

  mapPage({
    Key? key,
    required this.mapImage,
    required this.evacName,
    required this.evacAddress,
    required this.evacContact,
    required this.directionButton,
    required this.imageList,
    required this.imageName,
  }) : super(key: key) {
    initializeImageAndNameList();
  }

  void initializeImageAndNameList() {
    imageAndNameList = List.generate(
      imageList.length,
      (index) => {
        'imagePath': imageList[index],
        'name': imageName[index],
      },
    );
  }

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
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),

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
                  // -------------------------------------- IMAGES SECTION SHIT --------------------
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: imageAndNameList.take(2).map((item) {
                          return Column(
                            children: [
                              Image.asset(
                                item['imagePath']!,
                                width: 140,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Divider(
                                  height: 4,
                                ),
                              ),
                              Text(
                                item['name']!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Divider(
                                  height: 4,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: imageAndNameList.skip(2).take(2).map((item) {
                          return Column(
                            children: [
                              Image.asset(
                                item['imagePath']!,
                                width: 140,
                                height: 200,
                                fit: BoxFit.cover,
                              ),

                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Divider(
                                  height: 4,
                                ),
                              ), //
                              Text(
                                item['name']!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Divider(
                                  height: 4,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  )

// -------------------------------------- END IMAGES SECTION SHIT -----------------------------
                ],
              )),
        ));
  }
}

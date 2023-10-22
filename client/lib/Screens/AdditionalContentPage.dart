import 'package:flutter/material.dart';

class AdditionalContentPage extends StatelessWidget {
  final String imagePath;
  final String sourceName;
  final String title;
  final String description;
  final String operatingHours;
  final String location;
  final String phone;
  final String owner;

  const AdditionalContentPage({
    Key? key,
    required this.imagePath,
    required this.sourceName,
    required this.title,
    required this.description,
    required this.operatingHours,
    required this.location,
    required this.phone,
    required this.owner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color secondaryTextColor = Colors.grey;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      sourceName,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 30,
                    ),
                  ],
                ),
              ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              // MAIN IMAGE
              Image.asset(
                imagePath,
                width: 500,
                height: 200,
                fit: BoxFit.cover,
              ),

              // Description section
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  height: 4,
                ),
              ),
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: secondaryTextColor,
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  height: 4,
                ),
              ),

              // Operating Hours and Store Location section
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Operating Hours",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          operatingHours,
                          style: TextStyle(
                            fontSize: 16,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Store Location",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          location,
                          style: TextStyle(
                            fontSize: 16,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
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
              // Operating Hours and Store Location section
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Contact Number",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          operatingHours,
                          style: TextStyle(
                            fontSize: 16,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Owner",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          location,
                          style: TextStyle(
                            fontSize: 16,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
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
            ],
          ),
        ),
      ),
    );
  }
}

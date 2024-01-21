import 'package:flutter/material.dart';

class AboutBarangayPage extends StatelessWidget {
  const AboutBarangayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 239, 246),
      appBar: AppBar(
        title: const Text('About Barangay'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: 220,
                height: 220,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(
                    image: AssetImage('assets/icons/brgy.png'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'BRGY. HARAPIN ANG BUKAS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 8, 123, 218),
                ),
              ),
              const SizedBox(height: 10),
              const Column(
                children: [
                  ListTile(
                    subtitle: Text(
                      "One of the barangay in the city of Mandaluyong. Its population as determined by the 2020 Census was 4,244. This represented 1.00% of the total population of Mandaluyong.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 57, 57, 57),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 220,
                height: 220,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(
                    image: AssetImage('assets/images/MAP2.png'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Barangay Map',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 145, 0),
                ),
              ),
              const SizedBox(height: 10),
              const Column(
                children: [
                  ListTile(
                    subtitle: Text(
                      "Harapin Ang Bukas is situated at approximately 14.5920, 121.0262, in the island of Luzon. Elevation at these coordinates is estimated at 7.0 meters or 23.0 feet above mean sea level.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 57, 57, 57),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 300,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 255, 145, 0),
                    width: 5,
                  ),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Mission",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        "We are committed to delivering efficient and transparent public service, promoting community engagement, and fostering sustainable development for the benefit of all our residents. Through collaboration, innovation, and inclusivity, we strive to create a barangay that is safe, resilient, and offers opportunities for growth and well-being",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(
                              255, 57, 57, 57), // Set the subtitle text color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 300,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 255, 145, 0),
                    width: 5,
                  ),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Vision",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        "To be a safe, thriving, and inclusive community that empowers our residents to lead happy and fulfilled lives.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(
                              255, 57, 57, 57), // Set the subtitle text color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

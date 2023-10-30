import 'package:flutter/material.dart';
import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10), // Added contentPadding
                child: Text(
                  "Welcome to D'Barangay Mobile",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  textAlign: TextAlign
                      .center, // Center the text within the Text widget.
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding * 0.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Expanded(
                flex: 8,
                child: Image.asset("assets/icons/logo.png"),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: defaultPadding * 2),
        ],
      ),
    );
  }
}

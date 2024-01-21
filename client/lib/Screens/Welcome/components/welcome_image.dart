import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Welcome to D'Barangay Mobile",
                  style: GoogleFonts.robotoSlab(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: const Color.fromARGB(255, 9, 71, 151),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding * 0.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Transform.scale(
                    scale: 1.3,
                    child: Image.asset(
                      "assets/icons/brgy.png",
                      width: 250,
                      height: 250,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

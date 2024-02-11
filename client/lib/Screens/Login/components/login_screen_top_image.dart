// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreenTopImage extends StatefulWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreenTopImage> createState() => _LoginScreenTopImageState();
}

class _LoginScreenTopImageState extends State<LoginScreenTopImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding), // Add default padding here
      child: Column(
        children: [
          Text(
            "Login",
            style: GoogleFonts.robotoSlab(
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: const Color.fromARGB(255, 9, 71, 151),
              letterSpacing: 3.0,
            ),
          ),
          const SizedBox(height: defaultPadding), // Apply default padding
          const Text(
            "Welcome back! Please enter your credentials to log in.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 45, 120, 195),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: defaultPadding * 2),
          Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 2,
                child: Image.asset("assets/icons/brgy.png"),
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

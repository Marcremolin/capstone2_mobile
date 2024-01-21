import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          toolbarHeight: 80.0,
          title: Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: Text(
              "Registration".toUpperCase(),
              style: GoogleFonts.robotoSlab(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 9, 71, 151),
                fontSize: 32,
              ),
            ),
          ),
          centerTitle: true,
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}

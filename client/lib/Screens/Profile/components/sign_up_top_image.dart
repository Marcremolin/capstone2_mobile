import 'package:flutter/material.dart';
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
            icon: const Icon(Icons.arrow_back,
                color: Colors.black), // Back button icon
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          toolbarHeight: 80.0, // toolbar height
          // title: Container(
          //   margin: const EdgeInsets.only(top: 30.0), //  top margin
          //   child: Text(
          //     "Edit Profile".toUpperCase(),
          //     style: const TextStyle(
          //         fontWeight: FontWeight.bold, color: Colors.black),
          //   ),
          // ),
          centerTitle: true,
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child:
                  Image.asset("assets/images/Notifications_Monochromatic.png"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}

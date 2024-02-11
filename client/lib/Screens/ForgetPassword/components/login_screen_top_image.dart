// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Login",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Color.fromARGB(255, 9, 71, 151),
          ),
        ),
        const SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 2,
              child: Image.asset("assets/icons/logo.png"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}

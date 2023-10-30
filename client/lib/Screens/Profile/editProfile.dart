// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:client/constants.dart';
import 'package:client/responsive.dart';
import '../../Screens/Login/components/background.dart';
import 'components/sign_up_top_image.dart';
import 'components/editProfile.dart';

class EditIconPage extends StatefulWidget {
  final String? token; // Make the token parameter optional
  const EditIconPage({Key? key, this.token}) : super(key: key);

  @override
  _EditIconPageState createState() => _EditIconPageState();
}

class _EditIconPageState extends State<EditIconPage> {
  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      print('Token in EditIconPage: ${widget.token}');
    } else {
      print('Token in editProfile is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileSignupScreen(
              token: widget.token ??
                  ''), // Provide a default value if token is null

          desktop: Row(
            children: [
              const Expanded(
                child: SignUpScreenTopImage(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: EditProfile(
                        token: widget.token,
                      ),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    // SocalSignUp()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  final String token; // Add a token parameter to the constructor
  const MobileSignupScreen({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SignUpScreenTopImage(),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: EditProfile(token: token), // Use the token parameter
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}

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
          mobile: MobileSignupScreen(),
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
                    SizedBox(height: defaultPadding / 2),
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
  const MobileSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SignUpScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: EditProfile(
                token: 'token',
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}

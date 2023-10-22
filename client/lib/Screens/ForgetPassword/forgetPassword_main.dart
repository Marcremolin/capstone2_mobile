import 'package:flutter/material.dart';
import 'package:client/responsive.dart';
import '../Login/components/background.dart';
import 'components/forgetPassword.dart';
import 'components/login_screen_top_image.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final token;
  const ForgetPasswordScreen({@required this.token, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileForgetPasswordScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: LoginScreenTopImage(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: ForgetPasswordForm(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileForgetPasswordScreen extends StatelessWidget {
  const MobileForgetPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoginScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: ForgetPasswordForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}

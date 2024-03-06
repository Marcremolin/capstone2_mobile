import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import '../../Signup/signup_screen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 400,
          child: Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen(
                        token: null,
                      );
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 29, 119, 255),
                elevation: 0,
                foregroundColor: Colors.white,
              ),
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 400,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              elevation: 0,
              foregroundColor: Colors.white,
            ),
            child: Text(
              "Sign Up".toUpperCase(),
            ),
          ),
        ),
      ],
    );
  }
}

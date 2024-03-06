// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api, use_super_parameters, unused_local_variable

import 'dart:convert';
import 'package:client/Screens/Homepage/bottom_nav.dart';
import 'package:flutter/material.dart';
import '../../Login/components/already_have_an_account_acheck.dart';
import '../../ForgetPassword/components/forgetPassword.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  late SharedPreferences prefs;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    String email = emailController.text;
    String password = passwordController.text;
    password = password.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog("Please enter both email and password.");
      return;
    }

    var reqBody = {"email": email, "password": password};

    setState(() {
      isLoading = true;
    });

    try {
      var url = Uri.parse('https://dbarangay-mobile-e5o1.onrender.com/login');
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer",
          "Content-Type": "application/json",
        },
        body: jsonEncode(reqBody),
      );

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('error')) {
        String errorMessage =
            jsonResponse['error'] ?? 'An unknown error occurred.';
        print('Login Failed: $errorMessage');
        if (errorMessage == 'User does not exist') {
          // Update condition to match the error message
          _showUserNotFoundErrorDialog();
        } else {
          _showErrorDialog(errorMessage);
        }
      } else if (jsonResponse.containsKey('token')) {
        String token = jsonResponse['token'];
        prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        Map<String, dynamic> payload = JwtDecoder.decode(token);
        String userId = payload['_id'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BottomNav(token: "Bearer $token");
            },
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 48.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitThreeInOut(
                  color: Theme.of(context).primaryColor,
                  size: 40.0,
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Hold on, we're securely verifying your credentials!",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// PROPMT WHEN THE USERS EMAIL AND PASSWORD FIELD IS EMPTY
  void _showErrorDialog(String errorMessage) {
    Navigator.of(context).pop(); // Dismiss the loading dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

// PROMPT ALERT WHEN THE USERS INPUTTED DATA IS NOT YET IN THE DATABASE
  void _showUserNotFoundErrorDialog() {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 24.0), // Add top padding
            child: Text(
              "USER NOT FOUND",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          content: const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "It appears you're not registered with us. Please sign up to continue.",
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        minimumSize: const Size(100, 40),
                      ),
                      child:
                          const Text("Try Again", textAlign: TextAlign.center),
                    ),
                    const SizedBox(width: 16), // Space between buttons
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        minimumSize: const Size(100, 40),
                      ),
                      child: const Text("Sign Up Now",
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
              filled: true,
              fillColor: const Color.fromARGB(135, 227, 227, 227),
              hintStyle: const TextStyle(color: Colors.black),
              contentPadding: const EdgeInsets.all(defaultPadding),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 3.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 3.0,
                ),
              ),
            ),
            style: const TextStyle(
              color: Color.fromARGB(255, 27, 25, 25),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'EMAIL IS REQUIRED';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
                filled: true,
                fillColor: const Color.fromARGB(135, 227, 227, 227),
                hintStyle: const TextStyle(color: Colors.black),
                contentPadding: const EdgeInsets.all(defaultPadding),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: Color(0xFF2196F3),
                    width: 3.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 3.0,
                  ),
                ),
              ),
              style: const TextStyle(
                color: Color.fromARGB(255, 27, 25, 25),
              ),
              obscureText: !isPasswordVisible, // Toggles password visibility
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'PASSWORD IS REQUIRED';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                _showLoadingDialog();
                loginUser();
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
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
          const SizedBox(height: defaultPadding),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ForgetPasswordForm();
                  },
                ),
              );
            },
            child: const Text("Forgot Password?",
                style: TextStyle(color: kPrimaryColor)),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}

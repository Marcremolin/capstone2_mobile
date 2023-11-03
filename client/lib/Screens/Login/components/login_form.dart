// ignore_for_file: use_build_context_synchronously, avoid_print

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

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

// ---- DATABASE FUNCTION ----------------
  void loginUser() async {
    String email = emailController.text;
    String password = passwordController.text;
    password = password.trim();

    if (email.isEmpty || password.isEmpty) {
      print('Please enter both email and password.');
      return;
    }

    var reqBody = {"email": email, "password": password};

    var url = Uri.parse('https://dbarangay-mobile-e5o1.onrender.com/login');
    try {
      print('Request Payload: ${jsonEncode(reqBody)}');
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer",
          "Content-Type": "application/json",
        },
        body: jsonEncode(reqBody),
      );

      print('Response: ${response.body}');

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('error')) {
        String errorMessage =
            jsonResponse['error'] ?? 'An unknown error occurred.';
        print('Login Failed: $errorMessage');
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
    }
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
                loginUser();
              },
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
            child: const Text("Forgot Password?"),
          ),
        ],
      ),
    );
  }
}

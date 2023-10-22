import 'dart:convert';
import 'package:client/Screens/Homepage/bottom_nav.dart';

import 'package:flutter/material.dart';
import '../../Login/components/already_have_an_account_acheck.dart';
import '../../ForgetPassword/components/forgetPassword.dart';
import '../../ForgetPassword/forgetPassword_main.dart';

import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailAddressController = TextEditingController();
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
<<<<<<< Updated upstream
    var reqBody = {
      //Objects to send in the Backend
      "emailAddress": emailAddressController.text,
      "password": passwordController.text
    };

    var url = Uri.parse('http://192.168.55.107:8000/login');
    try {
      var response = await http.post(
         url = Uri.parse(login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody), //REQUEST BODY
      );
      var jsonResponse = jsonDecode(response.body);
      
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        
        prefs.setString('token', myToken);
=======
    String email = emailAddressController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      print('Please enter both email and password.');
      return; // Do not proceed with the request.
    }

    var reqBody = {"emailAddress": email, "password": password};

    var url = Uri.parse('http://192.168.0.28:8000/login');
    try {
      print('Request Payload: ${jsonEncode(reqBody)}');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      print('Response: ${response.body}');

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        // Handle successful login
>>>>>>> Stashed changes
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const BottomNav();
            },
          ),
        );
      } else {
<<<<<<< Updated upstream
        print('HTTP Error: ${response.statusCode}');
=======
        // Handle login failure
        print('Login Failed: ${jsonResponse['message']}');
>>>>>>> Stashed changes
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
            keyboardType: TextInputType.emailAddress,
            controller: emailAddressController,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (emailAddress) {},
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
              textInputAction: TextInputAction.done,
              controller: passwordController,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
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
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
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
            child: Text("Forgot Password?"),
          ),
        ],
      ),
    );
  }
}

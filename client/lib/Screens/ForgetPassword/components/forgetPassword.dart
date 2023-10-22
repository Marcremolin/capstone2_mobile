import 'dart:convert';
import 'package:client/Screens/Homepage/bottom_nav.dart';

import 'package:flutter/material.dart';
import '../../ForgetPassword/components/already_have_an_account_acheck.dart';
import '../../ForgetPassword/components/forgetPassword.dart';
import '../../Login/components/login_form.dart';
import '../../Login/login_screen.dart';

import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgetPasswordFormState createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late SharedPreferences prefs;
  bool obscureTextNewPassword = true;
  bool obscureTextConfirmPassword = true;
  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void resetPassword() async {
    final String emailAddress = emailAddressController.text;
    final String newPassword = newPasswordController.text;

    // Validate the input
    if (emailAddress.isEmpty || newPassword.isEmpty) {
      // Show an error message to the user
      showFailureDialog(context, "Please provide both email and new password.");
      return;
    }

    final response = await http.put(
      Uri.parse(
          'http://192.168.0.28:8000/forgetPassword/update-password/$emailAddress'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      // Password updated successfully
      showSuccessDialog(context);
    } else {
      // Show an error message based on the response from the backend
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['error'];
      showFailureDialog(context, errorMessage);
    }
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Password Reset Successfully"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: const Text("Proceed to Login"),
            ),
          ],
        );
      },
    );
  }

  void showFailureDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Password Reset Failed"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text("Try Again"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 74,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Form(
                child: Column(
                  children: [
//---------------------------- EMAIL ADDRESS -----------------------------------
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailAddressController,
                      decoration: InputDecoration(
                        hintText: "Your email",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.email),
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
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
//--------------------------------------- NEW PASSWORD -----------------------------------------
                    TextFormField(
                      controller: newPasswordController,
                      obscureText: obscureTextNewPassword,
                      decoration: InputDecoration(
                        hintText: "Your new password",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.lock),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureTextNewPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureTextNewPassword = !obscureTextNewPassword;
                            });
                          },
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
                          return 'New Password is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
//--------------------------------------- CONFIRM NEW PASSWORD -----------------------------------------
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: obscureTextConfirmPassword,
                      decoration: InputDecoration(
                        hintText: "Confirm your new password",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.lock),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureTextConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureTextConfirmPassword =
                                  !obscureTextConfirmPassword;
                            });
                          },
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
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm Password is required';
                        }
                        return null;
                      },
                    ),
//--------------------------------------- RESET BUTTON -----------------------------------------
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: resetPassword,
                      child: Text("Reset Password".toUpperCase()),
                    ),
                    const SizedBox(height: 16),
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

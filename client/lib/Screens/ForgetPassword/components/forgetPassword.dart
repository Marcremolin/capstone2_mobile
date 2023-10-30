// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print

import 'dart:convert';
import 'package:client/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Login/login_screen.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgetPasswordFormState createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  SharedPreferences? prefs;
  bool obscureTextNewPassword = true;
  bool obscureTextConfirmPassword = true;
  bool isVerified = false;
  bool showVerificationCodeInput = false; // Show verification code input
  final TextEditingController verificationCodeController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  final String apiUrl = "http://192.168.0.28:8000";
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          content: SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Password Reset Failed",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 229, 89, 79),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text("Try Again",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        );
      },
    );
  }

  void showVerificationSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          content: SizedBox(
            height: 250,
            width: 500,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Center(
                      child: Text(
                        "Verification Successful",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "You can now login using your new password. Your account has been successfully verified.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      height: 50,
                      width: 180,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen(
                              token: null,
                            ),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 8, 131, 57),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(
                          "Proceed to Login",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        );
      },
    );
  }

  Future<void> resetPassword() async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/forgetpass'),
        body: jsonEncode({
          'email': emailController.text,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        print('Showing verification dialog');
        _showVerificationDialog();
      } else {
        print('Error initiating password reset request');
      }
    } catch (e) {
      print('Error in resetPassword: $e');
    }
  }

  void _showVerificationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text("Enter Verification Code"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: verificationCodeController,
                decoration: InputDecoration(
                  labelText: "Verification Code",
                  filled: true,
                  fillColor: const Color(0xFFE3E3E3),
                  hintStyle: const TextStyle(color: Colors.black),
                  contentPadding: const EdgeInsets.all(12.0),
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
                    return 'Verification Code is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  verifyPasswordReset();
                  Navigator.of(context).pop();
                },
                child: const Text("Verify"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> verifyPasswordReset() async {
    final email = emailController.text;
    final verificationCode = verificationCodeController.text;
    final newPassword = newPasswordController.text;

    if (email.isEmpty || verificationCode.isEmpty || newPassword.isEmpty) {
      showErrorDialog('Please fill in all the required fields.');
      return;
    }
    final response = await http.post(
      Uri.parse('$apiUrl/verifyAndResetPassword'),
      body: jsonEncode({
        'email': emailController.text,
        'verificationCode': verificationCodeController.text,
        'newPassword': newPasswordController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      showVerificationSuccessDialog();
    } else {
      showErrorDialog(
          'Error verifying the password reset. Please check your verification code.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final emailErrorController = TextEditingController();
    final newPasswordErrorController = TextEditingController();
    final confirmPasswordErrorController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Reset'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
//---------------------------- EMAIL ADDRESS -----------------------------------
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: emailController,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          hintText: "New password",
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
                                obscureTextNewPassword =
                                    !obscureTextNewPassword;
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
                            return 'New Password is required';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*])')
                              .hasMatch(value)) {
                            return 'Password must contain upper and lower case letters, numbers, and special characters';
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
                          if (value != newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
//--------------------------------------- RESET BUTTON -----------------------------------------
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            resetPassword();
                          } else {
                            if (emailController.text.isEmpty) {
                              emailErrorController.text = 'Email is required';
                            }
                            if (newPasswordController.text.isEmpty) {
                              newPasswordErrorController.text =
                                  'New Password is required';
                            }
                            if (confirmPasswordController.text.isEmpty) {
                              confirmPasswordErrorController.text =
                                  'Confirm Password is required';
                            }
                          }
                        },
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
      ),
    );
  }
}

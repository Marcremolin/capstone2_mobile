// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unnecessary_null_comparison, library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';

class FeedbackPage extends StatefulWidget {
// FOR TOKEN -----------------------------
  final token;
  const FeedbackPage({Key? key, this.token}) : super(key: key);
  // -----------------------------------------
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late String userId; //FOR TOKEN

  List<bool> starSelection = [false, false, false, false, false];
  bool isSubmitted = false;
  final feedbackController = TextEditingController();
  final dateController = TextEditingController();

  //FOR TOKEN ----------------------
  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      print('Token is not null: ${widget.token}');
      try {
        Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
        if (jwtDecodedToken.containsKey('_id')) {
          userId = jwtDecodedToken['_id'];
          print('User ID: $userId');
        } else {
          print('JWT token does not contain user ID.');
        }
      } catch (e) {
        print('Error decoding JWT token: $e');
      }
    } else {
      print('Token is null.');
    }
  }

  // ------------------------------------------------------------------

  void selectStar(int index) {
    setState(() {
      for (int i = 0; i < starSelection.length; i++) {
        starSelection[i] = (i <= index);
      }
    });
  }

  void feedbackReq() async {
    if (userId != null) {
      var now = DateTime.now();
      var formattedDate =
          "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";
      var regBody = {
        "userId": userId,
        "date": formattedDate,
        "feedback": feedbackController.text,
      };

      var url =
          Uri.parse('https://dbarangay-mobile-e5o1.onrender.com/feedback');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['status']);
        submitFeedback();
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } else {
      print('userId is not initialized.');
    }
  }

  void submitFeedback() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Text(
                    'Thank you for your valuable feedback!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Center(
                  child: Text(
                    'We appreciate your suggestions and contributions to improving our community.',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 239, 246),
        appBar: AppBar(
          title: const Text("Feedback"),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 230, 239, 246),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Feedback.png',
                        width: 150,
                        height: 150,
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'We value your feedback and suggestions!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 193, 59),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 8, 123, 218),
                            width: 5.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: feedbackController,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            hintText: 'Enter your feedback...',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          maxLines: 10,
                        ),
                      ),
                      const SizedBox(height: 24.0),

                      // SUBMIT FEEDBACK BUTTON ---
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: feedbackReq,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text('Submit Feedback'),
                        ),
                      ),
                      const SizedBox(height: 16.0),
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

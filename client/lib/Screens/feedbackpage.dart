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
          Uri.parse('http://192.168.0.28:8000/feedback'); // HOME IP ADDRESS

      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['status']);
        submitFeedback(); // Call the success dialog function
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
                      Navigator.of(context).pop(); // Close the dialog
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
        backgroundColor: const Color.fromARGB(255, 2, 95, 170),
        appBar: AppBar(
          title: const Text("Feedback"),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 2, 95, 170),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
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
                            color: Colors.yellow,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 138, 175, 227),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextFormField(
                            controller: feedbackController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your feedback...',
                              border: InputBorder.none,
                            ),
                            maxLines: 10,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            starSelection.length,
                            (index) => StarIcon(
                              selected: starSelection[index],
                              onPressed: () => selectStar(index),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: feedbackReq,
                            child: const Text('Submit Feedback'),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StarIcon extends StatelessWidget {
  final bool selected;
  final VoidCallback onPressed;

  const StarIcon({
    Key? key,
    required this.selected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        selected ? Icons.star : Icons.star_border,
        color: selected ? Colors.yellow : Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}

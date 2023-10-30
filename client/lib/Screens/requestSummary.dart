// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/material.dart';
import 'ProfilePage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class RequestSummary extends StatefulWidget {
  // FOR TOKEN
  final token;
  const RequestSummary({Key? key, this.token}) : super(key: key);

  @override
  _RequestSummaryState createState() => _RequestSummaryState();
}

class RequestData {
  final String userId;
  final String typeOfDocument;
  final String dateOfPickUp;
  final String reasonForRequesting;
  final String paymentMethod;
  final String paymentReferenceNumber;
  final String status;

  RequestData({
    required this.userId,
    required this.typeOfDocument,
    required this.dateOfPickUp,
    required this.reasonForRequesting,
    required this.paymentMethod,
    required this.paymentReferenceNumber,
    required this.status,
  });
}

class _RequestSummaryState extends State<RequestSummary> {
  late String userId; // FOR TOKEN
  List<RequestData> requests = []; // List to store request summaries

  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      userId = jwtDecodedToken['_id'];
      fetchRequestSummary();
    }
  }

  // Function to fetch request summary
  Future<void> fetchRequestSummary() async {
    var token = widget.token;
    if (token.startsWith('Bearer ')) {
      token = token.substring(7);
    }

    final url = Uri.parse('http://192.168.0.28:8000/summary');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> requestsData = responseData["requests"];

        setState(() {
          requests.clear();
        });

        for (var data in requestsData) {
          final request = RequestData(
            userId: data['userId'],
            typeOfDocument: data['typeOfDocument'],
            dateOfPickUp: data['dateOfPickUp'],
            reasonForRequesting: data['reasonForRequesting'],
            paymentMethod: data['paymentMethod'],
            paymentReferenceNumber: data['paymentReferenceNumber'],
            status: data['status'],
          );

          setState(() {
            requests.add(request);
          });
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (exception) {
      print('Exception occurred: $exception');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 95, 170),
      appBar: AppBar(
        title: const Text('Request Summary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              for (var request in requests)
                RequestWidget(
                  userId: request.userId,
                  reasonForRequesting: request.reasonForRequesting,
                  paymentMethod: request.paymentMethod,
                  paymentReferenceNumber: request.paymentReferenceNumber,
                  typeOfDocument: request.typeOfDocument,
                  dateOfPickUp: request.dateOfPickUp,
                  status: request.status,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class RequestWidget extends StatelessWidget {
  final String typeOfDocument;
  final String userId;
  final String dateOfPickUp;
  final String status;

  final String reasonForRequesting;
  final String paymentMethod;
  final String paymentReferenceNumber;
  const RequestWidget({
    super.key,
    required this.typeOfDocument,
    required this.userId,
    required this.dateOfPickUp,
    required this.status,
    required this.reasonForRequesting,
    required this.paymentMethod,
    required this.paymentReferenceNumber,
  });

// POPUP "VIEW REQUEST" DESIGN AND FUNCTION
  void _showRequestDetails(BuildContext context) {
    DateTime parsedDate = DateTime.parse(dateOfPickUp);
    String formattedDate = DateFormat('y/MM/d').format(parsedDate);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader('Request Details'),
                  const SizedBox(height: 10),
                  _buildDivider(),
                  _buildFormEntry('User ID', userId),
                  _buildFormEntry('Request', typeOfDocument),
                  _buildFormEntry('Date of Pickup', formattedDate),
                  _buildFormEntry('Reason for Requesting', reasonForRequesting),
                  _buildFormEntry('Payment Method', paymentMethod),
                  _buildFormEntry(
                      'Payment Reference Number', paymentReferenceNumber),
                  const SizedBox(height: 10),
                  _buildDivider(),
                  _buildCloseButton(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormEntry(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Text('$label:'),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(thickness: 2);
  }

  Widget _buildCloseButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

// ----------- REQUEST WIDGET DESIGN AND FUNCTIONS -----------
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(199, 56, 56, 56).withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Column(
              children: [
                Text(
                  typeOfDocument,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            subtitle: Text(
              dateOfPickUp,
              textAlign: TextAlign.center,
            ),
            contentPadding: const EdgeInsets.only(bottom: 8),
          ),
          // BUTTONS SECTION ------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100,
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      _showRequestDetails(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.yellow.shade700),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    child: const Text(
                      'View Request',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.orange.shade700),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

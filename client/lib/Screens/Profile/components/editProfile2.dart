// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../../constants.dart';
// import '../../../Screens/Homepage/bottom_nav.dart';
// // iMPORTANT IMPORTS
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';


// class _ProfilePage2State extends State<ProfilePage2> {
//   String? token;

//   // This function can be called when the user logs in to update the token.
//   void updateToken(String newToken) {
//     setState(() {
//       token = newToken;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Use the 'token' variable in your profile page as needed.
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Token: $token'),
//             ElevatedButton(
//               onPressed: () {
//                 // Simulate a login and update the token.
//                 String newToken = 'new_token_value';
//                 widget.updateTokenCallback(newToken);
//               },
//               child: Text('Log In'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

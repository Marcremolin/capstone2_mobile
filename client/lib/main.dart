import 'package:flutter/material.dart';
import 'package:client/Screens/Welcome/welcome_screen.dart';
import 'package:client/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(token: prefs.getString('token')));
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Capstone2',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 8, 123, 218),
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 8, 123, 218),
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color.fromARGB(255, 152, 191, 223),
          iconColor: kPrimaryColor,
          prefixIconColor: Color.fromARGB(255, 0, 41, 74),
          contentPadding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

// retrieve the token from shared preferences and pass it to your app's root widget, which is your MyApp. This is done to ensure that when your app starts, it checks if there's a token in shared preferences. If a token exists, it's passed to the MyApp, allowing you to handle the user's authentication status and redirect the user accordingly.

//The app starts with the Welcome Screen.
// The user chooses to log in on the Welcome Screen.
// The user logs in successfully, and a token is generated.
// After successful login, you navigate to the BottomNav or another screen.
// In this flow, you don't have the token when the app first starts. You get the token as a result of the login process. The token is then stored in shared preferences and can be accessed in the BottomNav or other screens as needed.

// So, you can remove the code in the main function and keep the app startup flow as you initially described, with the Welcome Screen as the first thing the user sees, and navigation to other screens like BottomNav happening after the user logs in and the token is generated.





















// import 'package:flutter/material.dart';
// import 'package:client/Screens/Welcome/welcome_screen.dart';
// import 'package:client/constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // import 'package:jwt_decoder/jwt_decoder.dart';
// // import 'package:client/Screens/Homepage/bottom_nav.dart';
// //to keep the users Login in app, we need to check if there is any data stored in SHARED PREFERENCE OR NONE
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences
//       .getInstance(); //need to pass this to shared prefs token to get the token that is stored in the shared preferences
//   runApp(MyApp(
//     // and pass it to the app
//     token: prefs.getString('token'),
//   ));
// }

// class MyApp extends StatelessWidget {
//   final token;
//   const MyApp({@required this.token, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Capstone2',
//         theme: ThemeData(
//             primaryColor: const Color.fromARGB(255, 8, 123, 218),
//             scaffoldBackgroundColor: Colors.white,
//             elevatedButtonTheme: ElevatedButtonThemeData(
//               style: ElevatedButton.styleFrom(
//                 elevation: 0,
//                 backgroundColor: const Color.fromARGB(255, 8, 123, 218),
//                 shape: const StadiumBorder(),
//                 maximumSize: const Size(double.infinity, 56),
//                 minimumSize: const Size(double.infinity, 56),
//               ),
//             ),
//             inputDecorationTheme: const InputDecorationTheme(
//               filled: true,
//               fillColor: Color.fromARGB(255, 152, 191, 223),
//               iconColor: kPrimaryColor,
//               prefixIconColor: Color.fromARGB(255, 0, 41, 74),
//               contentPadding: EdgeInsets.symmetric(
//                   horizontal: defaultPadding, vertical: defaultPadding),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(30)),
//                 borderSide: BorderSide.none,
//               ),
//             )),
//         //Navigation based on users Token Data, If its expired it will be on Welcome Screen and it not expire it will be on Homepage
//         home: const WelcomeScreen());
//   }
// }



//   // home: (JwtDecoder.isExpired(token) == false)
//   //           ? BottomNav(token: token)
//   //           : const WelcomeScreen());
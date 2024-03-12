import 'package:flutter/material.dart';
import 'package:client/Screens/Welcome/welcome_screen.dart';
import 'package:client/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

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
    requestPermission(); // Request permission when the app starts

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

  Future<void> requestPermission() async {
    // Request the WRITE_EXTERNAL_STORAGE permission
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // Permission granted, perform file operations
      ('WRITE_EXTERNAL_STORAGE permission granted');
    } else {
      // Permission denied, handle it accordingly
      ('WRITE_EXTERNAL_STORAGE permission denied');
    }
  }
}

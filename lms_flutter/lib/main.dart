import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_flutter/LoginPage.dart';
import 'package:lms_flutter/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Montserrat',
          primaryColor: Colors.white
      ),
      title: "Login to LMS",
        initialRoute: '/login',
        routes: {
          '/login' : (context) => LoginPage(),
          '/home' : (context) => HomeScreen()
        }
    );
  }
}

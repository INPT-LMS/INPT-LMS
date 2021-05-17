import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_flutter/screens/CoursePage.dart';
import 'package:lms_flutter/screens/LoginPage.dart';
import 'package:lms_flutter/screens/ProfilePage.dart';
import 'package:lms_flutter/screens/SignUpPage.dart';
import 'package:lms_flutter/screens/discussion_screen.dart';
import 'package:lms_flutter/screens/home_screen.dart';
import 'package:lms_flutter/screens/messagerie_screen.dart';
import 'package:lms_flutter/services/auth_service.dart';
import 'package:lms_flutter/services/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await getIt.allReady();
  var authService = getIt.get<AuthService>();
  runApp(MyApp(authService.isLoggedIn() ? "/home" : "/login"));
}

class MyApp extends StatelessWidget {
  String initRoute;
  MyApp(this.initRoute);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Montserrat'),
        title: "Login to LMS",
        initialRoute: initRoute,
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/home': (context) => HomeScreen(),
          '/course': (context) => CoursePage(),
          '/profile' : (context) => Profile(),
          '/messages': (context) => MessagerieScreen(),
          '/discussion': (context) => DiscussionScreen()
        });
  }
}

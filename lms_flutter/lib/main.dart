import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lms_flutter/mock_components/mock_home_screen.dart';
import 'package:lms_flutter/screens/LoginPage.dart';
import 'package:lms_flutter/screens/ProfilePage.dart';
import 'package:lms_flutter/screens/SignUpPage.dart';
import 'package:lms_flutter/screens/devoir_details_screen.dart';
import 'package:lms_flutter/screens/discussion_screen.dart';
import 'package:lms_flutter/screens/liste_devoirs_cours_screen.dart';
import 'package:lms_flutter/screens/liste_discussion_screen.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:lms_flutter/services/auth_service.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:provider/provider.dart';

import 'mock_components/CoursePageStatique.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await getIt.allReady();
  await initializeDateFormatting('fr_FR', null);
  var authService = getIt.get<AuthService>();
  InfosModel modele = InfosModel(
      authService.isLoggedIn() ? authService.getUserLoggedInfos() : null,
      await Connectivity().checkConnectivity());
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider.value(value: modele)],
      child: MyApp(authService.isLoggedIn() ? "/home" : "/login")));
}

class MyApp extends StatefulWidget {
  String initRoute;

  MyApp(this.initRoute, {Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InfosModel modele;
  StreamSubscription<ConnectivityResult> listener;
  @override
  void initState() {
    super.initState();
    listener = Connectivity().onConnectivityChanged.listen((connectivityState) {
      modele.setNetworkType(connectivityState);
    });
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    modele = Provider.of<InfosModel>(context, listen: false);
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Montserrat'),
        title: "Login to LMS",
        initialRoute: this.widget.initRoute,
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/home': (context) => HomeScreenStatique(),
          '/course': (context) => CoursePageStatique(),
          '/profile': (context) => Profile(),
          '/messages': (context) => ListeDiscussionScreen(),
          '/discussion': (context) => DiscussionScreen(),
          '/devoirs': (context) => ListeDevoirsCoursScreen(),
          '/devoirs-detail': (context) => DevoirDetailsScreen()
        });
  }

  @override
  MyApp get widget => super.widget;
}

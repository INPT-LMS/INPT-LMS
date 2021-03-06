import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lms_flutter/components/my_courses/addCourseElement.dart';
import 'package:lms_flutter/screens/CoursePage.dart';
import 'package:lms_flutter/screens/LoginPage.dart';
import 'package:lms_flutter/screens/MycoursesPage.dart';
import 'package:lms_flutter/screens/ProfilePage.dart';
import 'package:lms_flutter/screens/Settings.dart';
import 'package:lms_flutter/screens/SignUpPage.dart';
import 'package:lms_flutter/screens/ajout_devoir_screen.dart';
import 'package:lms_flutter/screens/devoir_details_screen.dart';
import 'package:lms_flutter/screens/discussion_screen.dart';
import 'package:lms_flutter/screens/envoyer_message_screen.dart';
import 'package:lms_flutter/screens/fichier_details_screen.dart';
import 'package:lms_flutter/screens/home_screen.dart';
import 'package:lms_flutter/screens/liste_devoirs_cours_screen.dart';
import 'package:lms_flutter/screens/liste_discussion_screen.dart';
import 'package:lms_flutter/screens/liste_reponses_devoir.dart';
import 'package:lms_flutter/screens/stockage_cours_screen.dart';
import 'package:lms_flutter/screens/stockage_sac_screen.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:lms_flutter/services/dio_client.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();

  setupServices();
  await getIt.allReady();

  var compteService = getIt.get<CompteService>();
  var isLoggedIn = compteService.isLoggedIn();
  if (isLoggedIn)
    setupDioClient(getIt.get<Dio>(), compteService.getUserToken());
  InfosModel modele = InfosModel(
      isLoggedIn ? compteService.getUserLoggedInfos() : null,
      await Connectivity().checkConnectivity());
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider.value(value: modele)],
      child: MyApp(isLoggedIn ? "/home" : "/login")));
}

class MyApp extends StatefulWidget {
  final String initRoute;

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
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [const Locale('fr', ''), const Locale('en', '')],
        initialRoute: this.widget.initRoute,
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/home': (context) => HomeScreen(),
          '/course': (context) => CoursePage(),
          '/mycourses': (context) => Mycourses(),
          '/addCourse': (context) => AddCourse(),
          '/profile': (context) => Profile(),
          '/settings': (context) => SettingsComp(),
          '/messages': (context) => ListeDiscussionScreen(),
          '/envoyer-message': (context) => EnvoyerMessageScreen(),
          '/discussion': (context) => DiscussionScreen(),
          '/devoirs': (context) => ListeDevoirsCoursScreen(),
          '/ajout-devoir': (context) => AjoutDevoirScreen(),
          '/devoirs-detail': (context) => DevoirDetailsScreen(),
          '/liste-reponses-devoir': (context) => ListeReponsesDevoirScreen(),
          '/stockage-sac': (context) => StockageSacScreen(),
          '/stockage-cours': (context) => StockageCoursScreen(),
          '/fichier-details': (context) => FichierDetailsScreen()
        });
  }

  @override
  MyApp get widget => super.widget;
}

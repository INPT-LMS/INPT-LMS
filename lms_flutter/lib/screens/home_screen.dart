import 'package:flutter/material.dart';
import 'package:lms_flutter/screens/liste_data.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/services/data_list/post_list_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAppBar(
        body: ListeData(service: PostListService(), numberPerPage: 5));
  }
}

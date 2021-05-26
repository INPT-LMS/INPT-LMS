import 'package:flutter/material.dart';
import 'package:lms_flutter/mock_components/mock_post.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';

class HomeScreenStatique extends StatefulWidget {
  const HomeScreenStatique({Key key}) : super(key: key);

  @override
  _HomeScreenStateStatique createState() => _HomeScreenStateStatique();
}

class _HomeScreenStateStatique extends State<HomeScreenStatique> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAppBar(
        body: ListView.builder(
            itemBuilder: (context, index) => PostStatique(), itemCount: 5));
  }
}

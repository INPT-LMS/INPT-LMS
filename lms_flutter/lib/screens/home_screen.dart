import 'package:flutter/material.dart';
import 'package:lms_flutter/components/posts/post.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAppBar(
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Post();
          },
          itemCount: 5,
        )
    );
  }
}

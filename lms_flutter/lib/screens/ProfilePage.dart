import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/components/profile/CoverPic.dart';
import 'package:lms_flutter/components/profile/ProfileCourseSection.dart';
import 'package:lms_flutter/components/profile/ProfilePic.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAppBar(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Stack(
          children: <Widget>[
            // The containers in the background
            new Column(
              children: <Widget>[
                new CoverPic(),
              ],
            ),
            new Container(
              alignment: Alignment.topCenter,
              padding: new EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .15,
              ),
              child: new Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [ProfilePic(5)],
                ),
              ),
            ),
            Text("My name")
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            "Flan Fertellan",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        CourseSection(),
      ],
    )));
  }
}

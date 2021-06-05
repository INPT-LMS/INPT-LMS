import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lms_flutter/components/course_elements/AddPost.dart';
import 'package:lms_flutter/components/course_elements/course_settings.dart';
import 'package:lms_flutter/mock_components/mock_post.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';

class CoursePageStatique extends StatefulWidget {
  final String argument;
  const CoursePageStatique({Key key, this.argument}) : super(key: key);

  @override
  _CoursePageStatiqueState createState() => _CoursePageStatiqueState();
}

class _CoursePageStatiqueState extends State<CoursePageStatique> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAppBar(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/pic.jpg'),
                        colorFilter: ColorFilter.mode(
                            Color.fromRGBO(0, 0, 0, 0.5), BlendMode.darken),
                        fit: BoxFit.cover),
                  ),
                  child: Column(children: [
                    Align(child: SettingsWidget()),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Well this is the title",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    )
                  ]),
                ),
                Container(
                  padding: EdgeInsets.all(24),
                  child: AddPost("fakeIdCours"),
                ),
                Column(
                    children: List<PostStatique>.generate(
                        3, (index) => PostStatique()))
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

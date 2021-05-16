import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lms_flutter/components/course_elements/AddPost.dart';
import 'package:lms_flutter/components/course_elements/course_settings.dart';
import 'package:lms_flutter/components/posts/post.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';

class CoursePage extends StatefulWidget {
  final String argument;
  const CoursePage({Key key, this.argument}) : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
   var posts = ["Post 1 ", "Post 2 ", "Post 3"];
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
                          colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, 0.5), BlendMode.darken),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      children: [Align(

                        child:SettingsWidget()
                        ),
                      Align(
                        alignment: Alignment.center,
                        child: Text("Well this is the title",
                          textAlign: TextAlign.center,
                          style: TextStyle(

                            color: Colors.white,
                            fontSize: 24,

                          ),
                      ),
                      )]
                    ),
                    ),
                Container(
                  padding: EdgeInsets.all(24),
                  child: AddPost(),
                )
                ,

                  Column(
                    children: <Widget> [for(var post in posts) Post()],
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

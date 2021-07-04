import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/components/my_courses/courseBanner.dart';
import 'package:lms_flutter/model/course/course_data.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/services/course_service.dart';
import 'package:lms_flutter/services/service_locator.dart';

class Mycourses extends StatefulWidget {
  const Mycourses({Key key}) : super(key: key);

  @override
  _MycoursesState createState() => _MycoursesState();
}

class _MycoursesState extends State<Mycourses> {
  CourseService courseService;
  List<CourseData> coursesList  = new List.empty(growable: true);
  @override
  void initState() {
    courseService = getIt.get<CourseService>();
    setupCoursesList();
    super.initState();
  }
  void setupCoursesList() async{
    courseService.getCourses().then((list){
      setState(() {
        coursesList = list;
      });
    });
}
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAppBar(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(24),
            child: Text(
              "My courses",
              style: TextStyle(
                fontSize: 32,
                color: Color(0xff0275B1),
              ),
            ),
          ),
        for(int i = 0 ; i < coursesList.length ; i ++)   CourseBanner(coursesList[i]),
          Container(
            width: 140,
            height: 32,
            margin: EdgeInsets.only(top: 24),
            child: ElevatedButton(
              child: Text("Add course"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24))),
                primary: Color(0xff0275B1), // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/addCourse");
              },
            ),
          ),
        ],
      ),
    );
  }
}

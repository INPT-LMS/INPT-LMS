import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/components/my_courses/courseBanner.dart';
import 'package:lms_flutter/components/my_courses/searchCourses.dart';
import 'package:lms_flutter/model/course/course_data.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:lms_flutter/services/course_service.dart';
import 'package:lms_flutter/services/service_locator.dart';

class Mycourses extends StatefulWidget {
  const Mycourses({Key key}) : super(key: key);

  @override
  _MycoursesState createState() => _MycoursesState();
}

class _MycoursesState extends State<Mycourses> {
  CourseService courseService;
  CompteService compteService;
  bool isProfessor = false ;
  List<CourseData> coursesList  = [] ;
  @override
  void initState() {
    courseService = getIt.get<CourseService>();
    compteService = getIt.get<CompteService>();
    isProfessor = compteService.getUserLoggedInfos().estProfesseur ;
    coursesList = [] ;
    setupCoursesList();
    super.initState();
  }
  void setupCoursesList() async{
    courseService.getCourses().then((list){
      setState(() {
        if(list != null){
          coursesList = list;
        }

      });
    });
}
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAppBar(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
              ],
            ),
          for(int i = 0 ; i < coursesList.length ; i ++)   CourseBanner(coursesList[i]),
            if(isProfessor) Container(
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
            Divider(),
            SearchCourses(),
          ],
        ),
      ),
    );
  }
}

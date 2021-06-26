import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/components/course/courseBanner.dart';
import 'package:lms_flutter/components/profile/ProfileCourseSection.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';

class Mycourses extends StatelessWidget {
  const Mycourses({Key key}) : super(key: key);

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
          CourseBanner("bjj"),
          CourseBanner("bjj"),
          CourseBanner("bjj"),
          CourseBanner("bjj"),
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
              onPressed: () {  },
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:lms_flutter/components/my_courses/coursePicture.dart';
import 'package:lms_flutter/model/course/course_data.dart';

import 'coursePicture.dart';

class CourseBanner extends StatelessWidget {
  final CourseData _courseData;
  const CourseBanner(this._courseData, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [CoursePicture(this._courseData.courseID)],
            ),
          ),
          GestureDetector(
            onTap: (){
              if (ModalRoute.of(context).settings.name !=
                  "/course") {
                Navigator.pushNamed(context, "/course",
                    arguments: _courseData.courseID);
              }
            },
            child: Expanded(
              flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_courseData.courseName,
                    style: TextStyle(
                      fontSize: 24
                    ),),
                    Text(_courseData.courseDescription,

                      style:TextStyle(
                        fontSize: 12
                      ) ,)
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:lms_flutter/components/my_courses/coursePicture.dart';

import 'coursePicture.dart';

class CourseBanner extends StatelessWidget {
  final String courseID;
  const CourseBanner(this.courseID, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [CoursePicture(this.courseID)],
            ),
          ),
          Expanded(
            flex: 3,
              child: Column(
                children: [
                  Text("Course Name"),
                  Text("Course Description")
                ],
              )
          )
        ],
      ),
    );
  }
}

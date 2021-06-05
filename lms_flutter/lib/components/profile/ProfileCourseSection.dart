import 'package:flutter/cupertino.dart';

class CourseSection extends StatefulWidget {
  const CourseSection({Key key}) : super(key: key);

  @override
  _CourseSectionState createState() => _CourseSectionState();
}

class _CourseSectionState extends State<CourseSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 14, top: 36),
      padding: EdgeInsets.only(left: 24),
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Color(0xff0275B1), width: 2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Courses",
            style: TextStyle(
              fontSize: 24,
              color: Color(0xff0275B1),
            ),
          ),
          for (var i = 0; i < 5; i++)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/course', (Route<dynamic> route) => false);
                },
                child: Text(
                  "Course $i",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

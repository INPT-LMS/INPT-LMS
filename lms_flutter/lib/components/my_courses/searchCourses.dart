import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/components/my_courses/courseBanner.dart';
import 'package:lms_flutter/model/course/course_data.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/services/course_service.dart';
import 'package:lms_flutter/services/service_locator.dart';

class SearchCourses extends StatefulWidget {
  const SearchCourses({Key key}) : super(key: key);

  @override
  _SearchCoursesState createState() => _SearchCoursesState();
}

class _SearchCoursesState extends State<SearchCourses> {
  CourseService courseService ;
  TextEditingController searchController ;
  Future <List<CourseData>> coursesList ;
  @override
  void initState() {
    searchController = new TextEditingController();
    courseService = getIt.get<CourseService>();
    super.initState();
  }
  void updateSearchList(String courseName){
      setState(() {
        coursesList = courseService.searchCourses(courseName);
      });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 36
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Discover new courses",
            style: TextStyle(
              fontSize: 24,
              color: Color(0xff0275B1),
            ),

          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12
            ),
            child: TextFormField(
              onChanged: (_){
                //showSnackbar(context, searchController.text);
                updateSearchList(searchController.text);
              },
                controller: searchController,
                decoration: InputDecoration(
                    hintText: "Cherchez un nouveau cours",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                    ))),
          ),
          FutureBuilder(future : coursesList,
              builder: ( context , snapshot){
                List<CourseData> courses = snapshot.hasData ? snapshot.data : <CourseData>[];
            return Column(
              children:
               courses.map((e) => new CourseBanner(e)).toList()

            );
          })

        ],
      ),
    );
  }
}

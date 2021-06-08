import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lms_flutter/components/course_elements/AddPost.dart';
import 'package:lms_flutter/components/course_elements/course_settings.dart';
import 'package:lms_flutter/components/posts/post.dart';
import 'package:lms_flutter/model/course/course_data.dart';
import 'package:lms_flutter/model/post/post_data.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/screens/view_models/liste_data_model.dart';
import 'package:lms_flutter/services/course_service.dart';
import 'package:lms_flutter/services/data_list/post_cours_list_service.dart';
import 'package:lms_flutter/services/post_service.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:provider/provider.dart';

import 'liste/liste_data.dart';

class CoursePage extends StatefulWidget {
  final String argument;
  const CoursePage({Key key, this.argument}) : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  CourseService courseService;
  PostService postService;
  Future<CourseData> courseData;
  @override
  void initState() {
    super.initState();
    postService = getIt.get<PostService>();
    courseService = getIt.get<CourseService>();
  }

  @override
  Widget build(BuildContext context) {
    var idCours = ModalRoute.of(context).settings.arguments as String;
    if (courseData == null)
      courseData = courseService.getCours(idCours).catchError((e) {
        showDefaultErrorMessage(context, e);
      });
    return BaseScaffoldAppBar(
        body: FutureBuilder<CourseData>(
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/pic.jpg'),
                              colorFilter: ColorFilter.mode(
                                  Color.fromRGBO(0, 0, 0, 0.5),
                                  BlendMode.darken),
                              fit: BoxFit.cover),
                        ),
                        child: Column(children: [
                          Align(child: SettingsWidget()),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              snapshot.hasData ? snapshot.data.courseName : "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          )
                        ]),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => ListDataModel<PostData>(
                            <PostData>[],
                            <Widget>[],
                            (postData) => Post(postData)),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(24),
                              child: AddPost(idCours),
                            ),
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (snapshot.hasData)
                                      Navigator.pushNamed(context, "/devoirs",
                                          arguments: snapshot.data);
                                  },
                                  child: Text("Voir les devoirs du cours")),
                            ),
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Voir les fichiers du cours")),
                            ),
                            ListeData<PostData>(
                                PostListCoursService(postService, idCours),
                                false,
                                shrinkWrap: true),
                          ],
                        ),
                      )
                    ]),
              );
            },
            future: courseData));
  }
}

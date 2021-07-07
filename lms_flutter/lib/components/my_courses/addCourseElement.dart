import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/model/add_course_form.dart';
import 'package:lms_flutter/model/course/course_data.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/services/course_service.dart';
import 'package:lms_flutter/services/service_locator.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({Key key}) : super(key: key);
  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  AddCourseForm courseData;
  CourseService courseService ;
  @override
  void initState() {
    _nameController = new TextEditingController();
    _descriptionController = new TextEditingController();
    courseService = getIt.get<CourseService>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAppBar(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                  "Add new course",
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xff0275B1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 24
              ),
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: _nameController,
                cursorColor: Theme.of(context).cursorColor,
                decoration: InputDecoration(
                  filled: true,
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24),
                          bottomLeft: Radius.circular(24))),
                  labelText: 'Nom du cours',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(47, 80, 97, 1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 24
              ),
              child: TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.name,
                maxLines: 4,
                cursorColor: Theme.of(context).cursorColor,
                decoration: InputDecoration(
                  filled: true,
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24),
                          bottomLeft: Radius.circular(24))),
                  labelText: 'Descriptiom du cours',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(47, 80, 97, 1),
                  ),
                ),
              ),
            ),
            Container(
              width: 148,
              height: 52,
              margin: EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: (){
                  if(_nameController.text == ""){
                    showSnackbar(context, "Please provide a name for the course");
                  }
                  else{
                    courseData = new AddCourseForm(_nameController.text,
                        _descriptionController.text, null);
                    courseService.addCourse(courseData).then((value) {
                      showSnackbar(context, value.courseName + "est cree");
                    });
                  }

                },
                child: Text("Ajouter le cours"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24),
                          bottomLeft: Radius.circular(24))),
                  primary: Color(0xff0275B1), // background
                  onPrimary: Colors.white, // foreground
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

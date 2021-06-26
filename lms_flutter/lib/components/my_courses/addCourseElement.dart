import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({Key key}) : super(key: key);

  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAppBar(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Add new course"),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 24
              ),
              child: TextFormField(
                keyboardType: TextInputType.name,
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
                onPressed: (){},
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

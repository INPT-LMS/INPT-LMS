import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/components/course_elements/AboutSection.dart';

class CourseExtras extends StatefulWidget {
  const CourseExtras({Key key}) : super(key: key);

  @override
  _CourseExtrasState createState() => _CourseExtrasState();
}

class _CourseExtrasState extends State<CourseExtras> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.body1,
              children: [
                WidgetSpan(
                  child: Container(
                    child: Icon(Icons.list,color: Colors.black,),
                  ),
                ),
                TextSpan(
                  text: "Devoirs",
                  style:TextStyle(
                    fontSize: 18
                ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: (){
              showDialog(context: context, builder:(BuildContext buildContext){
                return AboutSection();
              } );
            },
            child: RichText(
              text: TextSpan(

                style: Theme.of(context).textTheme.body1,
                children: [
                  WidgetSpan(
                    child: Container(
                      child: Icon(Icons.info_outline,color: Colors.black,),
                    ),
                  ),
                  TextSpan(
                      text : "About",
                      style: TextStyle(
                          fontSize: 18
                      ))
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}

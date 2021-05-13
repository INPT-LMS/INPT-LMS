import 'package:flutter/material.dart';
import 'package:lms_flutter/components/consts/custom_colors.dart';

class Comment extends StatelessWidget {
  const Comment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.LIGHT_BLUE_2,
      padding: EdgeInsets.all(5),
      child: Column(children: [
        Row(children: [
          CircleAvatar(backgroundImage: AssetImage("images/pic.jpg")),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Oscar Mingueza",style: TextStyle(fontSize: 15)),
          )
        ]),
        Container(
          padding: EdgeInsets.all(10),
          child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
              "Curabitur consequat lacus ut magna lobortis, in convallis neque aliquet."
              " In id placerat sapien. Nunc accumsan velit congue ante sodales, "),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end,children: [
          IconButton(icon: Icon(Icons.favorite,color: Colors.red), onPressed: (){}),
          Text("5")
        ],)
      ]),
    );
  }
}

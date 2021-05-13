import 'package:flutter/material.dart';
import 'package:lms_flutter/components/consts/custom_colors.dart';

import 'comment.dart';

class Post extends StatelessWidget {
  const Post({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.LIGHT_BLACK),
          borderRadius: BorderRadius.all(
              Radius.circular(5.0)
          )
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(children: [
            CircleAvatar(backgroundImage: AssetImage("images/pic.jpg")),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Oscar Mingueza",style: TextStyle(fontSize: 15)),
                      Text("from: Flutter course community",
                      style: TextStyle(fontSize: 15,color: Colors.red))
                    ]
                )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("14 juin 2021",style: TextStyle(fontSize: 12),))
          ]),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
              "Curabitur consequat lacus ut magna lobortis, in convallis neque aliquet."
              " In id placerat sapien. Nunc accumsan velit congue ante sodales, "
              "vitae accumsan ligula faucibus. Nulla ligula felis, placerat ut turpis et, "
              "rhoncus imperdiet ex. Curabitur fermentum magna vel lacinia accumsan. "
              "Nullam pharetra magna in leo dignissim, eu condimentum libero venenatis. "
              "Vestibulum cursus risus nibh, ac convallis neque malesuada quis. "
              "Etiam consectetur risus elementum viverra lobortis. Etiam ut ipsum sed lacus consequat finibus. "
              "Curabitur consequat dolor laoreet eros porta sollicitudin. Nam rutrum est eget rutrum pretium."),
        ),
        Row(children: [
          IconButton(icon: Icon(Icons.favorite,color: Colors.red), onPressed: (){}),
          Container(margin: EdgeInsets.only(left: 5),child: Text("15")),
          IconButton(icon: Icon(Icons.comment,color: Colors.blue), onPressed: (){}),
          Container(margin: EdgeInsets.only(left: 5),child: Text("2"))
        ]),
        Comment()
      ]),
    );
  }
}

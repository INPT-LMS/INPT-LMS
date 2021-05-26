import 'package:flutter/material.dart';
import 'package:lms_flutter/components/consts/custom_colors.dart';

class PostStatique extends StatelessWidget {
  PostStatique({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.LIGHT_BLACK),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(children: [
            GestureDetector(
                child:
                    CircleAvatar(backgroundImage: AssetImage("images/pic.jpg")),
                onTap: () {
                  Navigator.pushNamed(context, "/profile");
                }),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Utilisateur test",
                            style: TextStyle(fontSize: 15)),
                        GestureDetector(
                            onTap: () {
                              if (ModalRoute.of(context).settings.name !=
                                  "/course") {
                                Navigator.pushNamed(context, "/course");
                              }
                            },
                            child: Text("Course test",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.red)))
                      ])),
            ),
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "5/5/2021 16:45",
                  style: TextStyle(fontSize: 12),
                ))
          ]),
        ),
        Container(
            margin: EdgeInsets.all(10),
            child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                "Mauris et aliquam turpis. Maecenas sed vehicula ligula, eget congue neque."
                " In fermentum at mi eu porttitor. Nullam hendrerit erat et tempor laoreet."
                " Morbi quis ornare justo. Aenean arcu velit, pharetra sed nibh ut, varius"
                " vehicula dolor. In consectetur lacus lacus, ac ultrices ipsum rutrum vel. ")),
        TextButton(
            child: Text("Supprimer", style: TextStyle(color: Colors.red)),
            onPressed: () {}),
        Row(children: [
          Icon(Icons.favorite, color: Colors.red),
          Container(margin: EdgeInsets.only(left: 5), child: Text("13")),
          Icon(Icons.comment, color: Colors.blue)
        ]),
        Container(
          decoration: BoxDecoration(
              color: CustomColors.LIGHT_BLUE_2,
              border: Border.all(color: Colors.black, width: 0.5)),
          padding: EdgeInsets.all(5),
          child: Column(children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Bob", style: TextStyle(fontSize: 15)),
              )
            ]),
            Container(
              padding: EdgeInsets.all(10),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Lorem ipsum ipsum")),
            )
          ]),
        )
      ]),
    );
  }
}

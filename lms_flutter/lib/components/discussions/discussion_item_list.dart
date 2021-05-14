import 'package:flutter/material.dart';

class DiscussionItemList extends StatelessWidget {
  const DiscussionItemList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage("images/pic.jpg")),
      title: Text("Darlene Black"),
      subtitle: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit"),
      onTap: (){Navigator.pushNamed(context, "/discussion");},
    );
  }
}

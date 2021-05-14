import 'package:flutter/material.dart';
import 'package:lms_flutter/components/discussions/discussion_item_list.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';

class MessagerieScreen extends StatefulWidget {
  const MessagerieScreen({Key key}) : super(key: key);

  @override
  _MessagerieScreenState createState() => _MessagerieScreenState();
}

class _MessagerieScreenState extends State<MessagerieScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAppBar(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Center(child: Text("Messagerie")),
            Container(
              margin: EdgeInsets.only(top: 20,bottom: 20),
              child: Row(children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(backgroundImage: AssetImage("images/pic.jpg")),
                ),
                Expanded(
                  child: TextFormField(decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(icon: Icon(Icons.search),onPressed: (){}),
                      labelText: "Chercher quelqu'un")),
                )
              ])),
            Expanded(
              child: ListView.separated(
                shrinkWrap: false,
                itemBuilder: (context,index) => DiscussionItemList(),
                itemCount: 20,
                separatorBuilder: (context, index) => Divider(color: Colors.black)
              ),
            )
          ]
        ),
      ),
    );
  }
}

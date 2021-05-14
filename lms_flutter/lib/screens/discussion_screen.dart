import 'package:flutter/material.dart';
import 'package:lms_flutter/components/consts/custom_colors.dart';
import 'package:lms_flutter/components/consts/message_position.dart';
import 'package:lms_flutter/components/discussions/message.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';

class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({Key key}) : super(key: key);

  @override
  _DiscussionScreenState createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldAppBar(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                  itemBuilder: (context,index){
                    return Message(index % 2 == 0 ?
                    MessagePosition.emetteur : MessagePosition.destinataire);
                    },
                  itemCount: 20),
            ),
            TextFormField(decoration: InputDecoration(
                hintText: "Ecrire un message",
                border: OutlineInputBorder(),
            suffixIcon: IconButton(icon: Icon(Icons.send),onPressed: (){}))
            )
          ],
        )
      ),
    );
  }
}

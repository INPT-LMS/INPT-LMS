import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: Offset(
              0,
              2
            )
          )
        ]
      ),
      child: Column(

        children: [
          Container(
            padding: EdgeInsets.only(
              bottom: 24
            ),
            child: Text(
              "Add new post"
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "What's up ?",
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  // Respond to button press
                },
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.body1,
                    children: [
                      WidgetSpan(
                        child: Container(
                          child: Icon(Icons.attach_file,color: Colors.black,),
                        ),
                      ),
                      TextSpan(text: 'Join file'),
                    ],
                  ),
                ),
              ),
              VerticalDivider(),

              TextButton(
                onPressed: () {
                  // Respond to button press
                },
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.body1,
                    children: [
                      WidgetSpan(
                        child: Container(
                          child: Icon(Icons.photo,color: Colors.black,),
                        ),
                      ),
                      TextSpan(text: 'Join photo'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 48
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                ElevatedButton(
                  
                  onPressed: () {
                    // Respond to button press
                  },
                  child: Text('Post'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)
                      ),
                      primary: Color(0xff0275B1), // background
                      onPrimary: Colors.white, // foreground
                    ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

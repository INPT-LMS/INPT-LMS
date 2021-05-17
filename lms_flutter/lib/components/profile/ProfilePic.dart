import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: Colors.white,
              width: 3
          )
      ),
      child: CircleAvatar(
        radius: 60,
        backgroundImage: AssetImage("images/pic.jpg"),
      ),
    );
  }
}

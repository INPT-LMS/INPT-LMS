import 'package:flutter/cupertino.dart';

class CoverPic extends StatelessWidget {
  const CoverPic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .25,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("images/cover.jpg")
          )
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../consts/custom_colors.dart';

class WhiteTextButton extends StatelessWidget {
  var texte;
  var onPressed;
  WhiteTextButton(String this.texte,Function this.onPressed, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed,
        child: Text(texte),
        style: ButtonStyle(shape:  MaterialStateProperty.all(
            RoundedRectangleBorder(
                side: BorderSide(color: CustomColors.DARK_BLUE),
                borderRadius: BorderRadius.circular(30.0))),
            foregroundColor: MaterialStateProperty.all(CustomColors.DARK_BLUE ),
            backgroundColor: MaterialStateProperty.all(Colors.white)));
  }
}

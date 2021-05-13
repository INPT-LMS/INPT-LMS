import 'package:flutter/material.dart';

import '../consts/custom_colors.dart';

class BlueTextButton extends StatelessWidget {
  var texte;
  var onPressed;
  BlueTextButton(String this.texte,Function this.onPressed, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed,
        child: Text(texte),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(CustomColors.DARK_BLUE)));
  }
}

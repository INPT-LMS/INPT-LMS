import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/components/consts/custom_colors.dart';
class MailField extends StatelessWidget {
  var controller;
  MailField(TextEditingController this.controller,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.LIGHT_BLUE_1,
      margin: EdgeInsets.all(20),
      child: TextFormField(keyboardType: TextInputType.emailAddress,
          controller: controller,
          validator: (value) => !EmailValidator.validate(value) ? "Mail incorrect" : null,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Entrez votre email'),
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lms_flutter/components/consts/custom_colors.dart';
class NameField extends StatelessWidget {
  var controller;
  NameField(TextEditingController this.controller,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: CustomColors.LIGHT_BLUE_1,
        margin: EdgeInsets.all(20),
        child: TextFormField(keyboardType: TextInputType.name,
          controller: controller,
          validator: (value) => (value == null || value.length < 3)
              ? "Nom trop court" : null,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Entrez votre nom complet'),
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lms_flutter/components/buttons/white_button.dart';
import 'package:lms_flutter/components/form_fields/confirm_password_field.dart';
import 'package:lms_flutter/components/form_fields/mail_field.dart';
import 'package:lms_flutter/components/form_fields/name_field.dart';
import 'package:lms_flutter/components/form_fields/password_field.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController mailController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;
  TextEditingController nameController;
  @override
  void initState() {
    mailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpFormKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: Text("INPT-LMS")),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Center(child: Text("Bienvenue",style: TextStyle(fontSize: 40))),
          Form(key: signUpFormKey,
              child: Column( children: [
                NameField(nameController),
                MailField(mailController),
                PasswordField(passwordController),
                ConfirmPasswordField(confirmPasswordController, passwordController)
              ])),
          Container(
            margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 20),
            height: 60,
            child: WhiteTextButton("S'inscrire",() => {
              if (signUpFormKey.currentState != null && signUpFormKey.currentState.validate()){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Sign up")))
              }})
          )
        ]),
      ),
      backgroundColor: Colors.white,
    );
  }
}

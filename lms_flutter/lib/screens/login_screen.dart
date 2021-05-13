import 'package:flutter/material.dart';
import 'package:lms_flutter/components/buttons/blue_button.dart';
import 'package:lms_flutter/components/buttons/white_button.dart';
import 'package:lms_flutter/components/form_fields/mail_field.dart';
import 'package:lms_flutter/components/form_fields/password_field.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mailController;
  TextEditingController passwordController;
  @override
  void initState() {
    mailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInFormKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(title: Text("INPT-LMS")),
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Center(child: Text("Bienvenue",style: TextStyle(fontSize: 40))),
            Form(key: signInFormKey,child: Column(children: [
              MailField(mailController),
              PasswordField(passwordController),
            ])),
            Container(
              margin: EdgeInsets.all(20),
              height: 60,
              child: BlueTextButton("Connexion",() => {
                if (signInFormKey.currentState != null &&
                    signInFormKey.currentState.validate()){
                  Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false)
                }})
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Center(child: Text("Pas encore de compte ? Créez en un",style: TextStyle(fontSize: 20))),
            ),
            Container(
              margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 20),
              height: 60,
              child: WhiteTextButton("S'inscrire",() => {Navigator.pushNamed(context, '/signup')}),
            )
          ]),
        ),
      backgroundColor: Colors.white,
    );
  }
}

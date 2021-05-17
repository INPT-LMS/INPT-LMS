import 'package:flutter/material.dart';
import 'package:lms_flutter/services/exceptions/authentication_exception.dart';
import 'package:lms_flutter/services/exceptions/not_found_exception.dart';
import 'package:lms_flutter/services/service_locator.dart';

import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mailController;
  TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    mailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 50, 24, 24),
          child: Column(
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                    fontSize: 48,
                    color: Color.fromRGBO(47, 80, 97, 1),
                    fontFamily: "Montserrat"),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 51, 0, 0),
                child: TextFormField(
                  controller: mailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Theme.of(context).cursorColor,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(242, 248, 255, 1),
                    filled: true,
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24),
                            bottomLeft: Radius.circular(24))),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(47, 80, 97, 1),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 51, 0, 0),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  cursorColor: Theme.of(context).cursorColor,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(242, 248, 255, 1),
                    filled: true,
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24),
                            bottomLeft: Radius.circular(24))),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(47, 80, 97, 1),
                    ),
                  ),
                ),
              ),
              Container(
                width: 343,
                height: 67,
                margin: EdgeInsets.only(top: 51),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24),
                            bottomLeft: Radius.circular(24))),
                    primary: Color(0xff0275B1), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    getIt
                        .get<AuthService>()
                        .login(mailController.text, passwordController.text)
                        .then((response) {
                      switch (response.statusCode) {
                        case 200:
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/home', (Route<dynamic> route) => false);
                          break;
                        default:
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Une erreur s'est produite")));
                      }
                    }, onError: (e) {
                      if (e is AuthenticationException ||
                          e is NotFoundException)
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Email ou mot de passe incorrect")));
                      else
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Une erreur s'est produite")));
                    });
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 32),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 51),
                child: Column(
                  children: [
                    Text("Not having an account yet?"),
                    Text("Create one"),
                  ],
                ),
              ),
              Container(
                width: 343,
                height: 67,
                margin: EdgeInsets.only(top: 51),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(24),
                              bottomLeft: Radius.circular(24))),
                      primary: Color(0xff0275B1),
                      side: BorderSide(
                        color: Color(0xff0275B1),
                      ) // background

                      // foreground
                      ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/signup', (Route<dynamic> route) => false);
                  },
                  child: Text(
                    'Go to SignUP',
                    style: TextStyle(color: Color(0xff0275B1), fontSize: 32),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

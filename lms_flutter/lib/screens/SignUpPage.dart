import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/model/user_register_form.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:lms_flutter/services/service_locator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nomController;
  TextEditingController prenomController;
  TextEditingController emailController;
  TextEditingController mdpController;
  TextEditingController mdpConfController;
  TextEditingController ecoleController;
  bool isProf;
  CompteService compteService;

  @override
  void initState() {
    super.initState();
    isProf = false;
    prenomController = TextEditingController();
    nomController = TextEditingController();
    mdpController = TextEditingController();
    mdpConfController = TextEditingController();
    emailController = TextEditingController();
    ecoleController = TextEditingController();
    compteService = getIt.get<CompteService>();
  }

  @override
  void dispose() {
    prenomController.dispose();
    nomController.dispose();
    mdpController.dispose();
    mdpConfController.dispose();
    emailController.dispose();
    ecoleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpFormKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 50, 24, 24),
          child: Column(
            children: [
              Text(
                "Bienvenue",
                style: TextStyle(
                    fontSize: 48,
                    color: Color.fromRGBO(47, 80, 97, 1),
                    fontFamily: "Montserrat"),
              ),
              Form(
                  key: signUpFormKey,
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 51, 0, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        cursorColor: Theme.of(context).cursorColor,
                        controller: nomController,
                        validator: (value) =>
                            (value == null || value.length < 1)
                                ? "Nom vide"
                                : null,
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(242, 248, 255, 1),
                          filled: true,
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  bottomLeft: Radius.circular(24))),
                          labelText: 'Nom',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(47, 80, 97, 1),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        cursorColor: Theme.of(context).cursorColor,
                        controller: prenomController,
                        validator: (value) =>
                            (value == null || value.length < 1)
                                ? "Prenom vide"
                                : null,
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(242, 248, 255, 1),
                          filled: true,
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  bottomLeft: Radius.circular(24))),
                          labelText: 'Prenom',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(47, 80, 97, 1),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Theme.of(context).cursorColor,
                        controller: emailController,
                        validator: (value) => !EmailValidator.validate(value)
                            ? "Mail incorrect"
                            : null,
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
                      padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                      child: TextFormField(
                        obscureText: true,
                        cursorColor: Theme.of(context).cursorColor,
                        controller: mdpController,
                        validator: (value) =>
                            (value == null || value.length < 6)
                                ? "Mot de passe trop court"
                                : null,
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(242, 248, 255, 1),
                          filled: true,
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  bottomLeft: Radius.circular(24))),
                          labelText: 'Mot de passe',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(47, 80, 97, 1),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                      child: TextFormField(
                        obscureText: true,
                        cursorColor: Theme.of(context).cursorColor,
                        controller: mdpConfController,
                        validator: (value) => (value != mdpController.text)
                            ? "Les mots de passe sont différents"
                            : null,
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(242, 248, 255, 1),
                          filled: true,
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  bottomLeft: Radius.circular(24))),
                          labelText: 'Confirmer le mot de passe',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(47, 80, 97, 1),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                      child: TextFormField(
                        cursorColor: Theme.of(context).cursorColor,
                        controller: ecoleController,
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(242, 248, 255, 1),
                          filled: true,
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  bottomLeft: Radius.circular(24))),
                          labelText: 'Votre etablissement (facultatif)',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(47, 80, 97, 1),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text("Etes vous un professeur ?"),
                        Checkbox(
                            value: isProf,
                            onChanged: (value) => setState(() {
                                  isProf = value;
                                }))
                      ],
                    )
                  ])),
              Container(
                width: 343,
                height: 67,
                margin: EdgeInsets.only(top: 24),
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
                    if (signUpFormKey.currentState != null &&
                        signUpFormKey.currentState.validate()) {
                      var ecole = ecoleController.text;
                      if (ecole != null && ecole.isEmpty) ecole = null;
                      var registerForm = UserRegisterForm(
                          emailController.text,
                          mdpController.text,
                          nomController.text,
                          prenomController.text,
                          isProf,
                          null,
                          null);
                      if (ecole != null) {
                        if (isProf)
                          registerForm.enseigneA = ecole;
                        else
                          registerForm.etudieA = ecole;
                      }
                      compteService.register(registerForm).then((value) {
                        switch (value.statusCode) {
                          case 200:
                            showSnackbar(
                                context, "Votre compte a bien été crée");
                            Navigator.pop(context);
                            break;
                          case 409:
                            showSnackbar(context,
                                "Cette adresse mail est déjà utilisée");
                            break;
                          case 401:
                            showSnackbar(
                                context, "Veuillez remplir tous les champs");
                            break;
                        }
                      }).catchError((e) {
                        showDefaultErrorMessage(context, e.response.statusCode);
                      });
                    }
                  },
                  child: Text(
                    "S'inscrire",
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 32),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 51),
                child: Text("Déjà inscrit ?"),
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
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Se connecter',
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

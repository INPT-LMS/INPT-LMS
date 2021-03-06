import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:lms_flutter/services/dio_client.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:provider/provider.dart';

import '../services/compte_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController;
  TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var infosModel = Provider.of<InfosModel>(context, listen: false);
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
              Container(
                padding: EdgeInsets.fromLTRB(0, 51, 0, 0),
                child: TextFormField(
                  controller: emailController,
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
                    labelText: 'Mot de passe',
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
                    var compteService = getIt.get<CompteService>();
                    if (infosModel.networkType == ConnectivityResult.none) {
                      showSnackbar(context, "Pas de connexion");
                      return;
                    }
                    compteService
                        .login(emailController.text, passwordController.text)
                        .then((isOk) {
                      if (isOk) {
                        Provider.of<InfosModel>(context, listen: false)
                            .userInfos = compteService.getUserLoggedInfos();
                        setupDioClient(
                            getIt.get<Dio>(), compteService.getUserToken());
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home', (Route<dynamic> route) => false);
                      } else
                        showSnackbar(
                            context, "Email ou mot de passe incorrect");
                    }).catchError((e) {
                      if (e.type == DioErrorType.connectTimeout)
                        showSnackbar(context, "Erreur : serveur indisponible");
                      else
                        showDefaultErrorMessage(context, e.response.statusCode);
                    });
                  },
                  child: Text(
                    'Se connecter',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 32),
                  ),
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
                    Navigator.pushNamed(context, "/signup");
                  },
                  child: Text(
                    "S'inscrire",
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

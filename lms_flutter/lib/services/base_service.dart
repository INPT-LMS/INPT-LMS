import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'exceptions/authentication_exception.dart';

/// Classe abstraite qui définit un service qui utilise le web <br />
/// Elle définit une méthode pour la récuperation du token
abstract class BaseService {
  Dio client;
  SharedPreferences sharedPreferences;
  BaseService(this.sharedPreferences, this.client);

  String getToken() {
    if (!sharedPreferences.containsKey("userToken"))
      throw new AuthenticationException();
    else
      return sharedPreferences.getString("userToken");
  }
}

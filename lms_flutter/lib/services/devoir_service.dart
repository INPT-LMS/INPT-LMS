import 'dart:convert';

import 'package:http/src/client.dart';
import 'package:lms_flutter/model/consts.dart';
import 'package:lms_flutter/model/devoir/devoir_data.dart';
import 'package:lms_flutter/model/pagination/pagination_devoir.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'exceptions/network_exception.dart';

class DevoirService extends BaseService {
  DevoirService(SharedPreferences sharedPreferences, Client client)
      : super(sharedPreferences, client);

  Future<PaginationDevoir> getDevoirsCours(String idCours) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url = Uri.parse(Consts.URL_GATEWAY + "/assignment/devoirs/$idCours");
    return client
        .get(url, headers: headers)
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) {
      var listeDevoirs = jsonDecode(handleException(response)) as List;
      List<DevoirData> content = listeDevoirs
          .map<DevoirData>((item) => DevoirData.fromJson(item))
          .toList();
      return PaginationDevoir(true, content);
    });
  }

  Future<DevoirData> getDevoir(String idCours, String idDevoir) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url = Uri.parse(
        Consts.URL_GATEWAY + "/assignment/devoirs/$idCours/$idDevoir");
    return client
        .get(url, headers: headers)
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) =>
            DevoirData.fromJson(jsonDecode(handleException(response))));
  }
}

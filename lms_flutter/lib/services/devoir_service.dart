import 'package:dio/dio.dart';
import 'package:lms_flutter/model/devoir/devoir_data.dart';
import 'package:lms_flutter/model/pagination/pagination_devoir.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service chargé des interactions liées aux devoirs
class DevoirService extends BaseService {
  DevoirService(SharedPreferences sharedPreferences, Dio client)
      : super(sharedPreferences, client);

  Future<PaginationDevoir> getDevoirsCours(String idCours) {
    return client.get("/assignment/devoirs/$idCours").then((response) {
      var listeDevoirs = response.data as List;
      List<DevoirData> content = listeDevoirs
          .map<DevoirData>((item) => DevoirData.fromJson(item))
          .toList();
      return PaginationDevoir(true, content);
    });
  }

  Future<DevoirData> getDevoir(String idCours, String idDevoir) {
    return client
        .get("/assignment/devoirs/$idCours/$idDevoir")
        .then((response) {
      return DevoirData.fromJson(response.data);
    });
  }
}

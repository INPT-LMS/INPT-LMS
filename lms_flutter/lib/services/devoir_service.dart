import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:lms_flutter/model/devoir/devoir_data.dart';
import 'package:lms_flutter/model/devoir/devoir_reponse_data.dart';
import 'package:lms_flutter/model/pagination/pagination_devoir.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:mime/mime.dart';
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

  Future<DevoirReponseData> rendreDevoir(
      String idCours, String idDevoir, PlatformFile fichier) {
    var formData = FormData.fromMap({
      'fichier': MultipartFile(fichier.readStream, fichier.size,
          contentType: MediaType.parse(lookupMimeType(fichier.name)),
          filename: fichier.name)
    });
    return client
        .put("/assignment/devoirs/$idCours/$idDevoir/rendu", data: formData)
        .then((response) => DevoirReponseData.fromJson(response.data))
        .then((response) =>
            response.fichier.nom == null ? throw "error" : response);
  }

  Future noterDevoir(
      String idCours, String idDevoir, String idReponse, int note) {
    return client.put("/assignment/devoirs/$idCours/$idDevoir/rendu/$idReponse",
        data: <String, String>{"note": "$note"});
  }

  Future<DevoirData> creerDevoir(
      String idCours, String contenu, DateTime dateLimite) {
    return client.post("/assignment/devoirs/$idCours", data: <String, dynamic>{
      "contenu": contenu,
      "dateLimite": dateLimite.toIso8601String()
    }).then((response) {
      return DevoirData.fromJson(
          response.data == "" ? <String, dynamic>{} : response.data);
    });
  }
}

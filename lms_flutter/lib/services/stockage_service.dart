import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http_parser/http_parser.dart';
import 'package:lms_flutter/model/pagination/pagination_fichier.dart';
import 'package:lms_flutter/model/stockage/fichier.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:lms_flutter/services/exceptions/no_permission_exception.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service chargé des interactions liées au stockage
class StockageService extends BaseService {
  StockageService(SharedPreferences sharedPreferences, dio.Dio client)
      : super(sharedPreferences, client);

  String _extractPath(String path) {
    var index = path.indexOf("/Android/");
    return index == -1 ? path : path.substring(0, index) + "/Download";
  }

  Future<Fichier> uploadFichier(String url, PlatformFile fichier) {
    var formData = dio.FormData.fromMap({
      'fichier': dio.MultipartFile(fichier.readStream, fichier.size,
          contentType: MediaType.parse(lookupMimeType(fichier.name)),
          filename: fichier.name)
    });
    return client
        .post(url, data: formData)
        .then((response) => Fichier.fromJson(response.data));
  }

  Future<Fichier> associateFichier(String url) {
    return client.post(url).then((response) => Fichier.fromJson(response.data));
  }

  Future deleteFichier(String url) {
    return client.delete(url);
  }

  Future<String> downloadFichier(String fullUrl, String filename) {
    return Permission.storage
        .request()
        .then((permissionStatus) {
          if (!permissionStatus.isGranted) throw NoPermissionException();
        })
        .then((_) => getExternalStorageDirectory())
        .then((directory) => FlutterDownloader.enqueue(
            url: fullUrl,
            headers: <String, String>{
              "Authorization": client.options.headers["Authorization"],
              "Content-type": "application/json; charset=utf-8"
            },
            savedDir: _extractPath(directory.path),
            showNotification: true,
            openFileFromNotification: true,
            fileName: filename));
  }

  Future<PaginationFichier> getFichiers(String url) {
    return client
        .get(url)
        .then((response) => PaginationFichier.fromJson(response.data));
  }

  Future<Map<String, dynamic>> getUsedSpace() {
    return client.get("/storage/user/space").then((response) => response.data);
  }
}

import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:lms_flutter/model/consts.dart';
import 'package:lms_flutter/model/pagination/pagination_fichier.dart';
import 'package:lms_flutter/model/stockage/fichier.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:lms_flutter/services/exceptions/network_exception.dart';
import 'package:lms_flutter/services/exceptions/no_permission_exception.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service chargé des interactions liées au stockage
class StockageService extends BaseService {
  StockageService(SharedPreferences sharedPreferences, Client client)
      : super(sharedPreferences, client);

  String _extractPath(String path) {
    var index = path.indexOf("/Android/");
    return index == -1 ? path : path.substring(0, index) + "/Download";
  }

  Future<Fichier> uploadFichier(String url, PlatformFile fichier) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    var formData = dio.FormData.fromMap({
      'fichier': dio.MultipartFile(fichier.readStream, fichier.size,
          contentType: MediaType.parse(lookupMimeType(fichier.name)),
          filename: fichier.name)
    });
    var dioClient = dio.Dio(dio.BaseOptions(
        headers: <String, String>{"Authorization": headers["Authorization"]}));
    return dioClient
        .post(url, data: formData)
        .then((response) => Fichier.fromJson(response.data));
  }

  Future<Fichier> associateFichier(Uri url) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    return client.post(url, headers: headers).timeout(
        Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then(
        (response) => Fichier.fromJson(jsonDecode(handleException(response))));
  }

  Future deleteFichier(Uri url) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    return client
        .delete(url, headers: headers)
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) => handleException(response));
  }

  Future<String> downloadFichier(String url, String filename) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    return Permission.storage
        .request()
        .then((permissionStatus) {
          if (!permissionStatus.isGranted) throw NoPermissionException();
        })
        .then((_) => getExternalStorageDirectory())
        .then((directory) => FlutterDownloader.enqueue(
            url: url,
            headers: headers,
            savedDir: _extractPath(directory.path),
            showNotification: true,
            openFileFromNotification: true,
            fileName: filename));
  }

  Future<PaginationFichier> getFichiers(Uri url) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    return client
        .get(url, headers: headers)
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) =>
            PaginationFichier.fromJson(jsonDecode(handleException(response))));
  }

  Future<Map<String, dynamic>> getUsedSpace() {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url = Uri.parse(Consts.URL_GATEWAY + "/storage/user/space");
    return client
        .get(url, headers: headers)
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) => jsonDecode(handleException(response)));
  }
}

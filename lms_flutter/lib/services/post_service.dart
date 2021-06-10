import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lms_flutter/model/consts.dart';
import 'package:lms_flutter/model/pagination/pagination_post.dart';
import 'package:lms_flutter/model/post/commentaire_data.dart';
import 'package:lms_flutter/model/post/like_data.dart';
import 'package:lms_flutter/model/post/post_data.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'exceptions/network_exception.dart';

/// Service chargé des interactions liées aux publications
class PostService extends BaseService {
  PostService(SharedPreferences sharedPreferences, http.Client client)
      : super(sharedPreferences, client);

  Future<PaginationPost> getFeed() {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url = Uri.parse(Consts.URL_GATEWAY + "/post/publication/cours");
    return client
        .get(url, headers: headers)
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) {
      Map<String, dynamic> listePosts = jsonDecode(handleException(response));
      if (listePosts.values.every((element) => (element as List).isEmpty))
        return PaginationPost(true, <PostData>[]);
      List<PostData> content = listePosts.values
          .reduce((value, element) {
            value.addAll(element);
            return value;
          })
          .toList()
          .map<PostData>((postJson) => PostData.fromJson(postJson))
          .toList();
      content.sort((post1, post2) =>
          post1.datePublication.isAfter(post2.datePublication) ? -1 : 1);
      return PaginationPost(true, content);
    });
  }

  Future<PaginationPost> getPostsCours(String idCours) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url =
        Uri.parse(Consts.URL_GATEWAY + "/post/publication/cours/$idCours");
    return client
        .get(url, headers: headers)
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) {
      var listePosts = jsonDecode(handleException(response)) as List;
      List<PostData> content =
          listePosts.map<PostData>((item) => PostData.fromJson(item)).toList();
      return PaginationPost(true, content);
    });
  }

  Future<LikeData> addLike(String idPublication) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url = Uri.parse(Consts.URL_GATEWAY + "/post/like");
    return client
        .post(url,
            headers: headers,
            body: jsonEncode(<String, String>{"idPublication": idPublication}))
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) =>
            LikeData.fromJson(jsonDecode(handleException(response))));
  }

  Future<String> removeLike(String idLike) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url = Uri.parse(Consts.URL_GATEWAY + "/post/like/$idLike");
    return client
        .delete(url, headers: headers)
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) => handleException(response));
  }

  Future<PostData> addPost(String idCours, String contenu) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url = Uri.parse(Consts.URL_GATEWAY + "/post/publication");
    return client
        .post(url,
            headers: headers,
            body: jsonEncode(<String, String>{
              "idCours": idCours,
              "contenuPublication": contenu
            }))
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) =>
            PostData.fromJson(jsonDecode(handleException(response))));
  }

  Future<String> removePost(String idPost) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url = Uri.parse(Consts.URL_GATEWAY + "/post/publication/$idPost");
    return client
        .delete(url, headers: headers)
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) => handleException(response));
  }

  Future<CommentaireData> addCommentaire(String idPublication, String contenu) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url = Uri.parse(Consts.URL_GATEWAY + "/post/commentaire");
    return client
        .post(url,
            headers: headers,
            body: jsonEncode(<String, String>{
              "idPublication": idPublication,
              "contenuCommentaire": contenu
            }))
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) =>
            CommentaireData.fromJson(jsonDecode(handleException(response))));
  }

  Future<String> removeCommentaire(String idCommentaire) {
    try {
      loadToken();
    } catch (e) {
      return Future.error(e);
    }
    Uri url =
        Uri.parse(Consts.URL_GATEWAY + "/post/commentaire/$idCommentaire");
    return client
        .delete(url, headers: headers)
        .timeout(Duration(seconds: Consts.TIMEOUT_REQUEST), onTimeout: () {
      throw NetworkException();
    }).then((response) => handleException(response));
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lms_flutter/model/consts/base_url.dart';
import 'package:lms_flutter/model/pagination/pagination_post.dart';
import 'package:lms_flutter/model/posts/like_data.dart';
import 'package:lms_flutter/model/posts/post_data.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'exceptions/network_exception.dart';

class PostService extends BaseService {
  PostService(SharedPreferences sharedPreferences) : super(sharedPreferences);

  Future<PaginationPost> getFeed() {
    loadToken();
    Uri url = Uri.parse(BaseUrl.URL_GATEWAY + "/post/publication/cours");
    return http.get(url, headers: headers).timeout(Duration(seconds: 5),
        onTimeout: () {
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

  Future<LikeData> addLike(String idPublication) {
    loadToken();
    Uri url = Uri.parse(BaseUrl.URL_GATEWAY + "/post/like");
    return http
        .post(url,
            headers: headers, body: "{\"idPublication\": \"$idPublication\"}")
        .timeout(Duration(seconds: 5), onTimeout: () {
      throw NetworkException();
    }).then((response) =>
            LikeData.fromJson(jsonDecode(handleException(response))));
  }

  Future<String> removeLike(String idLike) {
    loadToken();
    Uri url = Uri.parse(BaseUrl.URL_GATEWAY + "/post/like/$idLike");
    return http.delete(url, headers: headers).timeout(Duration(seconds: 5),
        onTimeout: () {
      throw NetworkException();
    }).then((response) => handleException(response));
  }

  Future<String> removePost(String idPost) {
    loadToken();
    Uri url = Uri.parse(BaseUrl.URL_GATEWAY + "/post/publication/$idPost");
    return http.delete(url, headers: headers).timeout(Duration(seconds: 5),
        onTimeout: () {
      throw NetworkException();
    }).then((response) => handleException(response));
  }

  Future<String> removeCommentaire(String idCommentaire) {
    loadToken();
    Uri url =
        Uri.parse(BaseUrl.URL_GATEWAY + "/post/commentaire/$idCommentaire");
    return http.delete(url, headers: headers).timeout(Duration(seconds: 5),
        onTimeout: () {
      throw NetworkException();
    }).then((response) => handleException(response));
  }
}

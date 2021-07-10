import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lms_flutter/model/pagination/pagination_post.dart';
import 'package:lms_flutter/model/post/commentaire_data.dart';
import 'package:lms_flutter/model/post/like_data.dart';
import 'package:lms_flutter/model/post/post_data.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service chargé des interactions liées aux publications
class PostService extends BaseService {
  PostService(SharedPreferences sharedPreferences, Dio client)
      : super(sharedPreferences, client);

  Future<PaginationPost> getFeed() {
    return client.get("/post/publication/cours").then((response) {
      Map<String, dynamic> listePosts = response.data;
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
    return client.get("/post/publication/cours/$idCours").then((response) {
      var listePosts = response.data as List;
      List<PostData> content =
          listePosts.map<PostData>((item) => PostData.fromJson(item)).toList();
      return PaginationPost(true, content);
    });
  }

  Future<LikeData> addLike(String idPublication) {
    return client
        .post("/post/like",
            data: jsonEncode(<String, String>{"idPublication": idPublication}))
        .then((response) => LikeData.fromJson(response.data));
  }

  Future<String> removeLike(String idLike) {
    return client
        .delete("/post/like/$idLike")
        .then((response) => response.data.toString());
  }

  Future<PostData> addPost(String idCours, String contenu) {
    return client
        .post("/post/publication",
            data: jsonEncode(<String, String>{
              "idCours": idCours,
              "contenuPublication": contenu
            }))
        .then((response) => PostData.fromJson(response.data));
  }

  Future<String> removePost(String idPost) {
    return client
        .delete("/post/publication/$idPost")
        .then((response) => response.data.toString());
  }

  Future<CommentaireData> addCommentaire(String idPublication, String contenu) {
    return client
        .post("/post/commentaire",
            data: jsonEncode(<String, String>{
              "idPublication": idPublication,
              "contenuCommentaire": contenu
            }))
        .then((response) => CommentaireData.fromJson(response.data));
  }

  Future<String> removeCommentaire(String idCommentaire) {
    return client
        .delete("/post/commentaire/$idCommentaire")
        .then((response) => response.data.toString());
  }
}

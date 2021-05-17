import 'package:flutter/material.dart';
import 'package:lms_flutter/components/posts/post.dart';
import 'package:lms_flutter/services/data_list/data_list_service.dart';

/// Implementation de DataService chargée de recupérer des posts
class PostListService extends DataService {
  @override
  Future<DataWrapper> addData(int n, int p) {
    return Future<DataWrapper>(() async {
      await Future.delayed(Duration(seconds: 2), () {});
      return DataWrapper(true, Column(children: List<Post>.generate(3, (index) => Post())));
    });
  }
}

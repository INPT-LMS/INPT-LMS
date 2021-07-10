import 'package:lms_flutter/model/post/post_data.dart';
import 'package:lms_flutter/services/data_list/data_list_service.dart';
import 'package:lms_flutter/services/post_service.dart';

/// Implementation de DataService chargée de recupérer des posts
class PostListService extends DataService<PostData> {
  PostService postService;

  PostListService(this.postService);

  @override
  Future<DataWrapper<PostData>> addData(int n, int p) {
    return postService
        .getFeed()
        .then((pagination) => DataWrapper(pagination.last, pagination.content));
  }
}

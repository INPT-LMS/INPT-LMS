import 'package:lms_flutter/model/post/post_data.dart';
import 'package:lms_flutter/services/data_list/data_list_service.dart';
import 'package:lms_flutter/services/post_service.dart';

/// Implementation de DataService chargée de recupérer des posts d'un
/// cours spécifique
class PostListCoursService extends DataService<PostData> {
  PostService postService;
  String idCours;

  PostListCoursService(this.postService, this.idCours);

  @override
  Future<DataWrapper<PostData>> addData(int n, int p) {
    return postService
        .getPostsCours(idCours)
        .then((pagination) => DataWrapper(pagination.last, pagination.content));
  }
}

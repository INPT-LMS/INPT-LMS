import 'package:lms_flutter/model/posts/post_data.dart';
import 'package:lms_flutter/services/data_list/data_list_service.dart';

/// Implementation de DataService chargée de recupérer des posts
class PostListService extends DataService<PostData> {
  @override
  Future<DataWrapper<PostData>> addData(int n, int p) {
    return Future<DataWrapper<PostData>>(() async {
      await Future.delayed(Duration(seconds: 2), () {});
      return DataWrapper(true, List.generate(3, (index) => PostData()));
    });
  }
}

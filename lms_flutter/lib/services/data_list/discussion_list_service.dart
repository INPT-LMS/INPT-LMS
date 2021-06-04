import 'package:lms_flutter/model/discussion/discussion_data.dart';
import 'package:lms_flutter/services/data_list/data_list_service.dart';

import '../message_service.dart';

/// Implementation de DataService chargée de recupérer des discussions
class DiscussionListService extends DataService<DiscussionData> {
  MessageService service;
  int userId;
  DiscussionListService(this.service, this.userId);

  @override
  Future<DataWrapper<DiscussionData>> addData(int n, int p) {
    return service
        .getDiscussions(n, p)
        .then((value) => DataWrapper(value.last, value.content));
  }
}

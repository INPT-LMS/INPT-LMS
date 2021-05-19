import 'package:lms_flutter/model/discussions/message_data.dart';
import 'package:lms_flutter/services/data_list/data_list_service.dart';

import '../message_service.dart';

/// Implementation de DataService chargée de recupérer des messages
class MessageListService extends DataService<MessageData> {
  MessageService service;
  int userId;
  String discId;
  MessageListService(this.service, this.userId, this.discId);
  @override
  Future<DataWrapper<MessageData>> addData(int n, int p) {
    return service
        .getDiscussionMessages(discId, n, p)
        .then((value) => DataWrapper(value.last, value.content));
  }
}

import 'package:flutter/material.dart';
import 'package:lms_flutter/components/discussions/discussion.dart';
import 'package:lms_flutter/services/data_list/data_list_service.dart';

import '../message_service.dart';

/// Implementation de DataService chargée de recupérer des discussions
class DiscussionListService extends DataService {
  MessageService service;
  int userId;
  DiscussionListService(this.service, this.userId);

  @override
  Future<DataWrapper> addData(int n, int p) {
    return service.getDiscussions(n, p).then((value) => DataWrapper(
        value.last,
        Column(
            children: value.content
                .map((discData) => Discussion(discData, userId))
                .toList())));
  }
}

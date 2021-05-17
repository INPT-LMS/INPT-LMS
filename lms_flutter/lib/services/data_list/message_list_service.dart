import 'package:flutter/material.dart';
import 'package:lms_flutter/components/consts/message_position.dart';
import 'package:lms_flutter/components/discussions/message.dart';
import 'package:lms_flutter/services/data_list/data_list_service.dart';

import '../message_service.dart';

/// Implementation de DataService chargée de recupérer des messages
class MessageListService extends DataService {
  MessageService service;
  int userId;
  String discId;
  MessageListService(this.service, this.userId, this.discId);
  @override
  Future<DataWrapper> addData(int n, int p) {
    return service.getDiscussionMessages(discId, n, p).then((value) =>
        DataWrapper(
            value.last,
            Column(
                children: value.content
                    .map((messageData) => Message(messageData,
                        position: userId == messageData.idEmetteur
                            ? MessagePosition.emetteur
                            : MessagePosition.destinataire))
                    .toList()
                    .reversed
                    .toList())));
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:lms_flutter/model/discussion/discussion_data.dart';
import 'package:lms_flutter/model/discussion/message_data.dart';
import 'package:lms_flutter/services/message_service.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

void main() {
  MockSharedPreferences sharedPref;
  MockClient client;
  MessageService messageService;

  var messageBA = MessageData("fakeIdMessage", "fakeIdDiscussion", 10, 5,
      DateTime.now(), "Oui je suis la");
  var discussion = DiscussionData("fakeIdDiscussion", "Monsieur A", 5,
      "Monsieur B", 10, messageBA, messageBA.date);
  setUp(() {
    sharedPref = MockSharedPreferences();
    client = MockClient();
    messageService = MessageService(sharedPref, client);
  });

  test("Should get discussions has new messages", () async {
    when(client.get(any))
        .thenAnswer((invoc) => Future(() => MockResponse(["id1", "id2"], 200)));

    var discussionsId = await messageService.getDiscussionHasNewMessage();
    expect(discussionsId, ["id1", "id2"]);
  });

  test("Should get discussions", () async {
    var response = <String, dynamic>{
      "last": true,
      "content": [discussion.toJson(), discussion.toJson()]
    };
    when(client.get(any))
        .thenAnswer((invoc) => Future(() => MockResponse(response, 200)));

    var discussions = (await messageService.getDiscussions(10, 0)).content;
    expect(discussions.length, 2);
    expect(discussions[0].id, discussion.id);
  });
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:lms_flutter/model/discussion/discussion_data.dart';
import 'package:lms_flutter/model/discussion/message_data.dart';
import 'package:lms_flutter/services/message_service.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    when(sharedPref.containsKey("userToken")).thenReturn(true);
    when(sharedPref.getString("userToken")).thenReturn("fakeToken");

    client = MockClient();

    messageService = MessageService(sharedPref, client);
  });

  test("Should get discussions has new messages", () async {
    when(client.get(any, headers: anyNamed("headers"))).thenAnswer((invoc) =>
        Future(() => http.Response(jsonEncode(<String>["id1", "id2"]), 200,
            headers: <String, String>{"Content-Type": "application/json"})));

    var discussionsId = await messageService.getDiscussionHasNewMessage();
    expect(discussionsId, ["id1", "id2"]);
  });

  test("Should get discussions", () async {
    var response = <String, dynamic>{
      "last": true,
      "content": <DiscussionData>[discussion, discussion]
    };
    when(client.get(any, headers: anyNamed("headers"))).thenAnswer((invoc) =>
        Future(() => http.Response(jsonEncode(response), 200,
            headers: <String, String>{"Content-Type": "application/json"})));

    var discussions = (await messageService.getDiscussions(10, 0)).content;
    expect(discussions.length, 2);
    expect(discussions[0].id, discussion.id);
  });
}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockClient extends Mock implements http.Client {}

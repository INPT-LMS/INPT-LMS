import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:lms_flutter/model/post/post_data.dart';
import 'package:lms_flutter/services/post_service.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  MockSharedPreferences sharedPref;
  MockClient client;
  PostService postService;

  var post = PostData("fakeIdPost", 5, "fakeIdCours", DateTime.now(),
      "Test publication", [], []);
  setUp(() {
    sharedPref = MockSharedPreferences();
    when(sharedPref.containsKey("userToken")).thenReturn(true);
    when(sharedPref.getString("userToken")).thenReturn("fakeToken");

    client = MockClient();

    postService = PostService(sharedPref, client);
  });

  test("Should get feed", () async {
    when(client.get(any, headers: anyNamed("headers")))
        .thenAnswer((invoc) => Future(() => http.Response(
            jsonEncode(<String, dynamic>{
              post.idCours: [post, post, post],
              "autreIdCours": [post],
              "encoreUnAutre": []
            }),
            200,
            headers: <String, String>{"Content-Type": "application/json"})));

    var paginationPosts = await postService.getFeed();
    expect(paginationPosts.last, true);
    expect(paginationPosts.content.length, 4);
    expect(paginationPosts.content[0].likes, []);
  });
}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockClient extends Mock implements http.Client {}

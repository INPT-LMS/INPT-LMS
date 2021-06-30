import 'package:flutter_test/flutter_test.dart';
import 'package:lms_flutter/model/post/post_data.dart';
import 'package:lms_flutter/services/post_service.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  MockSharedPreferences sharedPref;
  MockClient client;
  PostService postService;

  var post = PostData("fakeIdPost", 5, "fakeIdCours", DateTime.now(),
      "Test publication", [], []);
  setUp(() {
    sharedPref = MockSharedPreferences();
    client = MockClient();
    postService = PostService(sharedPref, client);
  });

  test("Should get feed", () async {
    when(client.get(any))
        .thenAnswer((invoc) => Future(() => MockResponse(<String, dynamic>{
              post.idCours: <Map<String, dynamic>>[
                post.toJson(),
                post.toJson(),
                post.toJson()
              ],
              "autreIdCours": <Map<String, dynamic>>[post.toJson()],
              "encoreUnAutre": <Map<String, dynamic>>[]
            }, 200)));

    var paginationPosts = await postService.getFeed();
    expect(paginationPosts.last, true);
    expect(paginationPosts.content.length, 4);
    expect(paginationPosts.content[0].likes, []);
  });
}

import 'package:flutter/material.dart';
import 'package:lms_flutter/components/posts/post.dart';
import 'package:lms_flutter/model/posts/post_data.dart';
import 'package:lms_flutter/screens/liste/liste_data.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/services/data_list/post_list_service.dart';
import 'package:lms_flutter/services/post_service.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:provider/provider.dart';

import 'view_models/liste_data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var postService = getIt.get<PostService>();
    return BaseScaffoldAppBar(
        body: ChangeNotifierProvider(
            create: (context) => ListDataModel<PostData>(
                <PostData>[], <Widget>[], (postData) => Post(postData)),
            child: ListeData<PostData>(PostListService(postService), false)));
  }
}

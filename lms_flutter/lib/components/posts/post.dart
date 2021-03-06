import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms_flutter/components/consts/custom_colors.dart';
import 'package:lms_flutter/components/posts/like_comment.dart';
import 'package:lms_flutter/components/profile/ProfilePic.dart';
import 'package:lms_flutter/model/post/post_data.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:lms_flutter/screens/view_models/liste_data_model.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:lms_flutter/services/course_service.dart';
import 'package:lms_flutter/services/post_service.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:provider/provider.dart';

import '../../screens/utils.dart';

class Post extends StatelessWidget {
  final PostData postData;
  Post(this.postData, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var infos = Provider.of<InfosModel>(context, listen: false).userInfos;
    var compteService = getIt.get<CompteService>();
    var postService = getIt.get<PostService>();
    var coursService = getIt.get<CourseService>();
    var userLike = postData.likes.firstWhere(
        (like) => like.idProprietaire == infos.id,
        orElse: () => null);
    var isOwner = infos.id == this.postData.idProprietaire;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.LIGHT_BLACK),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(children: [
            GestureDetector(
                child: ProfilePic(postData.idProprietaire),
                onTap: () {
                  Navigator.pushNamed(context, "/profile");
                }),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                            builder: (context, snapshot) => Text(
                                snapshot.hasData ? snapshot.data : "",
                                style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        isOwner ? Colors.blue : Colors.black)),
                            future: compteService
                                .getUserInfos(postData.idProprietaire)
                                .then((infos) => infos.nom)),
                        GestureDetector(
                            onTap: () {
                              if (ModalRoute.of(context).settings.name !=
                                  "/course") {
                                Navigator.pushNamed(context, "/course",
                                    arguments: postData.idCours);
                              }
                            },
                            child: FutureBuilder(
                                builder: (context, snapshot) => Text(
                                    snapshot.hasData
                                        ? "Cours : ${snapshot.data}"
                                        : "",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)),
                                future: coursService
                                    .getCours(postData.idCours)
                                    .then(
                                        (courseData) => courseData.courseName)))
                      ])),
            ),
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  DateFormat.yMMMMd('fr_FR')
                      .add_Hm()
                      .format(postData.datePublication),
                  style: TextStyle(fontSize: 12),
                ))
          ]),
        ),
        Container(
            margin: EdgeInsets.all(10),
            child: Text(postData.contenuPublication)),
        if (isOwner)
          IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                askConfirmation(context).then((value) {
                  if (value == null || !value) return;
                  postService.removePost(postData.id).then((value) {
                    var listModele = Provider.of<ListDataModel<PostData>>(
                        context,
                        listen: false);
                    listModele.deleteWhere(postData.id);
                  }).catchError((e) {
                    showDefaultErrorMessage(context, e.response.statusCode);
                  });
                });
              }),
        LikeComment(
            postData.id, postData.likes.length, userLike, postData.commentaires)
      ]),
    );
  }
}

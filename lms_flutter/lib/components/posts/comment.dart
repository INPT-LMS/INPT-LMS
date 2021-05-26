import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lms_flutter/components/consts/custom_colors.dart';
import 'package:lms_flutter/model/posts/commentaire_data.dart';
import 'package:lms_flutter/services/auth_service.dart';
import 'package:lms_flutter/services/service_locator.dart';

class Comment extends StatelessWidget {
  CommentaireData commentaireData;
  Comment(this.commentaireData, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authService = getIt.get<AuthService>();
    return FutureBuilder(
      builder: (context, snapshot) {
        return Container(
          decoration: BoxDecoration(
              color: CustomColors.LIGHT_BLUE_2,
              border: Border.all(color: Colors.black, width: 0.5)),
          padding: EdgeInsets.all(5),
          child: Column(children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(snapshot.hasData ? snapshot.data : "",
                    style: TextStyle(fontSize: 15)),
              )
            ]),
            Container(
              padding: EdgeInsets.all(10),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(commentaireData.contenuCommentaire)),
            )
          ]),
        );
      },
      future: authService
          .getUserInfos(commentaireData.idProprietaire)
          .then((response) => jsonDecode(response.body)["user"]["nom"]),
    );
  }
}

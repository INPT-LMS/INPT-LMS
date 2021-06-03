import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lms_flutter/components/consts/custom_colors.dart';
import 'package:lms_flutter/model/posts/commentaire_data.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:lms_flutter/services/auth_service.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:provider/provider.dart';

import '../../utils.dart';

class Comment extends StatelessWidget {
  CommentaireData commentaireData;
  void Function(String idComment) removeComment;
  Comment(this.commentaireData, this.removeComment, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authService = getIt.get<AuthService>();
    var infos = Provider.of<InfosModel>(context, listen: false).userInfos;
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
            ),
            if (infos.id == commentaireData.idProprietaire)
              IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    askConfirmation(context).then((value) {
                      if (value == null || !value) return;
                      removeComment(commentaireData.id);
                    });
                  })
          ]),
        );
      },
      future: authService
          .getUserInfos(commentaireData.idProprietaire)
          .then((response) => jsonDecode(response.body)["user"]["nom"]),
    );
  }
}

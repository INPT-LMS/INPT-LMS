import 'package:flutter/material.dart';
import 'package:lms_flutter/components/posts/comment.dart';
import 'package:lms_flutter/model/posts/commentaire_data.dart';
import 'package:lms_flutter/model/posts/like_data.dart';
import 'package:lms_flutter/services/post_service.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:lms_flutter/utils.dart';

class LikeComment extends StatefulWidget {
  String idPublication;
  int numberLikes;
  LikeData userLike;
  List<CommentaireData> commentairesData;
  LikeComment(this.idPublication, this.numberLikes, this.userLike,
      this.commentairesData,
      {Key key})
      : super(key: key);

  @override
  _LikeCommentState createState() => _LikeCommentState();
}

class _LikeCommentState extends State<LikeComment> {
  int numberLikes;
  LikeData userLike;
  bool isLikeDisabled;
  bool showComments;
  List<CommentaireData> commentairesData;
  List<Comment> commentaires;
  PostService postService;
  TextEditingController controller;
  void Function(String idComment) removeComment;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    numberLikes = this.widget.numberLikes;
    userLike = this.widget.userLike;
    showComments = false;
    commentairesData = this.widget.commentairesData;
    removeComment = (idComment) {
      postService.removeCommentaire(idComment).then((value) {
        setState(() {
          commentairesData.removeWhere((element) => element.id == idComment);
          commentaires.removeWhere(
              (element) => element.commentaireData.id == idComment);
        });
      }).catchError((e) {
        showDefaultErrorMessage(context, e);
      });
    };
    commentaires = commentairesData
        .map<Comment>((c) => Comment(c, removeComment))
        .toList();
    isLikeDisabled = false;
    postService = getIt.get<PostService>();
  }

  @override
  LikeComment get widget => super.widget;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var field = TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: "Ecrire un commentaire",
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (controller.text == null || controller.text.length == 0)
                    return;
                  postService
                      .addCommentaire(
                          this.widget.idPublication, controller.text)
                      .then((commentaireData) {
                    setState(() {
                      commentairesData.insert(0, commentaireData);
                      commentaires.insert(
                          0, Comment(commentaireData, removeComment));
                    });
                  }).catchError((e) {
                    showDefaultErrorMessage(context, e);
                  });
                  controller.clear();
                })));
    List<Widget> liste = [field];
    liste.addAll(commentaires);
    return Column(
      children: [
        Row(children: [
          IconButton(
              icon: Icon(
                  userLike != null ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red),
              onPressed: () {
                changeLike(context);
              }),
          Container(
              margin: EdgeInsets.only(left: 5), child: Text("$numberLikes")),
          IconButton(
              icon: Icon(Icons.comment, color: Colors.blue),
              onPressed: () {
                setState(() => showComments = !showComments);
              }),
          Container(
              margin: EdgeInsets.only(left: 5),
              child: Text("${commentaires.length}"))
        ]),
        if (showComments)
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: liste)
      ],
    );
  }

  void changeLike(BuildContext context) {
    if (isLikeDisabled) return;
    isLikeDisabled = true;
    if (userLike != null)
      postService.removeLike(userLike.id).then((value) {
        setState(() {
          userLike = null;
          numberLikes--;
          isLikeDisabled = false;
        });
      }).catchError((e) {
        showDefaultErrorMessage(context, e);
        setState(() {
          isLikeDisabled = true;
        });
      });
    else
      postService.addLike(this.widget.idPublication).then((value) {
        setState(() {
          userLike = value;
          numberLikes++;
          isLikeDisabled = false;
        });
      }).catchError((e) {
        showDefaultErrorMessage(context, e);
        setState(() {
          isLikeDisabled = true;
        });
      });
  }
}

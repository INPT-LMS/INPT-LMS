import 'package:flutter/material.dart';
import 'package:lms_flutter/components/posts/comment.dart';
import 'package:lms_flutter/model/posts/commentaire_data.dart';
import 'package:lms_flutter/model/posts/like_data.dart';
import 'package:lms_flutter/services/post_service.dart';
import 'package:lms_flutter/services/service_locator.dart';

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

  @override
  void initState() {
    super.initState();
    numberLikes = this.widget.numberLikes;
    userLike = this.widget.userLike;
    showComments = false;
    commentairesData = this.widget.commentairesData;
    var removeComment = (idComment) {
      postService.removeCommentaire(idComment).then((value) {
        setState(() {
          commentairesData.removeWhere((element) => element.id == idComment);
          commentaires.removeWhere(
              (element) => element.commentaireData.id == idComment);
        });
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          IconButton(
              icon: Icon(
                  userLike != null ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red),
              onPressed: changeLike),
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
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: commentaires)
      ],
    );
  }

  void changeLike() {
    if (isLikeDisabled) return;
    isLikeDisabled = true;
    if (userLike != null)
      postService.removeLike(userLike.id).then((value) {
        setState(() {
          userLike = null;
          numberLikes--;
          isLikeDisabled = false;
        });
      }, onError: (e) {
        setState(() {
          isLikeDisabled = false;
        });
      });
    else
      postService.addLike(this.widget.idPublication).then((value) {
        setState(() {
          userLike = value;
          numberLikes++;
          isLikeDisabled = false;
        });
      }, onError: (e) {
        setState(() {
          isLikeDisabled = false;
        });
      });
  }
}

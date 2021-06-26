import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/model/consts.dart';

class CoursePicture extends StatelessWidget {
  final String coursID ;
  const CoursePicture(this.coursID,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return CachedNetworkImage(
        imageUrl: Consts.URL_GATEWAY + "/storage/user/picture/$coursID",
        placeholder: (context, url) => Icon(Icons.perm_identity),
        errorWidget: (context, url, error) => Icon(Icons.perm_identity),
        imageBuilder: (context, imageProvider) =>
            CircleAvatar(backgroundImage: imageProvider));
  }
}

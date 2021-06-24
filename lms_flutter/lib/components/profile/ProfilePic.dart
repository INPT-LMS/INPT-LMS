import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/model/consts.dart';

class ProfilePic extends StatelessWidget {
  final int userId;
  ProfilePic(this.userId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: Consts.URL_GATEWAY + "/storage/user/picture/$userId",
        placeholder: (context, url) => Icon(Icons.perm_identity),
        errorWidget: (context, url, error) => Icon(Icons.perm_identity),
        imageBuilder: (context, imageProvider) =>
            CircleAvatar(backgroundImage: imageProvider));
  }
}

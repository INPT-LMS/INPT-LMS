import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/components/profile/CoverPic.dart';
import 'package:lms_flutter/components/profile/ProfileCourseSection.dart';
import 'package:lms_flutter/components/profile/ProfilePic.dart';
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/components/profile/AboutSection';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:provider/provider.dart';
class Profile extends StatefulWidget {
  final int id ;
  const Profile({ Key key, this.id }): super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserInfos userInfos ;
  @override
  Widget build(BuildContext context) {
    var infosModele = Provider.of<InfosModel>(context);
    userInfos = infosModele.userInfos;
    return BaseScaffoldAppBar(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Stack(
          children: <Widget>[
            // The containers in the background
            new Column(
              children: <Widget>[
                new CoverPic(),
              ],
            ),
            new Container(
              alignment: Alignment.topCenter,
              padding: new EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .15,
              ),
              child: new Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [ProfilePic()],
                ),
              ),
            ),
            Text("My name")
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            widget.id == null ? userInfos.nom : widget.id.toString(),
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        AboutMeSection(),
        CourseSection(),
      ],
    )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms_flutter/components/discussions/discussion.dart';
import 'package:lms_flutter/model/discussions/discussion_data.dart';
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/screens/liste/liste_data.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:lms_flutter/screens/view_models/liste_data_model.dart';
import 'package:lms_flutter/services/data_list/discussion_list_service.dart';
import 'package:lms_flutter/services/message_service.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:provider/provider.dart';

class ListeDiscussionScreen extends StatefulWidget {
  const ListeDiscussionScreen({Key key}) : super(key: key);

  @override
  _ListeDiscussionScreenState createState() => _ListeDiscussionScreenState();
}

class _ListeDiscussionScreenState extends State<ListeDiscussionScreen> {
  UserInfos infos;
  MessageService messageService;
  @override
  void initState() {
    messageService = getIt.get<MessageService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    infos = Provider.of<InfosModel>(context).userInfos;
    return BaseScaffoldAppBar(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(children: [
          Center(child: Text("Messagerie")),
          Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                      backgroundImage: AssetImage("images/pic.jpg")),
                ),
                Expanded(
                  child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              icon: Icon(Icons.search), onPressed: () {}),
                          labelText: "Chercher quelqu'un")),
                )
              ])),
          ChangeNotifierProvider(
              create: (context) => ListDataModel<DiscussionData>(
                  <DiscussionData>[],
                  <Widget>[],
                  (discData) => Discussion(discData)),
              child: ListeData<DiscussionData>(
                  DiscussionListService(getIt.get<MessageService>(), infos.id),
                  false))
        ]),
      ),
    );
  }
}

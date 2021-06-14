import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms_flutter/components/discussions/discussion.dart';
import 'package:lms_flutter/model/discussion/discussion_data.dart';
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
  List<String> withNewsDiscussionsId;
  MessageService messageService;

  @override
  void initState() {
    super.initState();
    withNewsDiscussionsId = [];
    messageService = getIt.get<MessageService>();
    messageService.getDiscussionHasNewMessage().then((value) {
      setState(() {
        withNewsDiscussionsId = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var infos = Provider.of<InfosModel>(context).userInfos;
    return BaseScaffoldAppBar(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(children: [
          Center(child: Text("Messagerie")),
          Expanded(
              child: ChangeNotifierProvider<ListDataModel<DiscussionData>>(
                  create: (context) => ListDataModel<DiscussionData>(
                      (discData) => Discussion(discData,
                          (discId) => withNewsDiscussionsId.contains(discId)),
                      (discData) => discData.id),
                  child: ListeData<DiscussionData>(
                      DiscussionListService(messageService, infos.id), false)))
        ]),
      ),
    );
  }
}

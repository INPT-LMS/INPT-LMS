import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms_flutter/components/devoirs/devoir.dart';
import 'package:lms_flutter/model/course/course_data.dart';
import 'package:lms_flutter/model/devoir/devoir_data.dart';
import 'package:lms_flutter/screens/liste/liste_data.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:lms_flutter/screens/view_models/liste_data_model.dart';
import 'package:lms_flutter/services/data_list/devoir_list_service.dart';
import 'package:lms_flutter/services/devoir_service.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:provider/provider.dart';

//TODO: Ajout devoir
class ListeDevoirsCoursScreen extends StatefulWidget {
  const ListeDevoirsCoursScreen({Key key}) : super(key: key);

  @override
  _ListeDevoirsCoursScreenState createState() =>
      _ListeDevoirsCoursScreenState();
}

class _ListeDevoirsCoursScreenState extends State<ListeDevoirsCoursScreen> {
  @override
  Widget build(BuildContext context) {
    var courseData = ModalRoute.of(context).settings.arguments as CourseData;
    var infos = Provider.of<InfosModel>(context, listen: false).userInfos;
    return BaseScaffoldAppBar(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(children: [
          Center(child: Text("Liste des devoirs du cours")),
          if (courseData.owner.professorID == infos.id)
            Center(
                child: TextButton(
                    child: Text("Ajouter un devoir"), onPressed: () {})),
          Expanded(
              child: ChangeNotifierProvider(
                  create: (context) => ListDataModel<DevoirData>(<DevoirData>[],
                      <Widget>[], (devoirData) => Devoir(devoirData, infos.id)),
                  child: ListeData<DevoirData>(
                      DevoirListService(
                          getIt.get<DevoirService>(), courseData.courseID),
                      false)))
        ]),
      ),
    );
  }
}

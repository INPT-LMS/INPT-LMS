import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms_flutter/components/stockage/fichier_resume.dart';
import 'package:lms_flutter/model/course/course_data.dart';
import 'package:lms_flutter/model/stockage/fichier.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:lms_flutter/screens/view_models/liste_data_model.dart';
import 'package:lms_flutter/services/data_list/fichier_list_service.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:lms_flutter/services/stockage_service.dart';
import 'package:provider/provider.dart';

import 'liste/liste_data.dart';

class StockageCoursScreen extends StatefulWidget {
  const StockageCoursScreen({Key key}) : super(key: key);

  @override
  _StockageCoursScreenState createState() => _StockageCoursScreenState();
}

class _StockageCoursScreenState extends State<StockageCoursScreen> {
  StockageService stockageService;
  @override
  void initState() {
    super.initState();
    stockageService = getIt.get<StockageService>();
  }

  @override
  Widget build(BuildContext context) {
    var cours = ModalRoute.of(context).settings.arguments as CourseData;
    var infos = Provider.of<InfosModel>(context).userInfos;
    var isOwner = cours.owner.professorID == infos.id;
    return BaseScaffoldAppBar(
        body: SingleChildScrollView(
            child: ChangeNotifierProvider(
      create: (context) => ListDataModel<Fichier>((fichier) {
        fichier.baseUrl =
            "/storage/class/${cours.courseID}/files/${fichier.id}";
        fichier.isOwner = isOwner;
        return FichierResume(fichier);
      }, (fichier) => fichier.id),
      builder: (context, _) {
        return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Center(child: Text("Fichiers du cours")),
          if (isOwner)
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Center(
                    child: ElevatedButton(
                        child: Text("Ajouter un fichier de votre sac au cours"),
                        onPressed: () =>
                            ajouterFichierDialog(context, cours)))),
          ListeData<Fichier>(
              FichierListService(getIt.get<StockageService>(),
                  "/storage/class/${cours.courseID}/files"),
              shrinkWrap: true)
        ]);
      },
    )));
  }

  void ajouterFichierDialog(BuildContext context, CourseData cours) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: ChangeNotifierProvider(
                  create: (context) => ListDataModel<Fichier>((fichier) {
                        var date = fichier.fichierInfo.dateCreation;
                        return ListTile(
                            leading: Icon(findIconFromFileType(
                                fichier.fichierInfo.contentType)),
                            title: Text(fichier.fichierInfo.nom),
                            subtitle: Text(
                                "Ajouté le ${DateFormat.yMMMMd('fr_FR').add_Hm().format(date)}"),
                            onTap: () => ajouterFichier(
                                context,
                                "/storage/class/${cours.courseID}/files",
                                fichier));
                      }, (fichier) => fichier.id),
                  builder: (context, _) {
                    return ListeData<Fichier>(
                        FichierListService(getIt.get<StockageService>(),
                            "/storage/user/files"),
                        shrinkWrap: true);
                  }));
        }).then((fichier) {
      if (fichier != null)
        Provider.of<ListDataModel<Fichier>>(context, listen: false)
            .addFirst(fichier);
    });
  }

  void ajouterFichier(BuildContext context, String url, Fichier fichier) {
    stockageService.ajoutFichierCours(url, fichier.id).then((idFichier) {
      fichier.id = idFichier;
      showSnackbar(context, "Fichier enregistré dans le cours !");
      Navigator.pop(context, fichier);
    }).catchError((e) {
      var code = e.response.statusCode;
      if (code == 404)
        showSnackbar(context, "Fichier non trouvé dans votre sac");
      else
        showSnackbar(context, e.response.statusCode);
      Navigator.pop(context);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms_flutter/model/course/course_data.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/services/devoir_service.dart';
import 'package:lms_flutter/services/service_locator.dart';

class AjoutDevoirScreen extends StatefulWidget {
  const AjoutDevoirScreen({Key key}) : super(key: key);

  @override
  _AjoutDevoirScreenState createState() => _AjoutDevoirScreenState();
}

class _AjoutDevoirScreenState extends State<AjoutDevoirScreen> {
  TextEditingController contenu;
  DevoirService devoirService;
  DateTime dateRendu;
  @override
  void initState() {
    super.initState();
    contenu = TextEditingController();
    devoirService = getIt.get<DevoirService>();
  }

  @override
  void dispose() {
    contenu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var courseData = ModalRoute.of(context).settings.arguments as CourseData;
    return BaseScaffoldAppBar(
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(20),
            child: Form(
                key: formKey,
                child: Column(children: [
                  TextFormField(
                      controller: contenu,
                      validator: (value) => value == null || value.isEmpty
                          ? "Veuillez saisir un contenu pour le devoir"
                          : null,
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Contenu du devoir")),
                  if (dateRendu != null)
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text("Devoir à rendre avant le "
                            "${DateFormat.yMMMMd('fr_FR').add_Hm().format(dateRendu)}")),
                  ElevatedButton(
                      child: Text("Choisir la date de rendu du devoir"),
                      onPressed: choisirDate),
                  ElevatedButton(
                      child: Text("Créer le devoir"),
                      onPressed: () {
                        if (dateRendu == null) {
                          showSnackbar(
                              context, "Veuillez choisir une date de rendu");
                          return;
                        }
                        if (formKey.currentState != null &&
                            formKey.currentState.validate()) {
                          devoirService
                              .creerDevoir(
                                  courseData.courseID, contenu.text, dateRendu)
                              .then((devoir) {
                            if (devoir.id == null)
                              showSnackbar(context,
                                  "Erreur : la date limite de rendu du devoir est déjà passée");
                            else {
                              showSnackbar(
                                  context, "Le devoir a bien été crée");
                              Navigator.pop(context, devoir);
                            }
                          });
                        }
                      })
                ]))),
      ),
    );
  }

  void choisirDate() {
    var now = DateTime.now();
    showDatePicker(
            context: context,
            initialDate: now.add(Duration(days: 1)),
            lastDate: DateTime(2050),
            firstDate: now.subtract(Duration(days: 1)),
            locale: Locale("fr", "FR"))
        .then((date) {
      if (date != null)
        return showTimePicker(
                context: context, initialTime: TimeOfDay(hour: 12, minute: 0))
            .then((time) {
          if (time != null)
            return date.add(Duration(hours: time.hour, minutes: time.minute));
        });
    }).then((date) {
      if (date != null)
        setState(() {
          dateRendu = date;
        });
    });
  }
}

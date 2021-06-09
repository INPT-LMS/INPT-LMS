import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/model/post/post_data.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:lms_flutter/screens/view_models/liste_data_model.dart';
import 'package:lms_flutter/services/post_service.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  final String idCours;
  AddPost(this.idCours, {Key key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController controller;
  PostService postService;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    postService = getIt.get<PostService>();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  AddPost get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    var infosModel = Provider.of<InfosModel>(context, listen: false);

    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 4,
                offset: Offset(0, 2))
          ]),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 24),
            child: Text("Ajouter une nouvelle publication"),
          ),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: "What's up ?",
              border: OutlineInputBorder(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (controller.text == null || controller.text.isEmpty)
                      return;
                    if (infosModel.networkType == ConnectivityResult.none) {
                      showSnackbar(context, "Pas de connexion");
                      return;
                    }
                    postService
                        .addPost(this.widget.idCours, controller.text)
                        .then((post) => Provider.of<ListDataModel<PostData>>(
                                context,
                                listen: false)
                            .addFirst(post))
                        .catchError((e) {
                      showDefaultErrorMessage(context, e);
                    });
                  },
                  child: Text("Ajouter"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    primary: Color(0xff0275B1), // background
                    onPrimary: Colors.white, // foreground
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:lms_flutter/services/service_locator.dart';

class BaseScaffoldAppBar extends StatefulWidget {
  final Widget body;
  final void Function() beforePush;
  final void Function() afterReturn;
  final FloatingActionButton actionButton;
  BaseScaffoldAppBar(
      {Key key,
      this.body,
      this.beforePush,
      this.afterReturn,
      this.actionButton})
      : super(key: key);

  @override
  _BaseScaffoldAppBarState createState() => _BaseScaffoldAppBarState();
}

class _BaseScaffoldAppBarState extends State<BaseScaffoldAppBar> {
  @override
  Widget build(BuildContext context) {
    var liste = <Widget>[
      ListTile(
          title: Row(
            children: [
              Icon(Icons.library_books, color: Colors.blue),
              Container(
                child: Text('Mes cours'),
                padding: EdgeInsets.only(left: 10),
              )
            ],
          ),
          onTap: () {
            pushRoute("/mycourses", "/mycourses");
          }),
      ListTile(
          title: Row(
            children: [
              Icon(Icons.cloud, color: Colors.blue),
              Container(
                child: Text('Mon sac'),
                padding: EdgeInsets.only(left: 10),
              )
            ],
          ),
          onTap: () {
            pushRoute("/stockage-sac", "/stockage-sac");
          }),
      ListTile(
          title: Text('Se deconnecter'),
          onTap: () {
            getIt.get<CompteService>().logout();
            Navigator.pushNamedAndRemoveUntil(
                context, "/login", (route) => false);
          }),
    ];

    var drawer = Drawer(
      child: ListView.separated(
        padding: EdgeInsets.only(top: 100),
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        itemCount: 3,
        itemBuilder: (context, index) => liste[index],
      ),
    );

    var appBar = AppBar(
      backwardsCompatibility: false,
      backgroundColor: Colors.white,
      foregroundColor: Colors.blue,
      title: Text("LMS"),
      actions: [
        IconButton(
            icon: Icon(Icons.home),
            tooltip: "Accueil",
            onPressed: () {
              pushRoute("/home", "/home");
            }),
        IconButton(
            icon: Icon(Icons.mail),
            tooltip: "Messages",
            onPressed: () {
              pushRoute("/messages", "/messages");
            }),
        IconButton(
            icon: Icon(Icons.settings),
            tooltip: "Parametres",
            onPressed: () {
              pushRoute("/settings", "/settings");
            }),
      ],
    );

    return widget.actionButton == null
        ? Scaffold(
            appBar: appBar,
            drawer: drawer,
            body: widget.body,
          )
        : Scaffold(
            appBar: appBar,
            drawer: drawer,
            body: widget.body,
            floatingActionButton: widget.actionButton,
          );
  }

  void pushRoute(String condition, String newRoute) {
    if (ModalRoute.of(context).settings.name != condition) {
      if (widget.beforePush != null) widget.beforePush();
      Navigator.pushNamed(context, newRoute).then((value) {
        if (widget.afterReturn != null) widget.afterReturn();
      });
    }
  }

  @override
  BaseScaffoldAppBar get widget => super.widget;
}

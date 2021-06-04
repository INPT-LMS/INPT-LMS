import 'package:flutter/material.dart';
import 'package:lms_flutter/services/auth_service.dart';
import 'package:lms_flutter/services/service_locator.dart';

class BaseScaffoldAppBar extends StatefulWidget {
  Widget body;
  BaseScaffoldAppBar({Key key, this.body}) : super(key: key);

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
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Vers mes cours")));
          }),
      ListTile(
          title: Row(
            children: [
              Icon(Icons.alarm, color: Colors.blue),
              Container(
                child: Text('Mes devoirs'),
                padding: EdgeInsets.only(left: 10),
              )
            ],
          ),
          onTap: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Vers mes devoirs")));
          }),
      ListTile(
          title: Row(
            children: [
              Icon(Icons.person, color: Colors.blue),
              Container(
                child: Text('Mon profil'),
                padding: EdgeInsets.only(left: 10),
              )
            ],
          ),
          onTap: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Vers mon profil")));
          }),
      ListTile(
          title: Text('Se deconnecter'),
          onTap: () {
            getIt.get<AuthService>().logout();
            Navigator.pushNamedAndRemoveUntil(
                context, "/login", (route) => false);
          }),
    ];
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        title: Text("LMS"),
        actions: [
          IconButton(
              icon: Icon(Icons.home), tooltip: "Accueil", onPressed: (){
            if (ModalRoute.of(context).settings.name != "/home")
              Navigator.pushNamed(context, "/home");
          }),
          IconButton(
              icon: Icon(Icons.add_alert_rounded),
              tooltip: "Alertes",
              onPressed: (){}),
          IconButton(
              icon: Icon(Icons.mail),
              tooltip: "Messages",
              onPressed: () {
                    if (ModalRoute.of(context).settings.name != "/messages")
                      Navigator.pushNamed(context, "/messages");
                  }),
          IconButton(
              icon: Icon(Icons.settings),
              tooltip: "Parametres",
              onPressed: () => {}),
        ],
      ),
      drawer: Drawer(
        child: ListView.separated(
          padding: EdgeInsets.only(top: 100),
          separatorBuilder: (context, index) => Divider(
            color: Colors.black,
          ),
          itemCount: 4,
          itemBuilder: (context, index) => liste[index],
        ),
      ),
      body: widget.body,
    );
  }

  @override
  BaseScaffoldAppBar get widget => super.widget;
}

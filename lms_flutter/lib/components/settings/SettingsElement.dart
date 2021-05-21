import 'package:flutter/cupertino.dart';

class SettingsElement extends StatefulWidget {
  const SettingsElement({Key key}) : super(key: key);

  @override
  _SettingsElementState createState() => _SettingsElementState();
}

class _SettingsElementState extends State<SettingsElement> {

  @override
  Widget build(BuildContext context) {
    return Text("Im expanded");
  }
}

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:lms_flutter/model/user_infos.dart';

class InfosModel extends ChangeNotifier {
  UserInfos userInfos;
  ConnectivityResult networkType;

  InfosModel(this.userInfos, this.networkType);

  void setInfos(UserInfos userInfos) {
    this.userInfos = userInfos;
    notifyListeners();
  }

  void setNetworkType(ConnectivityResult networkType) {
    this.networkType = networkType;
    notifyListeners();
  }
}

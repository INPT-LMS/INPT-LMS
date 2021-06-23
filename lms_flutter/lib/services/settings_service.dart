import 'dart:convert';
import 'dart:developer';

import 'package:dio/src/dio.dart';
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/model/user_register_form.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends BaseService{
  SettingsService(SharedPreferences sharedPreferences, Dio client) 
      : super(sharedPreferences, client);
  UserInfos getUserLoggedInfos(){
    return UserInfos
        .fromJson(jsonDecode(sharedPreferences.getString("userInfos")));
  }

  Future<bool> updateUser(UserInfos userInfos, int userID){
    client.put("/account/update/$userID",data : userInfos.toJson())
        .then((response)  {
        log(response.toString()) ;
        return true;


    });

  }
  
}
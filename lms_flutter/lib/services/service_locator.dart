import 'package:get_it/get_it.dart';
import 'package:lms_flutter/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'message_service.dart';

final getIt = GetIt.instance;

void setup() async {
  getIt.registerSingletonAsync<AuthService>(() async {
    return AuthService(await SharedPreferences.getInstance());
  });
  getIt.registerSingletonAsync<MessageService>(() async {
    return MessageService(await SharedPreferences.getInstance());
  });
}

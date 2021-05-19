import 'package:get_it/get_it.dart';
import 'package:lms_flutter/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'message_service.dart';

final getIt = GetIt.instance;

void setup() async {
  getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  getIt.registerSingletonWithDependencies<AuthService>(
      () => AuthService(getIt.get<SharedPreferences>()),
      dependsOn: [SharedPreferences]);

  getIt.registerSingletonWithDependencies<MessageService>(
      () => MessageService(getIt.get<SharedPreferences>()),
      dependsOn: [SharedPreferences]);
}

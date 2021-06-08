import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:lms_flutter/services/auth_service.dart';
import 'package:lms_flutter/services/post_service.dart';
import 'package:lms_flutter/services/stockage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'course_service.dart';
import 'devoir_service.dart';
import 'message_service.dart';

final getIt = GetIt.instance;

void setup() async {
  getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  getIt.registerSingletonWithDependencies<AuthService>(
      () => AuthService(getIt.get<SharedPreferences>(), http.Client()),
      dependsOn: [SharedPreferences]);

  getIt.registerSingletonWithDependencies<MessageService>(
      () => MessageService(getIt.get<SharedPreferences>(), http.Client()),
      dependsOn: [SharedPreferences]);

  getIt.registerSingletonWithDependencies<PostService>(
      () => PostService(getIt.get<SharedPreferences>(), http.Client()),
      dependsOn: [SharedPreferences]);

  getIt.registerSingletonWithDependencies<CourseService>(
      () => CourseService(getIt.get<SharedPreferences>(), http.Client()),
      dependsOn: [SharedPreferences]);

  getIt.registerSingletonWithDependencies<DevoirService>(
      () => DevoirService(getIt.get<SharedPreferences>(), http.Client()),
      dependsOn: [SharedPreferences]);

  getIt.registerSingletonWithDependencies<StockageService>(
      () => StockageService(getIt.get<SharedPreferences>(), http.Client()),
      dependsOn: [SharedPreferences]);
}

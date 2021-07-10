import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:lms_flutter/services/post_service.dart';
import 'package:lms_flutter/services/settings_service.dart';
import 'package:lms_flutter/services/stockage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'course_service.dart';
import 'devoir_service.dart';
import 'dio_client.dart';
import 'message_service.dart';

final getIt = GetIt.instance;

/// Fonction qui enregistre les différentes dépendances
void setupServices() async {
  getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  getIt.registerSingleton<Dio>(getDioClient());

  getIt.registerSingletonWithDependencies<CompteService>(
      () => CompteService(getIt.get<SharedPreferences>(), getIt.get<Dio>()),
      dependsOn: [SharedPreferences]);

  getIt.registerSingletonWithDependencies<MessageService>(
      () => MessageService(getIt.get<SharedPreferences>(), getIt.get<Dio>()),
      dependsOn: [SharedPreferences]);

  getIt.registerSingletonWithDependencies<PostService>(
      () => PostService(getIt.get<SharedPreferences>(), getIt.get<Dio>()),
      dependsOn: [SharedPreferences]);

  getIt.registerSingletonWithDependencies<CourseService>(
      () => CourseService(getIt.get<SharedPreferences>(), getIt.get<Dio>()),
      dependsOn: [SharedPreferences]);

  getIt.registerSingletonWithDependencies<DevoirService>(
      () => DevoirService(getIt.get<SharedPreferences>(), getIt.get<Dio>()),
      dependsOn: [SharedPreferences]);

  getIt.registerSingletonWithDependencies<StockageService>(
      () => StockageService(getIt.get<SharedPreferences>(), getIt.get<Dio>()),
      dependsOn: [SharedPreferences]);
  getIt.registerSingletonWithDependencies<SettingsService>(
          () => SettingsService(getIt.get<SharedPreferences>(), getIt.get<Dio>()),
      dependsOn: [SharedPreferences]);
}

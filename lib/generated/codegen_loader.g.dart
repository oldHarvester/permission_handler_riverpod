// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ru = {
  "allow": "Разрешить",
  "later": "Позже",
  "notification_permission": "Доступ к уведомлениям",
  "notification_permission_description": "Предоставьте доступ к уведомлениям для получения оповещений о важных событиях",
  "location_permission": "Доступ к местоположению",
  "location_permission_description": "Предоставьте доступ к местоположению для поиска возле вас"
};
static const Map<String,dynamic> en = {
  "allow": "Allow",
  "later": "Later",
  "notification_permission": "Notification permission",
  "notification_permission_description": "Allow notifications to receive alerts about important events",
  "location_permission": "Location permission",
  "location_permission_description": "Allow location permission to search near you"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru": ru, "en": en};
}

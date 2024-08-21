import 'package:flutter/material.dart';

abstract final class LocaleData {
  static const List<Locale> supportedLocales = [
    Locale('ru'),
    Locale('en'),
  ];

  static final fallbackLocale = supportedLocales.first;

  static const String localesPath = 'assets/translations';
}

import 'package:shared_preferences/shared_preferences.dart';

enum SharedPrefsKey {
  languageCode,
  ;
}

class SharedPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  Future<void> writeString(SharedPrefsKey key, String value) {
    return _instance.setString(key.name, value);
  }

  String? readString(SharedPrefsKey key) {
    return _instance.getString(key.name);
  }

  Future<bool> writeBool(SharedPrefsKey key, bool value) {
    return _instance.setBool(key.name, value);
  }

  bool? readBool(SharedPrefsKey key) {
    return _instance.getBool(key.name);
  }

  Future<void> delete(SharedPrefsKey key) {
    return _instance.remove(key.name);
  }

  Future<void> deleteAll() {
    return _instance.clear();
  }
}

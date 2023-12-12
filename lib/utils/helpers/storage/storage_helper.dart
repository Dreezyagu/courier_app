import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  StorageHelper._();

  static late SharedPreferences _prefs;

  static Future<SharedPreferences> _getInstance() async =>
      _prefs = await SharedPreferences.getInstance();

  static Future<String?> getString(String key) async {
    await _getInstance();
    return _prefs.getString(key);
  }

  static Future<bool> getBoolean(String key, bool defaultValue) async {
    if (key.isEmpty) return defaultValue;
    final SharedPreferences sharedPreferences = await (_getInstance());
    final value = sharedPreferences.getBool(key);
    if (value == null) {
      return defaultValue;
    }
    return value;
  }

  static void setString(String key, String? value) async {
    if (key.isEmpty || value!.isEmpty) return;
    final SharedPreferences preferences = await (_getInstance());
    preferences.setString(key, value);
  }

  static void setBoolean(String key, bool? value) async {
    if (key.isEmpty) return;
    final SharedPreferences preferences = await (_getInstance());
    preferences.setBool(key, value!);
  }

  static void remove(String key) async {
    if (key.isEmpty) return;
    final SharedPreferences preferences = await (_getInstance());
    if (preferences.containsKey(key)) {
      preferences.remove(key);
    }
  }

  static Future<bool> clearPreferences() async {
    final SharedPreferences preferences = await (_getInstance());
    return await preferences.clear();
  }
}

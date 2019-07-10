import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  static const KEY_TOKEN = "KEY_TOKEN";
  static const KEY_USERNAME = "KEY_USERNAME";
  static const KEY_ISLOGIN = "KEY_ISLOGIN";

  static add(key, value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (value is double) {
      preferences.setDouble(key, value);
    } else if (value is String) {
      preferences.setString(key, value);
    } else if (value is bool) {
      preferences.setBool(key, value);
    } else if (value is int) {
      preferences.setInt(key, value);
    } else if (value is List) {
      preferences.setStringList(key, value);
    }
  }

  static Future remove(key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  static Future<String> getString(key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  static Future<bool> getBool(key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key) ?? false;
  }

  static Future<double> getDouble(key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getDouble(key);
  }

  static Future<int> getInt(key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key);
  }

  static Future<List<String>> getStringList(key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(key);
  }

  static Future get(key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(key);
  }
}

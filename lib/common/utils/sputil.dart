import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {

  static const KEY_TOKEN = "KEY_TOKEN";




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

  static remove(key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  static get(key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(key);
  }
}

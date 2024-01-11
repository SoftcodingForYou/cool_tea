import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  SPHelper._();
  static SPHelper sp = SPHelper._();
  SharedPreferences? prefs;
  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }
  String? getString(String key) {
    return prefs?.getString(key);
  }
  int? getInt(String key) {
    return prefs?.getInt(key);
  }
  bool? getBool(String key) {
    return prefs?.getBool(key);
  }
  double? getDouble(String key) {
    return prefs?.getDouble(key);
  }

  Future<void> saveString(String name, String value) async {
    await prefs?.setString(name, value);
  }
  Future<void> saveInt(String name, int value) async {
    await prefs?.setInt(name, value);
  }
  Future<void> saveBool(String name, bool value) async {
    await prefs?.setBool(name, value);
  }

}
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper{
  static SharedPreferences? _sharedPreferences;
  static Future <void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }
}
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _storage;

  static Future<SharedPreferences> get instance async {
    _storage ??= await SharedPreferences.getInstance();
    return _storage!;
  }
}
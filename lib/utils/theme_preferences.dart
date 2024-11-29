import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/preferences_helper.dart';

class ThemePreferences{

  static saveTheme({required bool isDark}) async
  {
      //final preferences = await SharedPreferences.getInstance();
      final preferences = await SharedPreferencesHelper.instance;
      preferences.setBool('isDark', isDark);
  }

  static Future<bool> getTheme() async
  {
   // final preferences = await SharedPreferences.getInstance();
    final preferences = await SharedPreferencesHelper.instance;
    return preferences.getBool('isDark') ?? false;
  }

}
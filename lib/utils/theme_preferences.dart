import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences{

  static saveTheme({required bool isDark}) async
  {
      final preferences = await SharedPreferences.getInstance();
      preferences.setBool('isDark', isDark);
  }

  static Future<bool> getTheme() async
  {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getBool('isDark') ?? false;
  }

}
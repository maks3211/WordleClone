import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  bool isDark = false;

  setTheme({required bool dark})
  {
    isDark = dark;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';

class LevelProvider with ChangeNotifier {
  double _level = 5;
  double get level => _level;
  void updateLevel(double newLevel) {
    _level = newLevel;
    notifyListeners();
  }
}
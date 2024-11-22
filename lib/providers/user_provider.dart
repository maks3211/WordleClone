import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _username = "";
  bool _isLogged = false;
  String get username => _username;
  bool get isLogged => _isLogged;
  void setUserName(String username) {
    _username = username;
    if(_username.trim().isNotEmpty)
      {
        _isLogged = true;
      }
    else
      {
        _isLogged = false;
      }
    notifyListeners();
  }
}
import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  bool darkMode = false;
  bool randomCards = false;
  int answerTime = 5;

  void setColorTheme(bool val) {
    darkMode = val;
    //todo set hive settings
    notifyListeners();
  }

  void setRandom(bool val) {
    randomCards = val;
    //todo set hive settings
    notifyListeners();
  }

  void setTime(int val) {
    answerTime = val;
    //todo set hive settings
    notifyListeners();
  }
}

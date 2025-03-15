import 'package:flutter/material.dart';
import 'package:leitner_app/hive_data/board_data.dart';

class ExerciseMainViewModel extends ChangeNotifier {
  BoardData? selectedBoard;
  bool isRandom = false;
  bool timeLimit = false;
  List<int> timeOptions = [5, 7, 9, 11, 13, 15];
  int timeIndex = 0;
  int timeLimitSeconds = 5;
  void setRandom(bool val) {
    isRandom = val;
    notifyListeners();
  }

  void initBoard(BoardData board) {
    selectedBoard = board;
    notifyListeners();
  }

  void setTimeLimitSeconds(int val) {
    timeLimitSeconds = timeOptions[val];
    timeIndex = val;
    notifyListeners();
  }

  void setTimeLimit(bool val) {
    timeLimit = val;
    notifyListeners();
  }

  void clearData() {
    selectedBoard = null;
  }
}

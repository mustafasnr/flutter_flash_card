import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:leitner_app/hive_data/board_data.dart';

class ExerciseGameViewModel extends ChangeNotifier {
  PageController scrollController = PageController();
  BoardData? boardData;
  List<GlobalKey<FlipCardState>> cardKeys = [];
  int correct = 0, wrong = 0, empyt = 0;
  int index = 0;
  static const double maxSeconds = 5.0;
  double seconds = maxSeconds;
  bool isTransitioning = false,
      isGameStarted = false,
      isGamePaused = false,
      isGameEnded = false,
      isGameLeaved = false;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> flipCurrentCard() async {
    if (!isTransitioning && isGameStarted && index < cardKeys.length) {
      final currentCardKey = cardKeys[index];
      if (currentCardKey.currentState != null) {
        currentCardKey.currentState!.toggleCard();
      }
    }
  }

  Future<void> resumeGame() async {
    isGamePaused = false;
    notifyListeners();
  }

  Future<void> pauseGame() async {
    isGamePaused = true;
    notifyListeners();
  }

  Future<void> leftGame() async {
    timer?.cancel();
    timer = null;
    isGameLeaved = true;
    notifyListeners();
  }

  Future<void> resetTimer() async {
    if (isGameStarted) {
      seconds = maxSeconds;
      if (timer == null) {
        startTimer();
      }
      notifyListeners();
    }
  }

  Future<void> _initCards(BoardData boardVal) async {
    boardData = boardVal;
    cardKeys.addAll(boardVal.cards.map((_) => GlobalKey<FlipCardState>()));
  }

  Future<void> initGame(BoardData boardVal) async {
    await clearData();
    await _initCards(boardVal);
    notifyListeners();
  }

  Future<void> startGame() async {
    isGameStarted = true;
    resetTimer();
  }

  Future<void> clearData() async {
    boardData = null;
    cardKeys.clear();
    timer?.cancel();
    timer = null;
    isGameStarted = false;
    isGamePaused = false;
    isGameEnded = false;
    isGameLeaved = false;
    isTransitioning = false;
    seconds = maxSeconds;
    correct = 0;
    wrong = 0;
    empyt = 0;
    index = 0;
  }

  Future<void> endGame() async {
    timer?.cancel();
    timer = null;
    isGameEnded = true;
    notifyListeners();
  }

  void startTimer() {
    timer?.cancel();
    seconds = maxSeconds;
    timer = Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        if (seconds > 0.0) {
          if (!isGamePaused && isGameStarted) {
            seconds -= 0.05;
            notifyListeners();
          }
        } else {
          nextCard(null);
        }
      },
    );
  }

  Future<void> nextCard(bool? isCorrect) async {
    if (!isGameStarted || isTransitioning) return;

    isCorrect != null
        ? isCorrect
            ? correct++
            : wrong++
        : empyt++;
    if (index < boardData!.cards.length - 1) {
      resetTimer();
      isTransitioning = true;
      notifyListeners();

      try {
        await scrollController.nextPage(
          duration: const Duration(milliseconds: 375),
          curve: Curves.easeInOut,
        );
      } finally {
        isTransitioning = false;
        setIndex(index + 1);
        notifyListeners();
      }
    } else {
      await endGame();
    }
  }

  void setIndex(int val) {
    if (val >= 0 && val < boardData!.cards.length) {
      index = val;
      notifyListeners();
    }
  }
}

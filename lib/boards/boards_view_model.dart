import 'package:flutter/material.dart';
import 'package:leitner_app/hive_boxes.dart';
import 'package:leitner_app/hive_data/board_data.dart';

class BoardsViewModel extends ChangeNotifier {
  List<BoardData> _boardListVM = [];
  List<BoardData> get favoriteBoards =>
      _boardListVM.where((board) => board.isFavorite).toList();
  List<BoardData> get otherBoards =>
      _boardListVM.where((board) => !board.isFavorite).toList();
  Future<void> updateBoards() async {
    if (boardBox.length != _boardListVM.length) {
      
    }_boardListVM = boardBox.values.toList();
    notifyListeners();
  }

  Future<void> deleteBoard(BoardData board) async {
    if (_boardListVM.contains(board)) {
      boardBox.delete(board.id);
      _boardListVM.remove(board);
      notifyListeners();
    }
  }

  Future<void> addBoard(BoardData board) async {
    if (_boardListVM.contains(board)) {
      return;
    }
    boardBox.put(board.id, board);
    _boardListVM.add(board);
    notifyListeners();
  }

  Future<void> toggleFavorite(BoardData board) async {
    board.isFavorite = !board.isFavorite;
    boardBox.put(board.id, board);
    notifyListeners();
  }
}

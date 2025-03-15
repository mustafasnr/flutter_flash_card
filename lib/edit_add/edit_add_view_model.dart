import 'package:flutter/material.dart';
import 'package:leitner_app/hive_boxes.dart';
import 'package:leitner_app/hive_data/board_data.dart';
import 'package:leitner_app/hive_data/card_data.dart';

class EditAddViewModel extends ChangeNotifier {
  BoardData? editedBoardData;
  BoardData? _originalRef;
  List<FocusNode> focusNodes = [];

  bool anyChange = false;

  bool get isBoardValid =>
      editedBoardData!.name.isNotEmpty &&
      editedBoardData!.cards.isNotEmpty &&
      editedBoardData!.cards
          .where((card) => card.front.isEmpty || card.back.isEmpty)
          .isEmpty;

  void editNextCard(int indexVal) async {
    if (indexVal == editedBoardData!.cards.length - 1) {
      await addCard("", "");
      notifyListeners();
    }
    focusNodes[(indexVal + 1) * 2].requestFocus();
  }

  Future<void> initBoard(BoardData? initValue) async {
    if (initValue == null) {
      editedBoardData = BoardData(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: "",
        cards: [],
        isFavorite: false,
      );
      _originalRef = null;
    } else {
      editedBoardData = initValue.copy();
      _originalRef = initValue;
    }
    await _initFocusNodes();
    notifyListeners();
  }

  Future<void> clearBoardData() async {
    editedBoardData = null;
    _originalRef = null;
    anyChange = false;
  }

  Future<void> deleteCard(int indexVal) async {
    debugPrint("${indexVal * 2 + 0}, ${indexVal * 2 + 2}");
    editedBoardData!.cards.removeAt(indexVal);
    focusNodes[indexVal * 2 + 0].dispose();
    focusNodes[indexVal * 2 + 1].dispose();
    focusNodes.removeRange(indexVal * 2 + 0, indexVal * 2 + 2);
    notifyListeners();
  }

  Future<void> cancelEdit() async {
    _originalRef = _originalRef;
    notifyListeners();
  }

  Future<void> _initFocusNodes() async {
    for (int i = 0; i < editedBoardData!.cards.length; i++) {
      focusNodes.add(FocusNode()); //frontFocusNode
      focusNodes.add(FocusNode()); //backFocusNode
    }
  }

  Future<void> disposeAllFocusNodes() async {
    for (var fn in focusNodes) {
      fn.dispose();
    }
    focusNodes.clear();
  }

  void requestFocusNode(int indexVal) {
    focusNodes[indexVal].requestFocus();
  }

  Future<void> addCard(String front, String back) async {
    focusNodes.add(FocusNode()); //frontFocusNode
    focusNodes.add(FocusNode()); //backFocusNode
    editedBoardData!.cards.add(
      CardData(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        front: front,
        back: back,
        level: 0,
      ),
    );
    anyChange = true;
    notifyListeners();
  }

  Future<void> saveBoard() async {
    if (editedBoardData!.name.isNotEmpty &&
        editedBoardData!.cards.isNotEmpty &&
        editedBoardData!.cards
            .any((card) => card.front.isNotEmpty && card.back.isNotEmpty)) {
      await boardBox.put(editedBoardData!.id, editedBoardData!);
      _originalRef = editedBoardData;
      notifyListeners();
    }
  }

  void setCardFront(int indexVal, String front) {
    editedBoardData!.cards[indexVal].front = front.trim();
    anyChange = true;
    notifyListeners();
  }

  void setCardBack(int indexVal, String back) {
    editedBoardData!.cards[indexVal].back = back.trim();
    anyChange = true;
    notifyListeners();
  }

  void setBoardName(String name) {
    editedBoardData!.name = name;
    anyChange = true;
    notifyListeners();
  }
}

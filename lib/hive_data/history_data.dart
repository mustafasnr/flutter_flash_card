import 'package:hive/hive.dart';

part 'history_data.g.dart';

@HiveType(typeId: 2)
class HistoryData {
  @HiveField(0)
  String boardId;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  int correct;

  @HiveField(3)
  int wrong;

  @HiveField(4)
  int empty;

  HistoryData({
    required this.boardId,
    required this.date,
    required this.correct,
    required this.wrong,
    required this.empty,
  });
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leitner_app/boards/board_card.dart';
import 'package:leitner_app/hive_data/board_data.dart';

class BoardList extends StatelessWidget {
  final List<BoardData> boards;
  const BoardList({super.key, required this.boards});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        boards.length,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: BoardCard(
            boardData: boards[index],
          ),
        ),
      ),
    );
  }
}
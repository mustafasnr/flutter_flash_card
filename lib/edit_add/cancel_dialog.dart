import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leitner_app/boards/boards_view_model.dart';
import 'package:leitner_app/edit_add/edit_add_view_model.dart';
import 'package:provider/provider.dart';

Future<dynamic> showCancelDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Değişiklikleri İptal Et?",
          style: GoogleFonts.urbanist(
            fontSize: 22.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop(); // Diyaloğu kapat
            },
            child: Text(
              "Hayır",
              style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              context.read<EditAddViewModel>().cancelEdit();
              context.read<BoardsViewModel>().updateBoards();
              context.pop();
            },
            child: Text(
              "Evet",
              style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}

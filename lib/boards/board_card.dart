import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leitner_app/boards/boards_view_model.dart';
import 'package:leitner_app/edit_add/edit_add_view_model.dart';
import 'package:leitner_app/exercise/e_main_view_model.dart';
import 'package:leitner_app/hive_data/board_data.dart';
import 'package:provider/provider.dart';

class BoardCard extends StatelessWidget {
  final BoardData boardData;
  const BoardCard({
    super.key,
    required this.boardData,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(boardData.id),
      confirmDismiss: (direction) async {
        bool x = false;
        await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                "Pano Silinsin mi?",
                style: GoogleFonts.urbanist(
                  fontSize: 26.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              content: Text(
                "Bu işlemi geri alamazsınız.",
                style: GoogleFonts.urbanist(
                  fontSize: 20.sp,
                  color: Colors.black87,
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
                      fontSize: 20.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    x = true;
                    context.read<BoardsViewModel>().deleteBoard(boardData);
                    context.pop();
                    // Burada pop çağırmıyoruz ki diyalog kapanmasın
                  },
                  child: Text(
                    "Evet",
                    style: GoogleFonts.urbanist(
                      fontSize: 20.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          },
        );
        return x;
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16.w),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(Icons.delete, color: Colors.white, size: 28.sp),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          child: InkWell(
            onTap: () async {
              context.read<ExerciseMainViewModel>().initBoard(boardData);
              context.push("/exercise_main");
            },
            borderRadius: BorderRadius.circular(12.r),
            splashColor: Colors.black.withValues(alpha: 0.08),
            hoverColor: Colors.black.withValues(alpha: 0.04),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          boardData.name,
                          style: GoogleFonts.urbanist(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "${boardData.cards.length} kelime",
                          style: GoogleFonts.urbanist(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      debugPrint("Favori olayı değiştiriliyor");
                      context.read<BoardsViewModel>().toggleFavorite(boardData);
                    },
                    icon: boardData.isFavorite
                        ? Icon(Icons.favorite_rounded,
                            size: 24.sp, color: Colors.red)
                        : Icon(Icons.favorite_outline_rounded,
                            size: 24.sp, color: Colors.grey),
                  ),
                  SizedBox(width: 8.w),
                  IconButton(
                    onPressed: () {
                      debugPrint("Pano düzenleme ekranı açılıyor");
                      context.read<EditAddViewModel>().initBoard(boardData);
                      context.push("/edit_add");
                    },
                    icon: Icon(Icons.edit, size: 20.sp, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

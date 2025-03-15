import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leitner_app/boards/boards_view_model.dart';
import 'package:leitner_app/exercise/e_main_view_model.dart';
import 'package:leitner_app/hive_data/board_data.dart';
import 'package:provider/provider.dart';

class IndexDrawer extends StatelessWidget {
  const IndexDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(14.r),
          bottomRight: Radius.circular(14.r),
        ),
      ),
      width: 240.w,
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DrawerTitleItem(
                icon: Icons.library_books,
                title: "Panolarım",
                onTap: () {
                  context.push("/boards");
                  debugPrint("Panolarım tıklandı");
                },
              ),
              DrawerTitleItem(
                icon: Icons.settings,
                title: "Ayarlar",
                onTap: () {
                  context.push("/settings");
                  debugPrint("Ayarlar tıklandı");
                },
              ),
              Consumer<BoardsViewModel>(
                builder: (context, bvm, child) {
                  if (bvm.favoriteBoards.isNotEmpty) {
                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const DrawerTitleItem(
                            icon: Icons.favorite,
                            title: "Favoriler",
                          ),
                          Divider(
                            height: 1.h,
                            color: Colors.black.withValues(alpha: 0.2),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: 7.5.h),
                              itemCount: bvm.favoriteBoards.length,
                              itemBuilder: (context, index) =>
                                  DrawerFavoriteBoard(
                                favBoard: bvm.favoriteBoards[index],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerFavoriteBoard extends StatelessWidget {
  const DrawerFavoriteBoard({
    super.key,
    required this.favBoard,
  });

  final BoardData favBoard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.5.h),
      child: InkWell(
        onTap: () async {
          context.read<ExerciseMainViewModel>().initBoard(favBoard);
          context.push("/exercise_main");
        },
        hoverColor: Colors.black.withValues(alpha: 0.075),
        highlightColor: Colors.black.withValues(alpha: 0.15),
        splashColor: Colors.black.withValues(alpha: 0.2),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 7.5.h, horizontal: 10.w),
          child: Text(
            favBoard.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 24.sp,
              color: Colors.black87,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerTitleItem extends StatelessWidget {
  const DrawerTitleItem({
    super.key,
    this.icon,
    required this.title,
    this.onTap,
  });

  final IconData? icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: onTap != null
          ? Colors.black.withValues(alpha: 0.075)
          : Colors.transparent,
      highlightColor: onTap != null
          ? Colors.black.withValues(alpha: 0.15)
          : Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32.sp,
              color: Colors.deepOrangeAccent,
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.urbanist(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

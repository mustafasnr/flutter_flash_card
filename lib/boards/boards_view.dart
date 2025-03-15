import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leitner_app/boards/boardl_list.dart';
import 'package:leitner_app/boards/boards_view_model.dart';
import 'package:leitner_app/boards/section_title.dart';
import 'package:leitner_app/components/app_bar_with_title.dart';
import 'package:leitner_app/edit_add/edit_add_view_model.dart';
import 'package:provider/provider.dart';

class BoardsView extends StatefulWidget {
  const BoardsView({super.key});

  @override
  State<BoardsView> createState() => _BoardsViewState();
}

class _BoardsViewState extends State<BoardsView> {
  @override
  void initState() {
    super.initState();
    debugPrint("asdşlkasdklsad");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BoardsViewModel>().updateBoards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardsViewModel>(
      builder: (context, bvm, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(0, 50.h),
          child: const AppBarWithTitle(
            title: "Panolarım",
          ),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: (bvm.favoriteBoards.isEmpty && bvm.otherBoards.isEmpty)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: Colors.blueGrey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 6,
                        shadowColor: Colors.black26,
                        child: Padding(
                          padding: EdgeInsets.all(24.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.dashboard_customize_rounded,
                                  size: 50.sp, color: Colors.blueAccent),
                              SizedBox(height: 10.h),
                              Text(
                                "Henüz pano eklenmedi",
                                style: GoogleFonts.urbanist(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20.h),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                    vertical: 12.h,
                                  ),
                                  elevation: 4,
                                ),
                                onPressed: () async {
                                  await context
                                      .read<EditAddViewModel>()
                                      .initBoard(null);
                                  if (context.mounted) {
                                    context.push("/edit_add");
                                  }
                                },
                                child: Text(
                                  "Pano Ekle",
                                  style: GoogleFonts.urbanist(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (bvm.favoriteBoards.isNotEmpty) ...[
                                const SectionTitle(title: "Favoriler"),
                                BoardList(boards: bvm.favoriteBoards),
                              ],
                              if (bvm.otherBoards.isNotEmpty) ...[
                                const SectionTitle(title: "Tümü"),
                                BoardList(boards: bvm.otherBoards),
                              ],
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

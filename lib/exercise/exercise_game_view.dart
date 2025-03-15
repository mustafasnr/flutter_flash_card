import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leitner_app/exercise/e_game_view_model.dart';
import 'package:leitner_app/exercise/flip_card.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExerciseGameView extends StatefulWidget {
  const ExerciseGameView({super.key});

  @override
  State<ExerciseGameView> createState() => _ExerciseGameViewState();
}

class _ExerciseGameViewState extends State<ExerciseGameView> {
  late ExerciseGameViewModel egvm;
  @override
  void initState() {
    egvm = context.read<ExerciseGameViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startGameDialog(context);
    });
    super.initState();
  }

  Future<void> _startGameDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(
            "Alıştırmaya Başla",
            style: GoogleFonts.urbanist(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            "Hazır olduğunuzda alıştırmaya başlayabilirsiniz. İptal ederseniz önceki sayfaya döneceksiniz.",
            style: GoogleFonts.urbanist(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                context.pop();
              },
              child: Text(
                "İptal",
                style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                context.pop(); // Diyaloğu kapat
                egvm.startGame(); // Oyunu başlat
              },
              child: Text(
                "Başla",
                style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPauseDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(
            "Çıkmak İstiyor musun?",
            style: GoogleFonts.urbanist(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                egvm.leftGame();
                context.pop();
              },
              child: Text(
                "Evet",
                style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop(); // Diyaloğu kapat
                egvm.resumeGame(); // Oyunu başlat
              },
              child: Text(
                "İptal",
                style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await egvm.endGame();
      await egvm.clearData();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseGameViewModel>(
      builder: (context, egvm, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (!didPop && !egvm.isGameEnded) {
              egvm.pauseGame();
              await _showPauseDialog(context);
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              alignment: Alignment.center,
              children: [
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "İngilizce Kelimeler Panosu Level 1",
                          style: GoogleFonts.urbanist(
                            fontSize: 20.sp,
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CircularPercentIndicator(
                          radius: 32.r,
                          lineWidth: 3.w,
                          backgroundColor: Colors.orange,
                          progressColor: const Color.fromRGBO(128, 128, 128, 1),
                          percent:
                              (egvm.seconds / ExerciseGameViewModel.maxSeconds)
                                  .clamp(0, 1),
                          center: Text(
                            (egvm.seconds)
                                .abs()
                                .clamp(0, ExerciseGameViewModel.maxSeconds)
                                .toStringAsFixed(1),
                            style: GoogleFonts.urbanist(
                                fontSize: 20.sp, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Expanded(
                          child: PageView.builder(
                            itemCount: egvm.boardData!.cards.length,
                            controller: egvm.scrollController,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollBehavior: const MaterialScrollBehavior(),
                            itemBuilder: (context, index) => ExerciseFlipCard(
                              flipState: egvm.cardKeys[index],
                              cardData: egvm.boardData!.cards[index],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton.outlined(
                              onPressed: () async {
                                await egvm.nextCard(false);
                              },
                              splashColor: Colors.amber,
                              icon: Icon(
                                Icons.close_rounded,
                                size: 40.sp,
                                color: Colors.redAccent,
                              ),
                              padding: EdgeInsets.all(10.r),
                              highlightColor:
                                  Colors.black.withValues(alpha: 0.15),
                            ),
                            IconButton.outlined(
                              onPressed: () async {
                                await egvm.flipCurrentCard();
                              },
                              icon: Icon(
                                Icons.replay_rounded,
                                size: 40.sp,
                                color: Colors.blueAccent,
                              ),
                              padding: EdgeInsets.all(10.r),
                              highlightColor:
                                  Colors.black.withValues(alpha: 0.15),
                            ),
                            IconButton.outlined(
                              onPressed: () async {
                                await egvm.nextCard(true);
                              },
                              icon: Icon(
                                Icons.done,
                                size: 40.sp,
                                color: Colors.greenAccent,
                              ),
                              padding: EdgeInsets.all(10.r),
                              highlightColor:
                                  Colors.black.withValues(alpha: 0.15),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                if (egvm.isGameEnded && !egvm.isGameLeaved) ...[
                  ModalBarrier(
                    dismissible: false,
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                  Dialog(
                    backgroundColor: Colors.transparent,
                    child: Container(
                      width: 320.w,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Alıştırma Tamamlandı",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(1),
                              },
                              children: [
                                const TableRow(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  children: [
                                    TableCell(text: "Doğru", isHeader: true),
                                    TableCell(text: "Yanlış", isHeader: true),
                                    TableCell(text: "Boş", isHeader: true),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(text: egvm.correct.toString()),
                                    TableCell(text: egvm.wrong.toString()),
                                    TableCell(text: egvm.empyt.toString()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 12.h),
                            ),
                            onPressed: () {
                              context.pop();
                              context.pop();
                            },
                            child: Text(
                              "Bitir",
                              style: GoogleFonts.roboto(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}

class TableCell extends StatelessWidget {
  const TableCell({super.key, required this.text, this.isHeader = false});
  final String text;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          fontSize: isHeader ? 20.sp : 18.sp,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: Colors.black87,
        ),
      ),
    );
  }
}

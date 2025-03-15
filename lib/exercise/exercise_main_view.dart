import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leitner_app/components/app_bar_with_title.dart';
import 'package:leitner_app/exercise/e_game_view_model.dart';
import 'package:leitner_app/exercise/e_main_view_model.dart';
import 'package:leitner_app/hive_data/board_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseMainView extends StatefulWidget {
  const ExerciseMainView({super.key});

  @override
  State<ExerciseMainView> createState() => _ExerciseMainViewState();
}

class _ExerciseMainViewState extends State<ExerciseMainView> {
  ExerciseMainViewModel? _emvm;
  late FixedExtentScrollController scrollController;
  @override
  void didChangeDependencies() {
    _emvm = context.read<ExerciseMainViewModel>();
    scrollController =
        FixedExtentScrollController(initialItem: _emvm!.timeIndex);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _emvm?.clearData();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: const AppBarWithTitle(title: "Alıştırmaya Başla"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Seçtiğin panoda bulunan kartları bilmeye çalışacaksın. Her kart rastgele önüne gelebilir veya sadece kelimeleri görmek isteyebilirsin, aşağıdan ayarla.",
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 24.h),
              Consumer<ExerciseMainViewModel>(
                builder: (context, emvm, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Seçilen Pano: ${emvm.selectedBoard!.name}",
                            style: GoogleFonts.urbanist(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Kelime sayısı: ${emvm.selectedBoard!.cards.length}",
                            style: GoogleFonts.urbanist(
                                fontSize: 20.sp,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Kartlar rastgele verilsin mi?",
                        style: GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      value: emvm.isRandom,
                      onChanged: (value) => emvm.setRandom(value!),
                      activeColor: Colors.blueAccent,
                    ),
                    SizedBox(height: 16.h),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Zamana karşı yarış",
                        style: GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      value: emvm.timeLimit,
                      onChanged: (value) => emvm.setTimeLimit(value!),
                      activeColor: Colors.blueAccent,
                    ),
                    if (emvm.timeLimit) ...[
                      SizedBox(height: 16.h),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          "Cevap süresi (saniye):",
                          style: GoogleFonts.urbanist(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: Container(
                          height: 44.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border:
                                Border.all(width: 1.w, color: Colors.black54),
                          ),
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 22.h,
                            perspective: 0.007,
                            diameterRatio: 2,
                            physics: const FixedExtentScrollPhysics(),
                            controller: scrollController,
                            onSelectedItemChanged: (index) {
                              emvm.setTimeLimitSeconds(index);
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index) {
                                return Center(
                                  child: Text(
                                    emvm.timeOptions[index].toString(),
                                    style: GoogleFonts.urbanist(
                                      fontSize: 22.sp,
                                      height: 22.h / 22.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              },
                              childCount: emvm.timeOptions.length,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  BoardData board =
                      context.read<ExerciseMainViewModel>().selectedBoard!;
                  await context.read<ExerciseGameViewModel>().initGame(board);
                  if (context.mounted) {
                    context.push("/exercise_game");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "Başla",
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

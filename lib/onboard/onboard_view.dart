import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leitner_app/onboard/onboard_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    
    void changePage(int dx) async {
      final ovm = context.read<OnboardViewModel>();
      if (!ovm.isTransitioning) {
        ovm.setTransition(true);
        await pageController.animateToPage(ovm.index + dx,
            duration: const Duration(milliseconds: 375),
            curve: Curves.easeInOut);
        ovm.setTransition(false);
      }
    }

    return Consumer<OnboardViewModel>(
      builder: (context, ovm, child) => Scaffold(
        backgroundColor: const Color.fromRGBO(145, 145, 145, 1),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              children: [
                Container(
                  height: 450.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  child: PageView.builder(
                    controller: pageController,
                    onPageChanged: ovm.setIndex,
                    itemCount: ovm.assets.length,
                    itemBuilder: (context, index) => Center(
                      child: Text(
                        "Svg_${ovm.assets[index]}",
                        style: GoogleFonts.poppins(
                          fontSize: 32.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    ovm.assets.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                          right: ovm.assets.length - 1 != index ? 4.w : 0),
                      child: OnboardDot(active: index == ovm.index),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: ovm.widgets[ovm.index],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (ovm.index != 0)
                      SizedBox(
                        width: 125.w,
                        child: ElevatedButton(
                          onPressed: () => changePage(-1),
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                          ),
                          child: Text(
                            "Önceki",
                            style: GoogleFonts.urbanist(
                              fontSize: 20.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    const Spacer(),
                    SizedBox(
                      width: 125.w,
                      child: ElevatedButton(
                        onPressed: ovm.index != ovm.assets.length - 1
                            ? () => changePage(1)
                            : () async {
                                context.push("/home");
                              },
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        ),
                        child: Text(
                          ovm.index != ovm.assets.length - 1
                              ? "Sonraki"
                              : "Başla",
                          style: GoogleFonts.urbanist(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardDot extends StatelessWidget {
  final bool active;
  const OnboardDot({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.5.r,
      width: active ? 17.5.r : 7.5.r,
      decoration: active
          ? BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10.r),
            )
          : BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10.r),
            ),
    );
  }
}

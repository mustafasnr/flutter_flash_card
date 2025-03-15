import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leitner_app/edit_add/edit_add_view_model.dart';
import 'package:leitner_app/index/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, hvm, child) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kaldığın Yerden Devam Et",
                  style: GoogleFonts.urbanist(
                    fontSize: 24.sp,
                    color: Colors.black,
                    height: 30.h / 24.sp,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  padding: EdgeInsets.all(2.5.r),
                  icon: Icon(
                    Icons.menu_rounded,
                    color: Colors.black,
                    size: 28.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    1,
                    (index) {
                      return Container(
                        width: 150.w,
                        height: 125.w,
                        margin: EdgeInsets.only(right: index != 15 ? 8.w : 0),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Yakında",
                          style: GoogleFonts.urbanist(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                  if (6 <= 5)
                    Container(
                      width: 125.w,
                      height: 125.w,
                      margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Tümü",
                        style: GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 500.h,
              child: Wrap(
                children: [
                  InkWell(
                    onTap: () {
                      context.push("/boards");
                    },
                    overlayColor:
                        const WidgetStatePropertyAll(Colors.transparent),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.blue,
                      ),
                      margin: EdgeInsets.only(bottom: 5.h),
                      height: 245.h,
                      width: 200.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.work, size: 50.sp, color: Colors.black),
                          Text(
                            "Alıştırma Yap",
                            style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                    onTap: () async {
                      await context.read<EditAddViewModel>().initBoard(null);
                      if (context.mounted) {
                        context.push("/edit_add");
                      }
                    },
                    overlayColor:
                        const WidgetStatePropertyAll(Colors.transparent),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.green,
                      ),
                      margin: EdgeInsets.only(bottom: 5.h),
                      height: 245.h,
                      width: 200.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.dashboard_customize_rounded,
                              size: 50.sp, color: Colors.black),
                          Text(
                            "Pano Ekle",
                            style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.push("/settings");
                    },
                    overlayColor:
                        const WidgetStatePropertyAll(Colors.transparent),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.red,
                      ),
                      margin: EdgeInsets.only(top: 5.h),
                      height: 245.h,
                      width: 200.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.settings,
                              size: 50.sp, color: Colors.black),
                          Text(
                            "Ayarlar",
                            style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                    onTap: () {
                      return;
                    },
                    overlayColor:
                        const WidgetStatePropertyAll(Colors.transparent),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.yellow,
                      ),
                      margin: EdgeInsets.only(top: 5.h),
                      height: 245.h,
                      width: 200.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.history, size: 50.sp, color: Colors.black),
                          Text(
                            "Geçmiş\n(Yakında)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

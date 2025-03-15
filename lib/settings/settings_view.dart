import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leitner_app/components/app_bar_with_title.dart';
import 'package:leitner_app/settings/settings_view_model.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, svm, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(0, 50.h),
          child: const AppBarWithTitle(title: "Ayarlar"),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Karanlık Mod",
                      style: GoogleFonts.urbanist(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    DropdownButton<int>(
                      value: 0,
                      focusColor: Colors.transparent,
                      underline: const SizedBox.shrink(),
                      isDense: true,
                      menuWidth: 125.sp,
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 12.w),
                      borderRadius: BorderRadius.circular(8.r),
                      alignment: Alignment.bottomLeft,
                      style: Theme.of(context).dropdownMenuTheme.textStyle,
                      dropdownColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color.fromRGBO(54, 54, 54, 1)
                              : Colors.white,
                      onChanged: (value) {
                        debugPrint(value!.toString());
                      },
                      items: [
                        DropdownMenuItem<int>(
                          value: 0,
                          child: Text(
                            "Açık",
                            style: GoogleFonts.urbanist(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text(
                            "Koyu",
                            style: GoogleFonts.urbanist(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text(
                            "Sistem",
                            style: GoogleFonts.urbanist(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dil",
                      style: GoogleFonts.urbanist(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    DropdownButton<String>(
                      value: "en_EN",
                      focusColor: Colors.transparent,
                      underline: const SizedBox.shrink(),
                      isDense: true,
                      menuWidth: 125.sp,
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 12.w),
                      borderRadius: BorderRadius.circular(8.r),
                      alignment: Alignment.bottomLeft,
                      style: Theme.of(context).dropdownMenuTheme.textStyle,
                      dropdownColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color.fromRGBO(54, 54, 54, 1)
                              : Colors.white,
                      onChanged: (value) {
                        debugPrint(value!.toString());
                      },
                      items: [
                        DropdownMenuItem<String>(
                          value: "en_EN",
                          child: Text(
                            "English",
                            style: GoogleFonts.urbanist(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "tr_TR",
                          child: Text(
                            "Türkçe",
                            style: GoogleFonts.urbanist(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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

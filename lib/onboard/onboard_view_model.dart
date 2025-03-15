import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardViewModel extends ChangeNotifier {
  int index = 0;
  bool isTransitioning = false;
  void setTransition(bool val) {
    isTransitioning = val;
    notifyListeners();
  }

  var widgets = [
    [
      Text(
        "Başlık 1",
        style: GoogleFonts.urbanist(
            fontSize: 24.sp, color: Colors.black, fontWeight: FontWeight.w500),
      ),
      Text(
        "Açıklama 1",
        textAlign: TextAlign.center,
        style: GoogleFonts.urbanist(fontSize: 20.sp, color: Colors.black),
      )
    ],
    [
      Text(
        "Başlık 2",
        style: GoogleFonts.urbanist(
            fontSize: 24.sp, color: Colors.black, fontWeight: FontWeight.w500),
      ),
      Text(
        "Açıklama 2",
        textAlign: TextAlign.center,
        style: GoogleFonts.urbanist(fontSize: 20.sp, color: Colors.black),
      )
    ],
    [
      Text(
        "Başlık 3",
        style: GoogleFonts.urbanist(
            fontSize: 24.sp, color: Colors.black, fontWeight: FontWeight.w500),
      ),
      Text(
        "Açıklama 3",
        textAlign: TextAlign.center,
        style: GoogleFonts.urbanist(fontSize: 20.sp, color: Colors.black),
      )
    ],
  ];
  var assets = ["1", "2", "3"];

  void setIndex(int val) {
    index = val;
    notifyListeners();
  }
}

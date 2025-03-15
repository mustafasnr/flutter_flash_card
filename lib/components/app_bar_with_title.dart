import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leitner_app/components/pop_button.dart';

class AppBarWithTitle extends StatelessWidget {
  final String title;
  const AppBarWithTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.urbanist(
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      shadowColor: Colors.black.withValues(alpha: 1),
      leading: Row(
        children: [
          SizedBox(width: 10.w),
          const PopButton(),
        ],
      ),
      leadingWidth: 70.w,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      scrolledUnderElevation: 2.5,
      elevation: 2.5,
    );
  }
}
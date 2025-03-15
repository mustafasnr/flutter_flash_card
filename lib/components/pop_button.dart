import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PopButton extends StatelessWidget {
  const PopButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pop();
      },
      highlightColor: Colors.black.withValues(alpha: 0.15),
      icon: Icon(
        Icons.arrow_back_ios_new,
        size: 28.sp,
        color: Colors.black,
      ),
    );
  }
}

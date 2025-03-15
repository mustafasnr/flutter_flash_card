import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leitner_app/index/drawer_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexLayout extends StatelessWidget {
  const IndexLayout({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 16.h,
          ),
          child: navigationShell,
        ),
      ),
      drawer: const IndexDrawer(),
    );
  }
}

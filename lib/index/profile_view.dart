import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) => Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        width: 340.w,
                        height: 420.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.r),
                                  topRight: Radius.circular(8.r),
                                ),
                                color: Colors.white,
                              ),
                              width: double.infinity,
                              height: 340.h,
                            ),
                            Container(
                              height: 80.h,
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 8.h),
                                    decoration: BoxDecoration(
                                        color: Colors.white10,
                                        borderRadius:
                                            BorderRadius.circular(300.r)),
                                    child: GestureDetector(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image,
                                            size: 20.sp,
                                          ),
                                          Text(
                                            " Galeri",
                                            style: GoogleFonts.inter(
                                              fontSize: 14.sp,
                                              height: 1.5,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 32.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 8.h),
                                    decoration: BoxDecoration(
                                        color: Colors.white10,
                                        borderRadius:
                                            BorderRadius.circular(300.r)),
                                    child: GestureDetector(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.camera_alt,
                                            size: 20.sp,
                                          ),
                                          Text(
                                            " Kamera",
                                            style: GoogleFonts.inter(
                                              fontSize: 14.sp,
                                              height: 1.5,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 40.r,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ".${"Mustafa Söner"}",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "@${"username"}",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 64.h),
          const ProfileSettingComponent(
            title: "Kullanıcı Bilgileri",
            route: "/profile_settings",
          ),
          const ProfileSettingComponent(
            title: "Üyelik",
            route: "/membership",
          ),
        ],
      ),
    );
  }
}

class ProfileSettingComponent extends StatelessWidget {
  final String title;
  final String route;
  const ProfileSettingComponent({
    super.key,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: GestureDetector(
        onTap: () {
          // context.push( route);
          debugPrint("$route'a yönlendirildi");
        },
        //renk vermek yerine bunu yapmalıyım artık
        behavior: HitTestBehavior.opaque,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 20.sp,
            )
          ],
        ),
      ),
    );
  }
}

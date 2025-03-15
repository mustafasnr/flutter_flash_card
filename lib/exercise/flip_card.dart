import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leitner_app/hive_data/card_data.dart';

class ExerciseFlipCard extends StatelessWidget {
  const ExerciseFlipCard({
    super.key,
    required this.flipState,
    required this.cardData,
  });

  final GlobalKey<FlipCardState> flipState;
  final CardData cardData;

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      key: flipState,
      flipOnTouch: false,
      fill: Fill.fillFront,
      front: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.amber,
        ),
        alignment: Alignment.center,
        width: double.infinity,
        child: Text(
          cardData.front,
          style: GoogleFonts.urbanist(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 1.5,
          ),
        ),
      ),
      back: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.orange,
        ),
        alignment: AlignmentDirectional.center,
        width: double.infinity,
        child: Text(
          cardData.back,
          style: GoogleFonts.urbanist(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

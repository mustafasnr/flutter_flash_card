import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leitner_app/edit_add/edit_add_view_model.dart';
import 'package:provider/provider.dart';

class InputPair extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final int cardIndex;
  const InputPair({
    super.key,
    required this.cardIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<EditAddViewModel>(
      key: Key("ip_$cardIndex"),
      builder: (context, eavm, child) => Dismissible(
        key: Key(eavm.editedBoardData!.cards[cardIndex].id),
        onDismissed: (direction) {
          eavm.deleteCard(cardIndex);
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 16.w),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(Icons.delete_rounded, color: Colors.redAccent, size: 40.sp),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  initialValue: eavm.editedBoardData!.cards[cardIndex].front,
                  focusNode: cardIndex * 2 + 0 < eavm.focusNodes.length
                      ? eavm.focusNodes[cardIndex * 2 + 0]
                      : null,
                  onTap: () {
                    eavm.requestFocusNode(cardIndex * 2 + 0);
                  },
                  cursorColor: Colors.black,
                  cursorWidth: 1.sp,
                  cursorHeight: 20.sp,
                  cursorRadius: Radius.circular(1.sp),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: null,
                    hintStyle: GoogleFonts.inter(
                      fontSize: 20.sp,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Colors.blueAccent),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    eavm.setCardFront(cardIndex, value);
                  },
                  onEditingComplete: () {
                    eavm.requestFocusNode(cardIndex * 2 + 1);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  ":",
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: TextFormField(
                  initialValue: eavm.editedBoardData!.cards[cardIndex].back,
                  focusNode: cardIndex * 2 + 1 < eavm.focusNodes.length
                      ? eavm.focusNodes[cardIndex * 2 + 1]
                      : null,
                  onTap: () {
                    eavm.requestFocusNode(cardIndex * 2 + 1);
                  },
                  cursorColor: Colors.black,
                  cursorWidth: 1,
                  cursorHeight: 20.sp,
                  cursorRadius: Radius.circular(1.sp),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    isDense: true,
                    hintText: null,
                    hintStyle: GoogleFonts.inter(
                      fontSize: 20.sp,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: Colors.grey, width: 1.w),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1.w),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    eavm.setCardBack(cardIndex, value);
                  },
                  onEditingComplete: () {
                    context.read<EditAddViewModel>().editNextCard(cardIndex);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

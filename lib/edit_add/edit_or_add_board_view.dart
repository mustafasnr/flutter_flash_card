import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leitner_app/boards/boards_view_model.dart';
import 'package:leitner_app/edit_add/cancel_dialog.dart';
import 'package:leitner_app/edit_add/edit_add_view_model.dart';
import 'package:leitner_app/edit_add/input_pair.dart';
import 'package:provider/provider.dart';

class EditOrAddBoardView extends StatefulWidget {
  const EditOrAddBoardView({super.key});

  @override
  State<EditOrAddBoardView> createState() => _EditOrAddBoardViewState();
}

class _EditOrAddBoardViewState extends State<EditOrAddBoardView> {
  FocusNode fn = FocusNode();
  ScrollController sc = ScrollController();
  late EditAddViewModel _eavm;
  @override
  void dispose() {
    fn.dispose();
    sc.dispose();
    _eavm.disposeAllFocusNodes();
    _eavm.clearBoardData();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    debugPrint("Tetiklendik babba");
    fn.requestFocus();
    _eavm = context.read<EditAddViewModel>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditAddViewModel>(
      builder: (context, eavm, child) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (!didPop) {
            if (eavm.anyChange) {
              await showCancelDialog(context);
            } else {
              await eavm.cancelEdit();
              if (context.mounted) {
                context.pop();
              }
            }
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size(0, 50.h),
            child: AppBar(
              title: Text(
                "Ekle/Düzenle",
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
                  IconButton(
                    onPressed: () async {
                      if (eavm.anyChange) {
                        await showCancelDialog(context);
                      } else {
                        await eavm.cancelEdit();
                        if (context.mounted) {
                          context.pop();
                        }
                      }
                    },
                    highlightColor: Colors.black.withValues(alpha: 0.15),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 28.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              leadingWidth: 70.w,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              scrolledUnderElevation: 2.5,
              elevation: 2.5,
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Panoya Bir İsim Verin",
                    style: GoogleFonts.urbanist(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    initialValue: eavm.editedBoardData!.name,
                    focusNode: fn,
                    onChanged: (value) {
                      eavm.setBoardName(value);
                    },
                    onEditingComplete: () async {
                      eavm.editNextCard(-1);
                    },
                    decoration: InputDecoration(
                      hintText: "Pano adını girin...",
                      hintStyle: GoogleFonts.urbanist(color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 14.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    cursorColor: Colors.black,
                    style: GoogleFonts.urbanist(
                      fontSize: 20.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Panoya Veri Ekleyin",
                    style: GoogleFonts.urbanist(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      controller: sc,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...List.generate(
                            eavm.editedBoardData!.cards.length,
                            (index) => InputPair(
                              cardIndex: index,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            alignment: Alignment.center,
                            child: IconButton.filled(
                              onPressed: () {
                                eavm.addCard("", "");
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  sc.animateTo(
                                    sc.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                });
                              },
                              highlightColor:
                                  Colors.white.withValues(alpha: 0.15),
                              style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.indigoAccent),
                              ),
                              padding: EdgeInsets.all(12.5.r),
                              icon: Icon(
                                Icons.add,
                                size: 32.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            debugPrint("İptal Etme Tetiklendi");
                            context.pop();
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r)),
                            side: BorderSide(
                              color: Colors.redAccent,
                              width: 1.5.w,
                            ),
                          ),
                          child: Text(
                            "İptal Et",
                            style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: eavm.isBoardValid
                              ? () {
                                  eavm.saveBoard();
                                  context
                                      .read<BoardsViewModel>()
                                      .updateBoards();
                                  context.pop();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor:
                                Colors.blueAccent.withValues(alpha: 0.5),
                            elevation: 0.5,
                            backgroundColor: Colors.blueAccent,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            "Onayla",
                            style: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:leitner_app/boards/boards_view_model.dart';
import 'package:leitner_app/edit_add/edit_add_view_model.dart';
import 'package:leitner_app/exercise/e_game_view_model.dart';
import 'package:leitner_app/exercise/e_main_view_model.dart';
import 'package:leitner_app/hive_boxes.dart';
import 'package:leitner_app/hive_data/board_data.dart';
import 'package:leitner_app/hive_data/card_data.dart';
import 'package:leitner_app/hive_data/history_data.dart';
import 'package:leitner_app/index/home_view_model.dart';
import 'package:leitner_app/onboard/onboard_view_model.dart';
import 'package:leitner_app/router.dart';
import 'package:leitner_app/settings/settings_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  await Hive.initFlutter();
  Hive.registerAdapter(CardDataAdapter());
  Hive.registerAdapter(HistoryDataAdapter());
  Hive.registerAdapter(BoardDataAdapter());
  boardBox = await Hive.openBox<BoardData>('boards');
  historyBox = await Hive.openBox<HistoryData>('histories');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    debugPrint("asdasdsasda");
    _closeHive();
    super.dispose();
  }

  void _closeHive() async {
    await Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (c) => OnboardViewModel()),
            ChangeNotifierProvider(create: (c) => SettingsViewModel()),
            ChangeNotifierProvider(create: (c) => BoardsViewModel()),
            ChangeNotifierProvider(create: (c) => EditAddViewModel()),
            ChangeNotifierProvider(create: (c) => HomeViewModel()),
            ChangeNotifierProvider(create: (c) => ExerciseGameViewModel()),
            ChangeNotifierProvider(create: (c) => ExerciseMainViewModel()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          ),
        );
      },
    );
  }
}

import 'package:go_router/go_router.dart';
import 'package:leitner_app/boards/boards_view.dart';
import 'package:leitner_app/edit_add/edit_or_add_board_view.dart';
import 'package:leitner_app/exercise/exercise_game_view.dart';
import 'package:leitner_app/exercise/exercise_main_view.dart';
import 'package:leitner_app/history/history_view.dart';
import 'package:leitner_app/index/home_view.dart';
import 'package:leitner_app/index/index_layout.dart';
import 'package:leitner_app/onboard/onboard_view.dart';
import 'package:leitner_app/settings/settings_view.dart';

final GoRouter router = GoRouter(
  initialLocation: "/onboard",
  routes: [
    GoRoute(
      path: "/onboard",
      builder: (context, state) => const OnboardView(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return IndexLayout(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/home",
              builder: (context, state) => const HomeView(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: "/history",
      builder: (context, state) => const HistoryView(),
    ),
    GoRoute(
      path: "/boards",
      builder: (context, state) => const BoardsView(),
    ),
    GoRoute(
      path: "/settings",
      builder: (context, state) => const SettingsView(),
    ),
    GoRoute(
      path: "/edit_add",
      builder: (context, state) => const EditOrAddBoardView(),
    ),
    GoRoute(
      path: "/exercise_main",
      builder: (context, state) => const ExerciseMainView(),
    ),
    GoRoute(
      path: "/exercise_game",
      builder: (context, state) => const ExerciseGameView(),
    ),
  ],
);

import 'package:bsl_support/src/features/football_live/presentation/football_live_screen.dart';
import 'package:bsl_support/src/features/live_sport/presentation/live_sport_screen.dart';
import 'package:bsl_support/src/routes/app_startup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'scaffold_with_nested_navigation.dart';

part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _liveSportApiNavigatorKey = GlobalKey<NavigatorState>();
final _footballLiveApiNavigatorKey = GlobalKey<NavigatorState>();
final _settingsNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  liveSportApi,
  footballLiveApi,
  settings,
}

@riverpod
GoRouter goRouter(Ref ref) {
  // rebuild GoRouter when app startup state changes
  final appStartupState = ref.watch(appStartupProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: !kReleaseMode,
    redirect: (context, state) {
      // If the app is still initializing, show the /startup route
      if (appStartupState.isLoading || appStartupState.hasError) {
        return '/startup';
      }

      final path = state.uri.path;
      if (path.startsWith('/startup')) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/startup',
        pageBuilder: (context, state) => NoTransitionPage(
          child: AppStartupWidget(
            // * This is just a placeholder
            // * The loaded route will be managed by GoRouter on state change
            onLoaded: (_) => const SizedBox.shrink(),
          ),
        ),
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) => NoTransitionPage(
          child: ScaffoldWithNestedNavigation(navigationShell: navigationShell),
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _liveSportApiNavigatorKey,
            routes: [
              GoRoute(
                path: '/',
                name: AppRoute.liveSportApi.name,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: LiveSportScreen(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _footballLiveApiNavigatorKey,
            routes: [
              GoRoute(
                path: '/football-live-api',
                name: AppRoute.footballLiveApi.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: FootballLiveScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsNavigatorKey,
            routes: [
              GoRoute(
                path: '/settings',
                name: AppRoute.settings.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text("Settings"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

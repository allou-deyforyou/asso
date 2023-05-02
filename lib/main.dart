import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'screen/_screen.dart';

void main() => runService(const MyService()).whenComplete(() => runApp(const MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Customer
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    /// Customer
    _router = GoRouter(
      debugLogDiagnostics: kDebugMode,
      routes: [
        GoRoute(
          path: HomeScreen.path,
          name: HomeScreen.name,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: CustomKeepAlive(
                child: HomeScreen(),
              ),
            );
          },
          routes: [
            GoRoute(
              path: LocationSearchScreen.path,
              name: LocationSearchScreen.name,
              pageBuilder: (context, state) {
                return const CupertinoPage(
                  fullscreenDialog: true,
                  child: CustomKeepAlive(
                    child: LocationSearchScreen(),
                  ),
                );
              },
            ),
            GoRoute(
              path: TripContentScreen.path,
              name: TripContentScreen.name,
              pageBuilder: (context, state) {
                return const CupertinoPage(
                  child: CustomKeepAlive(
                    child: TripContentScreen(),
                  ),
                );
              },
            ),
            GoRoute(
              path: TripMapScreen.path,
              name: TripMapScreen.name,
              pageBuilder: (context, state) {
                return const CupertinoPage(
                  child: CustomKeepAlive(
                    child: TripMapScreen(),
                  ),
                );
              },
            ),
            GoRoute(
              path: TripRegisterScreen.path,
              name: TripRegisterScreen.name,
              pageBuilder: (context, state) {
                return const CupertinoPage(
                  child: CustomKeepAlive(
                    child: TripRegisterScreen(),
                  ),
                );
              },
            ),
            GoRoute(
              path: SettingsScreen.path,
              name: SettingsScreen.name,
              pageBuilder: (context, state) {
                return const CupertinoPage(
                  child: CustomKeepAlive(
                    child: SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Asso',
      theme: Themes.theme,
      routerConfig: _router,
      themeMode: ThemeMode.light,
      darkTheme: Themes.darkTheme,
      color: Themes.primaryColor,
      debugShowCheckedModeBanner: false,
      scrollBehavior: const CustomScrollBehavior(),
      supportedLocales: CustomBuildContext.supportedLocales,
      localizationsDelegates: CustomBuildContext.localizationsDelegates,
    );
  }
}

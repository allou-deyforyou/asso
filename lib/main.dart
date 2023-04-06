import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'screen/_screen.dart';

void main() async {
  runService();
  runApp(const MyApp());
}

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
              path: TravelMapScreen.path,
              name: TravelMapScreen.name,
              pageBuilder: (context, state) {
                return const CupertinoPage(
                  child: CustomKeepAlive(
                    child: TravelMapScreen(),
                  ),
                );
              },
            ),
            GoRoute(
              path: TravelRegisterScreen.path,
              name: TravelRegisterScreen.name,
              pageBuilder: (context, state) {
                return const CupertinoPage(
                  fullscreenDialog: true,
                  child: CustomKeepAlive(
                    child: TravelRegisterScreen(),
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
      themeMode: ThemeMode.light,
      darkTheme: Themes.darkTheme,
      color: Themes.primaryColor,
      debugShowCheckedModeBanner: false,
      routerDelegate: _router.routerDelegate,
      scrollBehavior: const CustomScrollBehavior(),
      supportedLocales: CustomBuildContext.supportedLocales,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      localizationsDelegates: CustomBuildContext.localizationsDelegates,
    );
  }
}

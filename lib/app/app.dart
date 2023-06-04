import 'package:flutter/material.dart';

import 'app_router.dart';

class App extends StatelessWidget {
  final AppRouter router;
  final GlobalKey<NavigatorState> navKey;

  const App({super.key, required this.router, required this.navKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: router.onGenerateRoute);
  }
}

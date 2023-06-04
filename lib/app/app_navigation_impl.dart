import 'package:domain/app/app_navigation.dart';
import 'package:domain/app/app_page.dart';
import 'package:flutter/material.dart';

class AppNavigationImpl extends AppNavigation {
  final GlobalKey<NavigatorState> navKey;

  AppNavigationImpl(this.navKey);

  @override
  void back() {
    navKey.currentState?.pop();
  }

  @override
  void navigate(AppPage page, {Map<String, dynamic>? args}) {
    navKey.currentState?.pushNamed(page.path, arguments: args);
  }
}

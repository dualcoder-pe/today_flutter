import 'package:domain/app/app_page.dart';
import 'package:domain/service/navigation_service.dart';
import 'package:flutter/material.dart';

class NavigationServiceImpl extends NavigationService {
  final GlobalKey<NavigatorState> navKey;

  NavigationServiceImpl(this.navKey);

  @override
  void back() {
    navKey.currentState?.pop();
  }

  @override
  void navigate(AppPage page, {Map<String, dynamic>? args}) {
    navKey.currentState?.pushNamed(page.path, arguments: args);
  }
}

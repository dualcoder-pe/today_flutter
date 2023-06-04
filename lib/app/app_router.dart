import 'package:common/utils/logger.dart';
import 'package:domain/app/app_page.dart';
import 'package:flutter/material.dart';
import 'package:presentation/home/home_page.dart';
import 'package:presentation/login/login_page.dart';
import 'package:presentation/posts/list/posts_list_page.dart';
import 'package:presentation/posts/write/posts_write_page.dart';
import 'package:presentation/posts/read/posts_read_page.dart';
import 'package:presentation/register/register_page.dart';

class AppRouter {
  String? prevPath;

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    logger("Route $prevPath => ${settings.name}");
    prevPath = settings.name;

    final page;
    if (settings.name?.startsWith(AppPage.login.path) == true) {
      page = const LoginPage();
    } else if (settings.name?.startsWith(AppPage.register.path) == true) {
      page = const RegisterPage();
    } else if (settings.name?.startsWith(AppPage.postsList.path) == true) {
      page = const PostsListPage();
    } else if (settings.name?.startsWith(AppPage.postsWrite.path) == true) {
      page = PostsWritePage();
    } else if (settings.name?.startsWith(AppPage.postsRead.path) == true) {
      final id = (settings.arguments as AppPageArguments)["id"] as String;
      page = PostsReadPage(id);
    // } else if (settings.name?.startsWith(AppPage.postsModify.path) == true) {
    //   page = PostsWritePage();
    } else {
      page = const HomePage();
    }

    return MaterialPageRoute<void>(builder: (_) => page, settings: settings);
  }
}

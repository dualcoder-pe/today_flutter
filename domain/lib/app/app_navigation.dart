import 'app_page.dart';

abstract class AppNavigation {
  void back();

  void navigate(AppPage page, {Map<String, dynamic>? args});
}

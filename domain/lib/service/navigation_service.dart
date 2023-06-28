import '../app/app_page.dart';

abstract class NavigationService {
  void back();

  void navigate(AppPage page, {Map<String, dynamic>? args});
}

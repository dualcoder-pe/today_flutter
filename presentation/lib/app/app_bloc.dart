import 'package:domain/app/app_navigation.dart';
import 'package:domain/app/app_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_state.dart';

class AppBloc extends Cubit<AppState> {
  final AppNavigation _appNavigation;
  AppBloc(super.initialState, this._appNavigation);

  void navigate(AppPage page) => _appNavigation.navigate(page);

  void back() => _appNavigation.back();
}

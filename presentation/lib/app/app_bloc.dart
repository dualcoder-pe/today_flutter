import 'package:domain/service/navigation_service.dart';
import 'package:domain/app/app_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_state.dart';

class AppBloc extends Cubit<AppState> {
  final NavigationService _navigationService;
  AppBloc(super.initialState, this._navigationService);

  void navigate(AppPage page) => _navigationService.navigate(page);

  void back() => _navigationService.back();
}

import 'package:common/utils/logger.dart';
import 'package:domain/app/app_navigation.dart';
import 'package:domain/app/app_page.dart';
import 'package:domain/use_case/auth_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/login/login_event.dart';
import 'package:presentation/login/login_state.dart';

import '../base/base_bloc.dart';
import '../login/login_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  final AuthUseCase _authUseCase;
  final AppNavigation _appNavigation;

  final LoginBloc _loginBloc;

  RegisterBloc(super.initialState, this._authUseCase, this._appNavigation, this._loginBloc) {
    on<RequestRegisterEvent>(_onRegister);
  }

  void _onRegister(RequestRegisterEvent event, Emitter<RegisterState> emit) async {
    if (event.username.isEmpty) {
      emit(RegisterFailureState("Input Username"));
    } else if (event.password.isEmpty) {
      emit(RegisterFailureState("Input Password"));
    } else {
      emit(RequestRegisterState());
      try {
        final userInfo = await _authUseCase.register(event.username, event.password);
        logger("Success to Register $userInfo");
        _loginBloc.add(AutoLoginEvent(userInfo));
        emit(InitRegisterState());
        _appNavigation.navigate(AppPage.home);
      } catch (e) {
        logger(e.toString());
        emit(RegisterFailureState("Failed to Login"));
      }
    }
  }
}

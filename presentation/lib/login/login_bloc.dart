import 'package:common/utils/logger.dart';
import 'package:domain/app/app_page.dart';
import 'package:domain/service/navigation_service.dart';
import 'package:domain/use_case/auth_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/login/login_state.dart';

import '../base/base_bloc.dart';
import 'login_event.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  final AuthUseCase _authUseCase;
  final NavigationService _navigationService;

  bool get isLoggedIn => state is LoginSuccessState;

  LoginBloc(super.initialState, this._authUseCase, this._navigationService) {
    on<RequestLoginEvent>(_onLogin);
    on<RequestLogoutEvent>(_onLogout);
    on<RequestSignUpEvent>(_onSignUp);
    on<RequestForgotPasswordEvent>(_onForgotPassword);
    on<AutoLoginEvent>(_onAutoLogin);
  }

  void _onLogin(RequestLoginEvent event, Emitter<LoginState> emit) async {
    if (event.id.isEmpty) {
      emit(LoginFailureState("Input Username"));
    } else if (event.pwd.isEmpty) {
      emit(LoginFailureState("Input Password"));
    } else {
      try {
        final userInfo = await _authUseCase.login(event.id, event.pwd);
        emit(LoginSuccessState(userInfo));
        _navigationService.navigate(AppPage.home);
      } catch (e) {
        logger(e.toString());
        emit(LoginFailureState("Failed to Login"));
      }
    }
  }

  void _onLogout(RequestLogoutEvent event, Emitter<LoginState> emit) {
    emit(InitLoginState());
  }

  void _onSignUp(RequestSignUpEvent event, Emitter<LoginState> emit) {
    _navigationService.navigate(AppPage.register);
  }

  void _onForgotPassword(RequestForgotPasswordEvent event, Emitter<LoginState> emit) {}

  void _onAutoLogin(AutoLoginEvent event, Emitter<LoginState> emit) {
    emit(LoginSuccessState(event.userInfo));
  }
}

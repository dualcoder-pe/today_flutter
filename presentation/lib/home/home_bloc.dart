import 'package:flutter_bloc/flutter_bloc.dart';

import '../base/base_bloc.dart';
import '../login/login_bloc.dart';
import '../login/login_state.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final LoginBloc loginBloc;

  HomeBloc(super.initialState, this.loginBloc) {
    on<CountUpHomeEvent>(_onCountUp);
    on<ChangeLoginStateInHomeEvent>(_onLogin);

    loginBloc.stream.listen(_listenLoginState);
  }

  void _listenLoginState(LoginState loginState) {
    if (loginState is LoginSuccessState) {
      add(const ChangeLoginStateInHomeEvent(true));
    } else {
      add(const ChangeLoginStateInHomeEvent(false));
    }
  }

  void _onCountUp(CountUpHomeEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(count: state.count + 1));
  }

  void _onLogin(ChangeLoginStateInHomeEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(isLoggedIn: event.isLoggedIn));
  }
}

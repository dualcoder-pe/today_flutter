import 'package:entity/auth/user_vo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../base/base_state.dart';

part 'login_state.freezed.dart';

class LoginState extends BaseState {}

class InitLoginState extends LoginState {}

@freezed
class LoginSuccessState extends LoginState with _$LoginSuccessState {
  factory LoginSuccessState(UserVO userInfo) = _LoginSuccessState;

  @override
  factory LoginSuccessState.init() {
    return _LoginSuccessState(UserVO.empty());
  }
}

@freezed
class LoginFailureState extends LoginState with _$LoginFailureState {
  factory LoginFailureState(String errorMsg) = _LoginFailureState;

  @override
  factory LoginFailureState.init() {
    return _LoginFailureState("");
  }
}

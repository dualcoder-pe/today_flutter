import 'package:freezed_annotation/freezed_annotation.dart';

import '../base/base_state.dart';

part 'register_state.freezed.dart';

class RegisterState extends BaseState {}

class InitRegisterState extends RegisterState {}

class RequestRegisterState extends RegisterState {}

@freezed
class RegisterFailureState extends RegisterState with _$RegisterFailureState {
  factory RegisterFailureState(String errorMsg) = _RegisterFailureState;

  @override
  factory RegisterFailureState.init() {
    return _RegisterFailureState("");
  }
}

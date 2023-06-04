
import 'package:entity/auth/user_vo.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class RequestLoginEvent extends LoginEvent {
  final String id;
  final String pwd;

  const RequestLoginEvent(this.id, this.pwd);

  @override
  List<Object?> get props => [id, pwd];
}

class AutoLoginEvent extends LoginEvent {
  final UserVO userInfo;

  const AutoLoginEvent(this.userInfo);
}

class RequestLogoutEvent extends LoginEvent {}

class RequestSignUpEvent extends LoginEvent {}

class RequestForgotPasswordEvent extends LoginEvent {}

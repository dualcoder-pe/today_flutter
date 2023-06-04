
import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RequestRegisterEvent extends RegisterEvent {
  final String username;
  final String password;

  const RequestRegisterEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}
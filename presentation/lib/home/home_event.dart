
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class CountUpHomeEvent extends HomeEvent {}

class ChangeLoginStateInHomeEvent extends HomeEvent {
  final bool isLoggedIn;

  const ChangeLoginStateInHomeEvent(this.isLoggedIn);

  @override
  List<Object?> get props => [isLoggedIn];
}
import '../base/base_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState extends BaseState with _$HomeState {
  factory HomeState(int count, bool isLoggedIn) = _HomeState;

  @override
  factory HomeState.init() {
    return _HomeState(0, false);
  }
}
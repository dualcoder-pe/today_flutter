
import 'package:equatable/equatable.dart';

class UserVO extends Equatable {
  final String id;
  final String username;

  UserVO(this.id, this.username);

  @override
  List<Object?> get props => [id, username];

  factory UserVO.empty() => UserVO("", "");

  @override
  String toString() => "$id, $username";
}


import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_vo.freezed.dart';

@freezed
class UserVO with _$UserVO {
  factory UserVO(String id, String username) = _UserVO;

  factory UserVO.empty() => UserVO("", "");

  @override
  String toString() => "$id, $username";
}

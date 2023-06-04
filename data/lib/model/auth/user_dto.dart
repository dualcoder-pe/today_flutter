import 'package:entity/auth/user_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String id;
  final String username;

  UserDto(this.id, this.username);

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  @override
  String toString() => "$id, $username";
}

extension UserDtoExt on UserDto {
  UserVO toVO() {
    return UserVO(id, username);
  }
}

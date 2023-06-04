import 'package:entity/auth/user_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDto {
  final String id;
  final String username;

  LoginResponseDto(this.id, this.username);

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) => _$LoginResponseDtoFromJson(json);
}

extension LoginResponseDtoExt on LoginResponseDto {
  UserVO toUserInfo() {
    return UserVO(id, username);
  }
}
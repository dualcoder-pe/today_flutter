import 'package:json_annotation/json_annotation.dart';

import 'package:domain/data/model/login_request_vo.dart';

part 'login_request_dto.g.dart';

@JsonSerializable()
class LoginRequestDto {
  final String username;
  final String password;

  LoginRequestDto(this.username, this.password);

  Map<String, dynamic> toJson() => _$LoginRequestDtoToJson(this);

  factory LoginRequestDto.fromVO(LoginRequestVO vo) => LoginRequestDto(vo.username, vo.password);

}

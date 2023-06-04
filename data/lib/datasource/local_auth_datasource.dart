import '../model/auth/req/login_request_dto.dart';
import '../model/auth/res/login_response_dto.dart';

class LocalAuthDatasource {
  Future<LoginResponseDto> login(LoginRequestDto req) =>
      Future.value(LoginResponseDto("645e2b880bf27a0dca845767", "username"));
}

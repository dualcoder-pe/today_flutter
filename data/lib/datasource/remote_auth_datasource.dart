import '../model/auth/req/login_request_dto.dart';
import '../model/auth/res/login_response_dto.dart';
import 'api/api.dart';

class RemoteAuthDatasource {
  final Api api;

  RemoteAuthDatasource(this.api);

  Future<LoginResponseDto> register(LoginRequestDto req) => api.register(req.toJson());

  Future<LoginResponseDto> login(LoginRequestDto req) => api.login(req.toJson());

  Future<LoginResponseDto> check() => api.check();

  Future<void> logout() => api.logout();
}

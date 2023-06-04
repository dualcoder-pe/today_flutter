import 'package:data/model/auth/res/login_response_dto.dart';
import 'package:domain/data/repository/auth_repository.dart';
import 'package:entity/auth/user_vo.dart';

import '../datasource/local_auth_datasource.dart';
import '../datasource/remote_auth_datasource.dart';
import '../model/auth/req/login_request_dto.dart';

class AuthRepositoryImpl extends AuthRepository {
  final RemoteAuthDatasource remoteAuthDatasource;
  final LocalAuthDatasource localAuthDatasource;

  AuthRepositoryImpl(this.remoteAuthDatasource, this.localAuthDatasource);

  @override
  Future<UserVO> register(String username, String password) {
    return remoteAuthDatasource.register(LoginRequestDto(username, password)).then((value) async {
      // final res = await remoteAuthDatasource.check();
      return value.toUserInfo();
    });
  }

  @override
  Future<UserVO> login(String username, String password) {
    return remoteAuthDatasource.login(LoginRequestDto(username, password)).then((value) async {
      // final res = await remoteAuthDatasource.check();
      return value.toUserInfo();
    });
    // return localAuthDatasource.login(LoginRequestDto(username, password)).then((value) => value.userInfoDto.toVO());
  }

  @override
  Future<UserVO> check() {
    return remoteAuthDatasource.check().then((value) => value.toUserInfo());
  }

  @override
  Future<void> logout() {
    return remoteAuthDatasource.logout();
  }
}

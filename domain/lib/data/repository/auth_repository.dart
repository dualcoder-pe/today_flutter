import 'package:entity/auth/user_vo.dart';

abstract class AuthRepository {
  Future<UserVO> register(String username, String password);
  Future<UserVO> login(String username, String password);
  Future<UserVO> check();
  Future<void> logout();
}

import 'package:domain/data/repository/auth_repository.dart';
import 'package:domain/use_case/base/BaseUseCase.dart';
import 'package:entity/auth/user_vo.dart';

class AuthUseCase extends BaseUseCase {
  final AuthRepository authRepository;

  AuthUseCase(this.authRepository);

  Future<UserVO> register(String username, String password) =>
      authRepository.register(username, password).then((value) {
        return value;
      });

  Future<UserVO> login(String username, String password) => authRepository.login(username, password);

  Future<void> logout() => authRepository.logout();
}

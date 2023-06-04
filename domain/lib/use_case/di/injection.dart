import 'package:common/container/di_container.dart';
import 'package:domain/data/repository/auth_repository.dart';
import 'package:domain/service/device_info_service.dart';
import 'package:domain/use_case/home_use_case.dart';
import 'package:domain/use_case/auth_use_case.dart';
import 'package:domain/use_case/settings_use_case.dart';

void domainInjection(DIContainer container) {
  container.registerLazySingleton<HomeUseCase>(() => HomeUseCase());
  container.registerLazySingleton<AuthUseCase>(() => AuthUseCase(container.get<AuthRepository>()));
  container.registerLazySingleton<SettingsUseCase>(() => SettingsUseCase(container.get<DeviceInfoService>()));
}

import 'package:common/container/di_container.dart';
import 'package:domain/service/device_info_service.dart';
import 'package:service/device_info_service_impl.dart';

void serviceInjection(DIContainer container) {
  container.registerLazySingleton<DeviceInfoService>(() => DeviceInfoServiceImpl());
}

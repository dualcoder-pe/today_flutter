
import 'package:domain/service/device_info_service.dart';
import 'package:domain/use_case/base/BaseUseCase.dart';

class SettingsUseCase extends BaseUseCase {
  final DeviceInfoService deviceInfoService;

  SettingsUseCase(this.deviceInfoService);

  String getPlatform() {
    return deviceInfoService.getPlatform();
  }

  String getPlatformVersion() {
    return deviceInfoService.getPlatformVersion();
  }
}
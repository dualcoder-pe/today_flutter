
import 'dart:io';

import 'package:domain/service/device_info_service.dart';

class DeviceInfoServiceImpl extends DeviceInfoService {
  @override
  String getPlatform() => Platform.operatingSystem;

  @override
  String getPlatformVersion() => Platform.operatingSystemVersion;

}
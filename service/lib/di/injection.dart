import 'package:common/container/di_container.dart';
import 'package:domain/service/device_info_service.dart';
import 'package:domain/service/navigation_service.dart';
import 'package:flutter/material.dart';
import '../device_info_service_impl.dart';
import '../navigation_service_impl.dart';

void serviceInjection(DIContainer container) {
  container.registerLazySingleton<DeviceInfoService>(() => DeviceInfoServiceImpl());
  container.registerLazySingleton<NavigationService>(() => NavigationServiceImpl(container.get<GlobalKey<NavigatorState>>()));
}

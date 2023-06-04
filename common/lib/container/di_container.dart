import 'package:get_it/get_it.dart';

class DIContainer {
  static final _instance = GetIt.I;

  static get I => _instance;

  T get<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  }) =>
      _instance.get(instanceName: instanceName, param1: param1, param2: param2);

  void registerLazySingleton<T extends Object>(FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) =>
      _instance.registerLazySingleton<T>(
          factoryFunc, instanceName: instanceName, dispose: dispose);

}
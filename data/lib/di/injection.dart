import 'package:common/container/di_container.dart';
import 'package:data/datasource/client/logger_interceptor.dart';
import 'package:data/datasource/local_post_datasource.dart';
import 'package:data/datasource/remote_post_datasource.dart';
import 'package:data/repository/post_repository_impl.dart';
import 'package:domain/data/repository/auth_repository.dart';
import 'package:domain/data/repository/post_repository.dart';

import '../datasource/api/api.dart';
import '../datasource/client/dio_client.dart';
import '../datasource/local_auth_datasource.dart';
import '../datasource/remote_auth_datasource.dart';
import '../repository/auth_repository_impl.dart';

void dataInjection(DIContainer container) async {
  container.registerLazySingleton<HttpClient>(() {
    return HttpClient.Builder.setInterceptor(LoggerInterceptor()).build();
  });
  container.registerLazySingleton<Api>(() => Api(container.get<HttpClient>().dio));

  container.registerLazySingleton<LocalAuthDatasource>(() => LocalAuthDatasource());
  container.registerLazySingleton<RemoteAuthDatasource>(() => RemoteAuthDatasource(container.get<Api>()));
  container.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(container.get<RemoteAuthDatasource>(), container.get<LocalAuthDatasource>()));

  container.registerLazySingleton<LocalPostDatasource>(() => LocalPostDatasource());
  container.registerLazySingleton<RemotePostDatasource>(() => RemotePostDatasource(container.get<Api>()));
  container.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(container.get<LocalPostDatasource>(), container.get<RemotePostDatasource>()));
}

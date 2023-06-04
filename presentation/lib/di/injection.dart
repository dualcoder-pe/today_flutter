import 'package:common/container/di_container.dart';
import 'package:domain/app/app_navigation.dart';
import 'package:domain/data/repository/post_repository.dart';
import 'package:domain/use_case/auth_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/login/login_bloc.dart';
import 'package:presentation/login/login_state.dart';
import 'package:presentation/posts/list/posts_list_bloc.dart';
import 'package:presentation/posts/list/posts_list_state.dart';
import 'package:presentation/posts/read/posts_read_bloc.dart';
import 'package:presentation/posts/read/posts_read_state.dart';
import 'package:presentation/posts/write/posts_write_state.dart';
import 'package:presentation/register/register_bloc.dart';
import 'package:presentation/register/register_state.dart';

import '../home/home_bloc.dart';
import '../home/home_state.dart';
import '../posts/write/posts_write_bloc.dart';

void presentationInjection(DIContainer container) {
  container.registerLazySingleton<LoginBloc>(
      () => LoginBloc(InitLoginState(), container.get<AuthUseCase>(), container.get<AppNavigation>()));

  container.registerLazySingleton<HomeBloc>(() => HomeBloc(HomeState.init(), container.get<LoginBloc>()));

  container.registerLazySingleton<RegisterBloc>(() => RegisterBloc(
      InitRegisterState(), container.get<AuthUseCase>(), container.get<AppNavigation>(), container.get<LoginBloc>()));

  container.registerLazySingleton<PostsListBloc>(() => PostsListBloc(InitPostsListState(),
      container.get<PostRepository>(), container.get<LoginBloc>(), container.get<AppNavigation>()));

  container.registerLazySingleton<PostsWriteBloc>(() =>
      PostsWriteBloc(InitPostsWriteState.init(), container.get<PostRepository>(), container.get<AppNavigation>()));

  container.registerLazySingleton<PostsReadBloc>(() => PostsReadBloc(InitPostsReadState(),
      container.get<PostRepository>(), container.get<AppNavigation>(), container.get<LoginBloc>()));

  container.registerLazySingleton<List<BlocProvider>>(() => [
        BlocProvider<HomeBloc>(
          create: (_) => container.get<HomeBloc>(),
        ),
        BlocProvider<LoginBloc>(
          create: (_) => container.get<LoginBloc>(),
        ),
        BlocProvider<RegisterBloc>(
          create: (_) => container.get<RegisterBloc>(),
        ),
        BlocProvider<PostsListBloc>(
          create: (_) => container.get<PostsListBloc>(),
        ),
        BlocProvider<PostsWriteBloc>(
          create: (_) => container.get<PostsWriteBloc>(),
        ),
        BlocProvider<PostsReadBloc>(
          create: (_) => container.get<PostsReadBloc>(),
        ),
        // BlocProvider<PostsMo>(
        //   create: (_) => container.get<PostsWriteBloc>(),
        // ),
      ]);
}

import 'package:common/container/di_container.dart';
import 'package:data/di/injection.dart';
import 'package:domain/service/navigation_service.dart';
import 'package:domain/use_case/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/app/app_state.dart';
import 'package:presentation/di/injection.dart';
import 'package:service/di/injection.dart';

import 'app/app.dart';
import 'app/app_router.dart';

class CompositionRoot {
  static final DIContainer container = DIContainer();

  static MultiBlocProvider app() {
    inject();

    container.registerLazySingleton<AppRouter>(() => AppRouter());
    container.registerLazySingleton<GlobalKey<NavigatorState>>(() => const GlobalObjectKey<NavigatorState>(0));

    return MultiBlocProvider(
        providers: container.get<List<BlocProvider>>()
          ..add(BlocProvider<AppBloc>(create: (_) => AppBloc(AppState(), container.get<NavigationService>()))),
        child: App(
          router: container.get<AppRouter>(),
          navKey: container.get<GlobalKey<NavigatorState>>(),
        ));
  }

  static void inject() {
    domainInjection(container);
    dataInjection(container);
    serviceInjection(container);
    presentationInjection(container);
  }
}

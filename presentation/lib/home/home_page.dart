import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/common/app_drawer.dart';
import 'package:presentation/home/home_event.dart';

import '../base/base_page.dart';
import 'home_bloc.dart';
import 'home_state.dart';

class HomePage extends BasePage {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      final title = state.isLoggedIn ? "Today Flutter (Logged in)" : "Today Flutter";
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        drawer: AppDrawer(context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '${state.count}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<HomeBloc>().add(CountUpHomeEvent()),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
}

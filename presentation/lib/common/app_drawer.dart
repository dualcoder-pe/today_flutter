import 'package:common/utils/logger.dart';
import 'package:domain/app/app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/login/login_bloc.dart';

import '../app/app_bloc.dart';
import '../login/login_event.dart';
import '../login/login_state.dart';

Drawer AppDrawer(BuildContext context) {
  return Drawer(
    // backgroundColor: Colors.white,
    child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final username = state is LoginSuccessState ? state.userInfo.username : "Please Login";
        final loginText = state is LoginSuccessState ? "Logout" : "Login";
        return ListView(
          children: [
            SizedBox(
              height: 80,
              child: UserAccountsDrawerHeader(
                // currentAccountPicture: const Icon(Icons.account_circle),
                accountName: Text(username),
                accountEmail: const SizedBox(),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20.0))),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text("Post"),
              onTap: () {
                logger("Tab post");
                context.read<AppBloc>().navigate(AppPage.postsList);
              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: Text(loginText),
              onTap: () {
                logger("Tab Login");
                if (state is LoginSuccessState) {
                  context.read<LoginBloc>().add(RequestLogoutEvent());
                  context.read<AppBloc>().back();
                } else {
                  context.read<AppBloc>().navigate(AppPage.login);
                }
              },
            ),
          ],
        );
      },
    ),
  );
}

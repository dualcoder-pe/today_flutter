import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/register/register_event.dart';

import '../base/base_page.dart';
import '../common/icons.dart';
import 'register_bloc.dart';
import 'register_state.dart';

class RegisterPage extends BasePage {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) => Scaffold(
              appBar: AppBar(title: const Text("Register")),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    registerForm(context.read<RegisterBloc>())
                  ],
                ),
              ),
            ));
  }
}

Widget registerForm(RegisterBloc registerBloc) {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  return Form(
      key: formKey,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: usernameController,
                autofocus: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Username",
                  suffix: usernameController.text.isNotEmpty ? TextClearSuffixIcon(usernameController) : null,
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Password",
                  suffix: passwordController.text.isNotEmpty ? TextClearSuffixIcon(passwordController) : null,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordConfirmController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Password Confirm",
                  suffix: passwordConfirmController.text.isNotEmpty ? TextClearSuffixIcon(passwordController) : null,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => passwordController.text == value ? null : "Password is not match",
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(double.infinity, 48)),
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 14.0)),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    final username = usernameController.text.trim();
                    final password = passwordController.text.trim();
                    registerBloc.add(RequestRegisterEvent(username, password));
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              errorText(registerBloc.state),
            ],
          )));
}

Widget errorText(RegisterState state) {
  if(state is RegisterFailureState) {
    return Text(state.errorMsg);
  } else {
    return const SizedBox();
  }
}
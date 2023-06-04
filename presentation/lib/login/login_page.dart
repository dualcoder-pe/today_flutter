import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../base/base_page.dart';
import '../common/icons.dart';
import '../login/login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginPage extends BasePage {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => Scaffold(
              appBar: AppBar(title: const Text("Login")), // TopBar( title: "Login",),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    loginForm(context.read<LoginBloc>()),
                    const SizedBox(
                      height: 30,
                    ),
                    signupAndForgotPW(context.read<LoginBloc>()),
                  ],
                ),
              ),
            ));
  }
}

Widget signupAndForgotPW(LoginBloc loginBloc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      TextButton(onPressed: () => loginBloc.add(RequestSignUpEvent()), child: const Text("Sign up")),
      TextButton(onPressed: () => loginBloc.add(RequestForgotPasswordEvent()), child: const Text("Forgot password"))
    ],
  );
}

Widget loginForm(LoginBloc loginBloc) {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
                    final pwd = passwordController.text.trim();
                    loginBloc.add(RequestLoginEvent(username, pwd));
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )));
}

// class LoginPage extends BasePage {
//   final _formKey = GlobalKey<FormState>();
//
//   final _userNameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   String _loginErrorMsg = "";
//
//   LoginPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
//       return Scaffold(appBar: TopBar("Login"), drawer: AppDrawer(context), body: loginWidget(context, state));
//     });
//   }
//
//   Widget loginWidget(BuildContext context, LoginState state) => Form(
//       key: _formKey,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             TextFormField(
//               controller: _userNameController,
//               // autofocus: true,
//               decoration: InputDecoration(
//                 border: const OutlineInputBorder(),
//                 labelText: "ID",
//                 suffix: _userNameController.text.length > 0 ? getClearTextSuffixWidget(_userNameController) : null,
//               ),
//               keyboardType: TextInputType.text,
//             ),
//             const SizedBox(height: 20),
//             TextFormField(
//               controller: _passwordController,
//               decoration: InputDecoration(
//                 border: const OutlineInputBorder(),
//                 labelText: "Password",
//                 suffix: _passwordController.text.length > 0 ? getClearTextSuffixWidget(_passwordController) : null,
//               ),
//               obscureText: true,
//             ),
//             const SizedBox(height: 16),
//             TextButton(
//                 child: const Text("Login"),
//                 onPressed: () {
//                   if (_userNameController.text.trim().isEmpty) {
//                     _loginErrorMsg = "아이디를 입력하세요";
//                   } else if (_passwordController.text.trim().isEmpty) {
//                     _loginErrorMsg = "비밀번호를 입력하세요";
//                   } else {
//                     _loginErrorMsg = "";
//                     context.
//                     // viewModel.login(_userNameController.text.trim(),
//                     //     _passwordController.text.trim());
//                   }
//                 }),
//             Text(
//               _loginErrorMsg,
//               style: const TextStyle(color: Colors.red),
//             ),
//           ],
//         ),
//       ));
//
//   Widget getClearTextSuffixWidget(TextEditingController controller) => SizedBox(
//         height: 20.0,
//         width: 20.0,
//         child: IconButton(
//           constraints: const BoxConstraints(maxWidth: 20, maxHeight: 20),
//           onPressed: () {
//             controller.clear();
//           },
//           padding: const EdgeInsets.all(0.0),
//           iconSize: 18,
//           color: Colors.greenAccent,
//           icon: const Icon(
//             Icons.clear,
//             color: Colors.grey,
//           ),
//         ),
//       );
// }

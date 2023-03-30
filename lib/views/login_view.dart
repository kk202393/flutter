import 'package:firstflutterapp/services/auth/auth_service.dart';
import 'package:firstflutterapp/services/auth_exceptions.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import '../constants/routes.dart';
import '../utilities/show_error_dailog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            enableSuggestions: false,
            decoration: const InputDecoration(hintText: "Enter Your Email ID"),
          ),
          TextField(
            controller: _password,
            decoration: const InputDecoration(hintText: "Enter Your Password"),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                  );
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                    (route) => false,
                  );
                }
                devtools.log(user.toString());
              } on UserNotFoundAuthExceptions {
                await showErrorDialog(
                  context,
                  "User not found",
                );
              } on WeakPasswordAuthExceptions {
                await showErrorDialog(
                  context,
                  "Password is Weak",
                );
              } on WrongPasswordAuthExceptions {
                await showErrorDialog(
                  context,
                  "Password is Wrong",
                );
              } on GenericAuthExceptions {
                await showErrorDialog(
                  context,
                  "Autgentication erorr",
                );
              }
            },
            child: const Text("Login"),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute, (route) => false); // const RegisterView();
              },
              child: const Text("New User ? Register here."))
        ],
      ),
    );
  }
}

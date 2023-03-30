import 'package:firebase_core/firebase_core.dart';
import 'package:firstflutterapp/services/auth/auth_service.dart';
import 'package:firstflutterapp/services/auth_exceptions.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import '../constants/routes.dart';
import '../firebase_options.dart';
import '../utilities/show_error_dailog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
      appBar: AppBar(title: const Text("Registration")),
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: false,
                    decoration:
                        const InputDecoration(hintText: "Enter Your Email ID"),
                  ),
                  TextField(
                    controller: _password,
                    decoration:
                        const InputDecoration(hintText: "Enter Your Password"),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        await AuthService.firebase().createUser(
                          email: email,
                          password: password,
                        );
                        final user = AuthService.firebase().currentUser;
                        AuthService.firebase().sendEmailVerifications();
                        devtools.log(user.toString());
                        Navigator.of(context).pushNamed(
                          verifyEmailRoute,
                        );
                      } on WeakPasswordAuthExceptions {
                        await showErrorDialog(
                          context,
                          "Weak Password",
                        );
                      } on EmailAlreadyInUseAuthExceptions {
                        await showErrorDialog(
                          context,
                          "Email is already in use",
                        );
                      } on InvalidEmailAuthExceptions {
                        await showErrorDialog(
                          context,
                          "Please enter vaild email ID",
                        );
                      } on GenericAuthExceptions {
                        await showErrorDialog(
                          context,
                          "Faild to Registration",
                        );
                      }
                    },
                    child: const Text("Registration"),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            loginRoute, (route) => false);
                      },
                      child: const Text("Already register? Login here!"))
                ],
              );

            default:
              return const Text("Loading...");
          }
        },
      ),
    );
  }
}

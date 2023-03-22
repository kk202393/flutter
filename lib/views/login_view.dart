import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firstflutterapp/main.dart';
// import 'package:firstflutterapp/views/register_view.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import '../firebase_options.dart';
import 'dart:developer' as devtools show log;

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
                final user = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/NotesView/',
                  (route) => false,
                );
                devtools.log(user.toString());
              } on FirebaseAuthException catch (e) {
                if (e.code == 'wrong-password')
                  devtools.log("Password is worng");
              }
            },
            child: const Text("Login"),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/register/', (route) => false); // const RegisterView();
              },
              child: const Text("New User ? Register here."))
        ],
      ),
    );
  }
}

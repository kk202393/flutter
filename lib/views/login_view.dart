import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

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
      appBar: AppBar(title: const Text("Login")),
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
                        final user = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email, password: password);
                        print(user);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'wrong-password')
                          print("Password is worng");
                      }
                    },
                    child: const Text("Login"),
                  ),
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

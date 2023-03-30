// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firstflutterapp/services/auth/auth_service.dart';
import 'package:firstflutterapp/views/login_view.dart';
import 'package:firstflutterapp/views/notes_view.dart';
import 'package:firstflutterapp/views/register_view.dart';
import 'package:firstflutterapp/views/verify_mail_view.dart';
import 'package:flutter/material.dart';
import 'constants/routes.dart';
import 'dart:developer' as devtools show log;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmail(),
      },
    );
  }
}

// Home Page Code Start

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              devtools.log(user.toString());
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmail();
              }
            } else {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            }
            return const Text("Done");
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

// Home Page Code end

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Log Out"),
          content: const Text("Are you sure you want to  log out?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("No")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Yes"))
          ],
        );
      }).then((value) => value ?? false);
}

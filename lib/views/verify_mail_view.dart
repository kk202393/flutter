import 'package:firstflutterapp/constants/routes.dart';
import 'package:firstflutterapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Your Account"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("We've send you an email verification"),
            const Text(
                "If you haven't recieve a verification email yet, press the button below"),
            TextButton(
              child: const Text("Send email verification again"),
              onPressed: () async {
                await AuthService.firebase().sendEmailVerifications();
              },
            ),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text("Reset"),
            )
          ],
        ),
      ),
    );
  }
}

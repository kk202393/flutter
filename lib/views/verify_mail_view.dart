import 'package:firebase_auth/firebase_auth.dart';
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
            const Text("Please Verify Your Mail:"),
            TextButton(
              child: const Text("Send email verification"),
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
            )
          ],
        ),
      ),
    );
  }
}

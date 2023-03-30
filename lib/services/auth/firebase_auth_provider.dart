import 'package:firebase_core/firebase_core.dart';
import 'package:firstflutterapp/services/auth/auth_provider.dart';
import 'package:firstflutterapp/services/auth_exceptions.dart';
import 'package:firstflutterapp/services/auth/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;

import '../../firebase_options.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthExpection();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        throw WeakPasswordAuthExceptions();
      } else if (e.code == "email-already-in-use") {
        throw EmailAlreadyInUseAuthExceptions();
      } else if (e.code == "invalid-email") {
        throw InvalidEmailAuthExceptions();
      } else {
        throw GenericAuthExceptions();
      }
    } catch (_) {
      throw GenericAuthExceptions();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthExpection();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotLoggedInAuthExpection();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthExceptions();
      } else {
        throw GenericAuthExceptions();
      }
    } catch (_) {
      throw GenericAuthExceptions();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseAuth.instance.signOut();
      } else {
        throw UserNotLoggedInAuthExpection();
      }
    } catch (_) {
      throw GenericAuthExceptions();
    }
  }

  @override
  Future<void> sendEmailVerifications() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthExpection();
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
}

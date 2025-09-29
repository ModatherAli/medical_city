import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../core/utils/logger.dart';
import 'auth_enums.dart';

class FireAuth {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<bool> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
      }
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint("Error in register with email \n $e");
      if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        return false;
      }

      return false;
    }
  }

  static Future<EmailLogInResults> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
      }

      return EmailLogInResults.signInCompleted;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        return EmailLogInResults.emailOrPasswordInvalid;
      }
      return EmailLogInResults.unexpectedError;
    }
  }

  static Future<bool> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      Logger.print("error in reset Password: $e");
      return false;
    }
  }

  static Future<bool> logOut() async {
    try {
      _firebaseAuth.signOut();
      return true;
    } catch (e) {
      Logger.print("Error in log out: $e");
      return false;
    }
  }
}

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

  // PHONE AUTH
  static Future<String> startPhoneNumberVerification({
    required String phoneNumber,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    final completer = Completer<String>();
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeout,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await _firebaseAuth.signInWithCredential(credential);
            // On Android, auto-retrieval may complete without explicit code entry
            completer.complete(credential.verificationId ?? '');
          } catch (e) {
            if (!completer.isCompleted) completer.completeError(e);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!completer.isCompleted) completer.completeError(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          if (!completer.isCompleted) completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // No-op; user can request resend
        },
      );
    } catch (e) {
      if (!completer.isCompleted) completer.completeError(e);
    }
    return completer.future;
  }

  static Future<UserCredential> signInWithSmsCode({
    required String verificationId,
    required String smsCode,
  }) async {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return _firebaseAuth.signInWithCredential(credential);
  }
}

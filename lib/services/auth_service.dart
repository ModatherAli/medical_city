import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_city/core/errors/failure.dart';
import 'package:medical_city/core/network/api_safe_call.dart';
import 'package:medical_city/models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Either<Failure, UserModel?>> checkAuthStatus() async {
    return safeAPiCall(() async {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        return UserModel(
          id: user.uid,
          name: user.displayName,
          email: user.email,
          phone: user.phoneNumber,
        );
      }
      return null;
    }, showLoading: false);
  }

  Future<Either<Failure, UserModel>> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    return safeAPiCall(() async {
      try {
        UserCredential userCredential = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        _firebaseAuth.currentUser!.updateDisplayName(name);
        if (!userCredential.user!.emailVerified) {
          await userCredential.user!.sendEmailVerification();
        }
      } on FirebaseAuthException catch (e) {
        throw FirebaseAuthException(code: e.code, message: e.message);
      }
      return UserModel(
        id: _firebaseAuth.currentUser!.uid,
        name: _firebaseAuth.currentUser!.displayName,
        email: _firebaseAuth.currentUser!.email,
        phone: _firebaseAuth.currentUser!.phoneNumber,
      );
    }, showLoading: true);
  }

  Future<Either<Failure, UserModel>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return safeAPiCall(() async {
      try {
        UserCredential userCredential = await _firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);
        if (!userCredential.user!.emailVerified) {
          await userCredential.user!.sendEmailVerification();
        }
      } on FirebaseAuthException catch (e) {
        throw FirebaseAuthException(code: e.code, message: e.message);
      }
      return UserModel(
        id: _firebaseAuth.currentUser!.uid,
        name: _firebaseAuth.currentUser!.displayName,
        email: _firebaseAuth.currentUser!.email,
        phone: _firebaseAuth.currentUser!.phoneNumber,
      );
    }, showLoading: true);
  }

  Future<Either<Failure, bool>> resetPassword({required String email}) async {
    return safeAPiCall(() async {
      try {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
        return true;
      } on FirebaseAuthException catch (e) {
        throw FirebaseAuthException(code: e.code, message: e.message);
      }
    }, showLoading: true);
  }

  Future<Either<Failure, void>> logout() async {
    return safeAPiCall(() async {
      await _firebaseAuth.signOut();
    }, showLoading: false);
  }

  Future<Either<Failure, String>> verifyPhoneNumber(String phoneNumber) async {
    return safeAPiCall(() async {
      final completer = Completer<String>();
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
          completer.complete(credential.verificationId ?? '');
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return completer.future;
    }, showLoading: true);
  }

  Future<Either<Failure, UserModel>> verifyPhoneCode(
    String verificationId,
    String smsCode,
  ) async {
    return safeAPiCall(() async {
      try {
        final PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        return UserModel(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName,
          email: userCredential.user!.email,
          phone: userCredential.user!.phoneNumber,
        );
      } on FirebaseAuthException catch (e) {
        throw FirebaseAuthException(code: e.code, message: e.message);
      }
    }, showLoading: true);
  }
}
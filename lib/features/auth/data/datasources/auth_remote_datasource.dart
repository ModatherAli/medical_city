import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_safe_call.dart';
import '../../domain/models/auth_model.dart';

class AuthRemoteDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Get notification service from DI
  // NotificationService get _notificationService => getIt<NotificationService>();

  Future<Either<Failure, AuthModel?>> checkAuthStatus() async {
    return safeAPiCall(() async {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        return AuthModel(id: user.uid);
      }
      return null;
    }, showLoading: false);
  }

  Future<Either<Failure, AuthModel>> signUpWithEmail({
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

        // Update FCM token after successful sign up
        // await _notificationService.onUserLogin(userCredential.user!.uid);
      } on FirebaseAuthException catch (e) {
        throw FirebaseAuthException(code: e.code, message: e.message);
      }
      return AuthModel(
        id: _firebaseAuth.currentUser!.uid,
        // createdAt: _firebaseAuth.currentUser!.metadata.creationTime!.toString(),
      );
    }, showLoading: true);
  }

  Future<Either<Failure, AuthModel>> signInWithEmail({
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

        // Update FCM token after successful sign in
        // await _notificationService.onUserLogin(userCredential.user!.uid);
      } on FirebaseAuthException catch (e) {
        throw FirebaseAuthException(code: e.code, message: e.message);
      }
      return AuthModel(
        id: _firebaseAuth.currentUser!.uid,
        // createdAt: _firebaseAuth.currentUser!.metadata.creationTime!.toString(),
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
      // Clear FCM token before logout
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        // await _notificationService.onUserLogout(currentUser.uid);
      }

      await _firebaseAuth.signOut();
    }, showLoading: false);
  }
}

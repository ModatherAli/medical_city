import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:medical_city/controllers/paths.dart';
import 'package:medical_city/models/user_model.dart';
import 'package:medical_city/services/firebase/firebase.dart';

class UserController extends GetxController {
  UserModel currentUser = UserModel.empty();
  String? _verificationId;

  Future<void> getUserData() async {
    if (currentUser.id.isNotEmpty) return;
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await EasyLoading.show(status: 'In Progress...'.tr);

      Map<String, dynamic> userData = await FireDatabase.getItemData(
        collectionPath1: FirebaseCollections.users,
        id: user.uid,
      );
      await EasyLoading.dismiss();
      if (userData.isNotEmpty) {
        currentUser = UserModel.fromMap(userData);
      } else {
        currentUser = currentUser.copyWith(id: user.uid);
      }
    }
    update();
  }

  Future<void> signUpWithEmail(
    String email,
    String password,
    UserModel user,
  ) async {
    await EasyLoading.show(status: 'In Progress...'.tr);
    user = user.copyWith(id: FirebaseAuth.instance.currentUser!.uid);

    bool result = await FireAuth.registerWithEmail(
      email: email,
      password: password,
    );
    if (result) {
      await FireDatabase.saveItemData(
        user,
        collectionPath1: FirebaseCollections.users,
      );
      currentUser = user;
      await EasyLoading.dismiss();
    } else {
      await EasyLoading.showError(
        'An error occurred!',
        dismissOnTap: true,
        duration: const Duration(seconds: 5),
      );
    }
    update();
  }

  Future<void> signInWithEmail(String email, String password) async {
    await EasyLoading.show(status: 'In Progress...'.tr);

    bool result = await FireAuth.registerWithEmail(
      email: email,
      password: password,
    );
    if (result) {
      var userData = await FireDatabase.getItemData(
        collectionPath1: FirebaseCollections.users,
        id: FirebaseAuth.instance.currentUser!.uid,
      );
      currentUser = UserModel.fromMap(userData);
      await EasyLoading.dismiss();
    } else {
      await EasyLoading.showError(
        'An error occurred!',
        dismissOnTap: true,
        duration: const Duration(seconds: 5),
      );
    }
    update();
  }

  Future<void> resetPassword(String email) async {
    await EasyLoading.show(status: 'In Progress...'.tr);

    await FireAuth.resetPassword(email: email);
    await EasyLoading.dismiss();
  }

  Future<void> logout() async {
    await EasyLoading.show(status: 'In Progress...'.tr);
    await FireAuth.logOut();
    currentUser = UserModel.empty();
    await EasyLoading.dismiss();
  }

  Future<String?> verifyPhoneNumber(String phoneNumber) async {
    await EasyLoading.show(status: 'In Progress...'.tr);
    try {
      final verificationId = await FireAuth.startPhoneNumberVerification(
        phoneNumber: phoneNumber,
      );
      _verificationId = verificationId;
      await EasyLoading.dismiss();
      return verificationId;
    } catch (e) {
      await EasyLoading.showError(
        'An error occurred!',
        dismissOnTap: true,
        duration: const Duration(seconds: 5),
      );
      return null;
    } finally {
      update();
    }
  }

  Future<bool> verifyPhoneCode(String smsCode) async {
    if (_verificationId == null) return false;
    await EasyLoading.show(status: 'In Progress...'.tr);
    try {
      final credential = await FireAuth.signInWithSmsCode(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      // After sign-in, check if user exists in Firestore
      final String uid = credential.user!.uid;
      final exists = await FireDatabase.isExistsDocument(
        collectionPath1: FirebaseCollections.users,
        docPath: uid,
      );
      if (exists) {
        final data = await FireDatabase.getItemData(
          collectionPath1: FirebaseCollections.users,
          id: uid,
        );
        currentUser = UserModel.fromMap(data);
      } else {
        currentUser = UserModel.empty();
      }
      await EasyLoading.dismiss();
      return true;
    } catch (e) {
      await EasyLoading.showError(
        'An error occurred!',
        dismissOnTap: true,
        duration: const Duration(seconds: 5),
      );
      return false;
    } finally {
      update();
    }
  }

  Future<bool> saveCompletedProfile(UserModel user) async {
    await EasyLoading.show(status: 'In Progress...'.tr);
    try {
      final String uid = FirebaseAuth.instance.currentUser!.uid;
      final userWithId = user.copyWith(id: uid, phone: user.phone);
      final saved = await FireDatabase.saveItemData(
        userWithId,
        collectionPath1: FirebaseCollections.users,
      );
      if (saved) {
        currentUser = userWithId;
      }
      await EasyLoading.dismiss();
      return saved;
    } catch (e) {
      await EasyLoading.showError(
        'An error occurred!',
        dismissOnTap: true,
        duration: const Duration(seconds: 5),
      );
      return false;
    } finally {
      update();
    }
  }
}

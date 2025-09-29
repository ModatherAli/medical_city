import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:medical_city/controllers/paths.dart';
import 'package:medical_city/models/user_model.dart';
import 'package:medical_city/services/firebase/firebase.dart';

class AuthController extends GetxController {
 
  UserModel? currentUser;


  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  Future<void> getUserData() async {
    await EasyLoading.show(status: 'In Progress...'.tr);

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      currentUser = null;
    } else {
      Map<String, dynamic> userData = await FireDatabase.getItemData(
        collectionPath1: FirebaseCollections.users,
        id: user.uid,
      );
      currentUser = UserModel.fromMap(userData);
    }
    update();
  }

  Future<void> signUpWithEmail(
    String email,
    String password,
    UserModel user,
  ) async {
    await EasyLoading.show(status: 'In Progress...'.tr);

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
    currentUser = null;
    await EasyLoading.dismiss();
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    // await EasyLoading.show(status: 'In Progress...'.tr);
    // errorMessage.value = '';
    // final result = await FireAuth.verifyPhoneNumber(phoneNumber);

    // await EasyLoading.dismiss();
  }

  Future<void> verifyPhoneCode(String smsCode) async {
    // await EasyLoading.show(status: 'In Progress...'.tr);
    // errorMessage.value = '';
    // final result = await FireAuth.verifyPhoneCode(
    //   verificationId.value,
    //   smsCode,
    // );
    // result.fold(
    //   (failure) {
    //     errorMessage.value = failure.message;
    //   },
    //   (userModel) {
    //     _user.value = userModel;
    //   },
    // );
    // isLoading = false;
  }
}

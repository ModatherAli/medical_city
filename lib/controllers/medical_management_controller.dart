import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:medical_city/controllers/paths.dart';
import 'package:medical_city/models/user_model.dart';
import 'package:medical_city/services/firebase/fire_database.dart';

class MedicalManagementController extends GetxController {
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    isLoading.value = true;
    try {
      final items = await FireDatabase.getListOfItems(
        collectionPath1: FirebaseCollections.users,
      );
      users.assignAll(items.map((e) => UserModel.fromMap(e)));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateIsActive(UserModel user, bool isActive) async {
    await _updateFields(user, {'isActive': isActive});
  }

  Future<void> updateIsAdmin(UserModel user, bool isAdmin) async {
    await _updateFields(user, {'isAdmin': isAdmin});
  }

  Future<void> _updateFields(UserModel user, Map<Object, Object?> data) async {
    await EasyLoading.show(status: 'In Progress...');
    try {
      final saved = await FireDatabase.updateFieldData(
        user,
        collectionPath: FirebaseCollections.users,
        data: data,
      );
      if (saved) {
        final index = users.indexWhere((u) => u.id == user.id);
        if (index != -1) {
          users[index] = users[index].copyWith(
            isActive: data['isActive'] as bool? ?? users[index].isActive,
            isAdmin: data['isAdmin'] as bool? ?? users[index].isAdmin,
          );
        }
      } else {
        await EasyLoading.showError('Failed to update');
      }
    } finally {
      await EasyLoading.dismiss();
    }
  }
}

import 'package:get/get.dart';

import 'controllers.dart';
import 'medical_management_controller.dart';

class BindingController extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController(), permanent: true);
    Get.lazyPut(() => MedicalManagementController(), fenix: true);
  }
}

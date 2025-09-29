import 'package:get/get.dart';

import 'controllers.dart';

class BindingController extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController(), permanent: true);
  }
}

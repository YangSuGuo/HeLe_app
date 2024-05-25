import 'package:get/get.dart';

import '../controllers/main_controllers.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
      fenix: true,
    );
  }
}

import 'package:get/get.dart';

import '../controllers/lightNovel_controller.dart';

class LightNovelBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LightNovelController>(
          () => LightNovelController(),
    );
  }
}

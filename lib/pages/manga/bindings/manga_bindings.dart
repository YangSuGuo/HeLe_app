import 'package:get/get.dart';
import 'package:hele_app/pages/manga/controllers/manga_controller.dart';

class MangaBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MangaController>(
          () => MangaController(),
    );
  }
}

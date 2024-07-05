import 'package:get/get.dart';
import 'package:hele_app/pages/wiki/controllers/wiki_controller.dart';

class WikiBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WikiController>(() => WikiController());
  }
}

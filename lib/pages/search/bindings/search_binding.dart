import 'package:get/get.dart';
import 'package:hele_app/pages/search/controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchPageController>(
      () => SearchPageController(),
    );
  }
}

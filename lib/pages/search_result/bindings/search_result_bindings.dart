import 'package:get/get.dart';
import 'package:hele_app/pages/search_result/controllers/search_result_controllers.dart';

class SearchResultBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchResultControllers>(
      () => SearchResultControllers(),
    );
  }
}

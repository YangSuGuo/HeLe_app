import 'package:get/get.dart';
import 'package:hele_app/pages/tabs/series/controllers/series_controller.dart';

class SeriesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeriesController>(
      () => SeriesController(),
    );
  }
}

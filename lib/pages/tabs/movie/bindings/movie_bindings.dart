import 'package:get/get.dart';
import 'package:hele_app/pages/tabs/movie/controllers/movie_controller.dart';

class MovieBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieController>(
      () => MovieController(),
    );
  }
}

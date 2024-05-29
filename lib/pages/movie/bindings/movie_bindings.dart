import 'package:get/get.dart';
import 'package:hele_app/pages/movie/controllers/movie_controller.dart';

class MovieBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieController>(
      () => MovieController(),
    );
  }
}

import 'package:get/get.dart';
import 'package:hele_app/pages/home/controllers/home_controller.dart';

import '../controllers/main_controllers.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
/*    Get.lazyPut<AnimeBindings>(
      () => AnimeBindings(),
    );
    Get.lazyPut<MangaBindings>(
      () => MangaBindings(),
    );
    Get.lazyPut<MovieBindings>(
      () => MovieBindings(),
    );
    Get.lazyPut<SeriesBindings>(
      () => SeriesBindings(),
    );
    Get.lazyPut<LightNovelBindings>(
      () => LightNovelBindings(),
    );*/
  }
}

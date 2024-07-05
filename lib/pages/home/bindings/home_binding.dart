import 'package:get/get.dart';
import 'package:hele_app/pages/tabs/anime/controllers/anime_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

/*    Get.lazyPut<AnimeController>(
          () => AnimeController(),
    );*/

/*    Get.lazyPut<HomeBinding>(
        ()=>HomeBinding(),
    );*/
  }
}

import 'package:get/get.dart';
import 'package:hele_app/pages/home/controllers/home_controller.dart';
import 'package:hele_app/pages/tabs/anime/bindings/anime_bindings.dart';
import 'package:hele_app/pages/tabs/lightNovel/bindings/lightNovel_bindings.dart';
import 'package:hele_app/pages/tabs/manga/bindings/manga_bindings.dart';
import 'package:hele_app/pages/tabs/movie/bindings/movie_bindings.dart';
import 'package:hele_app/pages/tabs/series/bindings/series_bindings.dart';

import '../controllers/main_controllers.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
      fenix: true,
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<AnimeBindings>(
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
    );
  }
}

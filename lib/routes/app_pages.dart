import 'package:get/get.dart';
import 'package:hele_app/pages/home/bindings/home_binding.dart';
import 'package:hele_app/pages/home/views/home.dart';
import 'package:hele_app/pages/main/bindings/main_binding.dart';
import 'package:hele_app/pages/main/views/main.dart';
import 'package:hele_app/pages/tabs/anime/bindings/anime_bindings.dart';
import 'package:hele_app/pages/tabs/anime/views/anime.dart';
import 'package:hele_app/pages/tabs/lightNovel/bindings/lightNovel_bindings.dart';
import 'package:hele_app/pages/tabs/lightNovel/views/light_novel.dart';
import 'package:hele_app/pages/tabs/manga/bindings/manga_bindings.dart';
import 'package:hele_app/pages/tabs/manga/views/manga.dart';
import 'package:hele_app/pages/tabs/movie/bindings/movie_bindings.dart';
import 'package:hele_app/pages/tabs/movie/views/movie.dart';
import 'package:hele_app/pages/tabs/series/bindings/series_bindings.dart';
import 'package:hele_app/pages/tabs/series/views/series.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: Routes.MAIN,
      page: () => const MainApp(),
      binding: MainBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const Home(),
      binding: HomeBinding(),
    ),

    // tab页面
    GetPage(
      name: Routes.ANIME,
      page: () => const Anime(),
      binding: AnimeBindings(),
    ),
    GetPage(
      name: Routes.MANGA,
      page: () => const Manga(),
      binding: MangaBindings(),
    ),
    GetPage(
      name: Routes.MOVIE,
      page: () => const Movie(),
      binding: MovieBindings(),
    ),
    GetPage(
      name: Routes.SERIES,
      page: () => const Series(),
      binding: SeriesBindings(),
    ),
    GetPage(
      name: Routes.LIGHT_NOVEL,
      page: () => const LightNovel(),
      binding: LightNovelBindings(),
    ),
  ];
}

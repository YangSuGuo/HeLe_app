import 'package:get/get.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
import 'package:hele_app/pages/tabs/anime/controllers/anime_controller.dart';
import 'package:hele_app/pages/tabs/anime/views/anime.dart';
import 'package:hele_app/pages/tabs/lightNovel/controllers/lightNovel_controller.dart';
import 'package:hele_app/pages/tabs/lightNovel/views/light_novel.dart';
import 'package:hele_app/pages/tabs/manga/controllers/manga_controller.dart';
import 'package:hele_app/pages/tabs/manga/views/manga.dart';
import 'package:hele_app/pages/tabs/movie/controllers/movie_controller.dart';
import 'package:hele_app/pages/tabs/movie/views/movie.dart';
import 'package:hele_app/pages/tabs/series/controllers/series_controller.dart';
import 'package:hele_app/pages/tabs/series/views/series.dart';

enum TabType { anime, manga, movie, series, lightNovel }

extension TabTypeDesc on TabType {
  String get description => [
        S.of(Get.context!).tabs_anime,
        S.of(Get.context!).tabs_manga,
        S.of(Get.context!).tabs_movie,
        S.of(Get.context!).tabs_series,
        S.of(Get.context!).tabs_light_novel
      ][index];

  String get id => ['anime', 'manga', 'movie', 'series', 'lightNovel'][index];
}

List tabsConfig = [
  {
    'label': S.of(Get.context!).tabs_anime,
    'type': TabType.anime,
    'controller': Get.find<AnimeController>,
    'page': const Anime(),
  },
  {
    'label': S.of(Get.context!).tabs_manga,
    'type': TabType.manga,
    'controller': Get.find<MangaController>,
    'page': const Manga(),
  },
  {
    'label': S.of(Get.context!).tabs_movie,
    'type': TabType.movie,
    'controller': Get.find<MovieController>,
    'page': const Movie(),
  },
  {
    'label': S.of(Get.context!).tabs_series,
    'type': TabType.series,
    'controller': Get.find<SeriesController>,
    'page': const Series(),
  },
  {
    'label': S.of(Get.context!).tabs_light_novel,
    'type': TabType.lightNovel,
    'controller': Get.find<LightNovelController>,
    'page': const LightNovel(),
  },
];

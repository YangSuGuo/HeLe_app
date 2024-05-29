import 'package:get/get.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
import 'package:hele_app/pages/anime/controllers/anime_controller.dart';
import 'package:hele_app/pages/anime/views/anime.dart';
import 'package:hele_app/pages/lightNovel/controllers/lightNovel_controller.dart';
import 'package:hele_app/pages/lightNovel/views/light_novel.dart';
import 'package:hele_app/pages/manga/controllers/manga_controller.dart';
import 'package:hele_app/pages/manga/views/manga.dart';
import 'package:hele_app/pages/movie/controllers/movie_controller.dart';
import 'package:hele_app/pages/movie/views/movie.dart';
import 'package:hele_app/pages/series/controllers/series_controller.dart';
import 'package:hele_app/pages/series/views/series.dart';

enum TabType { anime, manga, movie, series, lightNovel }

extension TabTypeDesc on TabType {
  String get description => ['动漫', '漫画', '电影', '电视剧', '轻小说'][index];

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

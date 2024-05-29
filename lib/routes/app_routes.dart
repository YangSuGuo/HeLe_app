part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  // 主目录
  static const MAIN = '/main';
  static const HOME = '/home';
  static const SETTING = '/setting';

  // Tabs目录
  static const ANIME = '/anime';
  static const MANGA = '/manga';
  static const MOVIE = '/movie';
  static const SERIES = '/series';
  static const LIGHT_NOVEL = '/lightNovel';
}
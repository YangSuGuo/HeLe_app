part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  // 主目录
  static const MAIN = '/main';
  static const HOME = '/home';

  // Tabs目录
  static const ANIME = '/anime';
  static const MANGA = '/manga';
  static const LIGHT_NOVEL = '/lightNovel';
  // todo
  static const MOVIE = '/movie';
  static const SERIES = '/series';

  // WIKI
  static const WIKI = '/wiki';

  // 搜索页
  static const SEARCH = '/search';
  static const SEARCH_RESULT = '/searchResult';

  // 我的页面
  static const MANAGEENTRIES = '/manageEntries';
  static const MYFAVORITES = '/myFavorites';
  static const USERTAGS = '/userTags';
  static const BROWSINGHISTORY = '/browsingHistory';
  static const APPLYDATA = '/applyData';
  static const SETTING = '/setting';
  // todo 关于
  static const ABOUTAPPLICATION = '/aboutApplication';
}

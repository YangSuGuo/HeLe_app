import 'package:get/get.dart';
import 'package:hele_app/pages/about/views/about_section.dart';
import 'package:hele_app/pages/apply_data/views/apply_data.dart';
import 'package:hele_app/pages/browsing_history/views/browsing_history.dart';
import 'package:hele_app/pages/data_and_statistics/bindings/data_and_statistics_bingings.dart';
import 'package:hele_app/pages/data_and_statistics/views/data_and_statistics.dart';
import 'package:hele_app/pages/home/views/home.dart';
import 'package:hele_app/pages/main/bindings/main_binding.dart';
import 'package:hele_app/pages/main/views/main.dart';
import 'package:hele_app/pages/manage_entries/bindings/manage_entries_bindings.dart';
import 'package:hele_app/pages/manage_entries/views/manage_entries.dart';
import 'package:hele_app/pages/my_favorites/bindings/my_favorites_bindings.dart';
import 'package:hele_app/pages/my_favorites/views/my_favorites.dart';
import 'package:hele_app/pages/search/bindings/search_binding.dart';
import 'package:hele_app/pages/search/views/search.dart';
import 'package:hele_app/pages/search_result/bindings/search_result_bindings.dart';
import 'package:hele_app/pages/search_result/views/search_result.dart';
import 'package:hele_app/pages/settings/views/settings.dart';
import 'package:hele_app/pages/tabs/anime/views/anime.dart';
import 'package:hele_app/pages/tabs/lightNovel/views/light_novel.dart';
import 'package:hele_app/pages/tabs/manga/views/manga.dart';
import 'package:hele_app/pages/user_tags/views/user_tags.dart';
import 'package:hele_app/pages/wiki/bindings/wiki_bindings.dart';
import 'package:hele_app/pages/wiki/views/wiki.dart';

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
        // 主页
        name: Routes.HOME,
        page: () => const Home(),
        // binding: HomeBinding(),
        children: [
          // tab页面
          GetPage(
            // 动漫
            name: Routes.ANIME,
            page: () => const Anime(),
            // binding: AnimeBindings(),
          ),
          GetPage(
            // 漫画
            name: Routes.MANGA,
            page: () => const Manga(),
            // binding: MangaBindings(),
          ),
          GetPage(
            // 轻小说
            name: Routes.LIGHT_NOVEL,
            page: () => const LightNovel(),
            // binding: LightNovelBindings(),
          ),
        ]),

    // WIKI
    GetPage(
      name: Routes.WIKI,
      page: () => const Wiki(),
      binding: WikiBindings(),
    ),

    // 搜索页
    GetPage(
      name: Routes.SEARCH,
      page: () => const Search(),
      binding: SearchBinding(),
    ),

    // 搜索结果页
    GetPage(
      name: Routes.SEARCH_RESULT,
      page: () => const SearchResult(),
      binding: SearchResultBindings(),
    ),

    // 我的页面
    GetPage(
      // 管理条目
      name: Routes.MANAGEENTRIES,
      page: () => const ManageEntries(),
      binding: ManageEntriesBindings(),
    ),
    GetPage(
      // 我的收藏
      name: Routes.MYFAVORITES,
      page: () => const MyFavorites(),
      binding: MyFavoritesBindings(),
    ),
    GetPage(
      // 用户标签
      name: Routes.USERTAGS,
      page: () => const UserTags(),
      // binding: SearchResultBindings(),
    ),
    GetPage(
      // 浏览历史
      name: Routes.BROWSINGHISTORY,
      page: () => const BrowsingHistory(),
      // binding: SearchResultBindings(),
    ),
    GetPage(
      // 阅读与统计
      name: Routes.DATAANDSTATISTICS,
      page: () => const DataAndStatistics(),
      binding: DataAndStatisticsBinging(),
    ),
    GetPage(
      // 设置
      name: Routes.SETTING, page: () => const Settings(),
      // binding: SearchResultBindings(),
    ),
    GetPage(
        // 应用数据
        name: Routes.APPLYDATA,
        page: () => const ApplyData()
        // binding: SearchResultBindings(),
        ),
    GetPage(
        // 关于
        name: Routes.ABOUT,
        page: () => const AboutSection()),
  ];
}

import 'app_g.dart';

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get hello_World => '你好 世界!';

  @override
  String get navigationBar_title_home => '首页';

  @override
  String get navigationBar_title_rank_list => '排行榜';

  @override
  String get navigationBar_title_my => '我的';

  @override
  String get tabs_anime => '动漫';

  @override
  String get tabs_manga => '漫画';

  @override
  String get tabs_movie => '电影';

  @override
  String get tabs_series => '电视剧';

  @override
  String get tabs_light_novel => '轻小说';

  @override
  String get tab_anime_calendar => '追番表';

  @override
  String get widgets_will_pop_scope_route_toast => '再按一次退出';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class SZhCn extends SZh {
  SZhCn() : super('zh_CN');

  @override
  String get hello_World => '你好 世界!';

  @override
  String get navigationBar_title_home => '首页';

  @override
  String get navigationBar_title_rank_list => '排行榜';

  @override
  String get navigationBar_title_my => '我的';

  @override
  String get tabs_anime => '动漫';

  @override
  String get tabs_manga => '漫画';

  @override
  String get tabs_movie => '电影';

  @override
  String get tabs_series => '电视剧';

  @override
  String get tabs_light_novel => '轻小说';

  @override
  String get tab_anime_calendar => '追番表';

  @override
  String get widgets_will_pop_scope_route_toast => '再按一次退出';
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class SZhHk extends SZh {
  SZhHk() : super('zh_HK');

  @override
  String get hello_World => '你好 世界!';

  @override
  String get navigationBar_title_home => '首頁';

  @override
  String get navigationBar_title_rank_list => '排行榜';

  @override
  String get navigationBar_title_my => '我的';

  @override
  String get tabs_anime => '動漫';

  @override
  String get tabs_manga => '漫畫';

  @override
  String get tabs_movie => '電影';

  @override
  String get tabs_series => '電視劇';

  @override
  String get tabs_light_novel => '輕小說';

  @override
  String get widgets_will_pop_scope_route_toast => '再按一次退出';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class SZhTw extends SZh {
  SZhTw() : super('zh_TW');

  @override
  String get hello_World => '你好 世界!';

  @override
  String get navigationBar_title_home => '首頁';

  @override
  String get navigationBar_title_rank_list => '排行榜';

  @override
  String get navigationBar_title_my => '我的';

  @override
  String get tabs_anime => '動漫';

  @override
  String get tabs_manga => '漫畫';

  @override
  String get tabs_movie => '電影';

  @override
  String get tabs_series => '電視劇';

  @override
  String get tabs_light_novel => '輕小說';

  @override
  String get widgets_will_pop_scope_route_toast => '再按一次退出';
}

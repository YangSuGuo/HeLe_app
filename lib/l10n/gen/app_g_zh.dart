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
  String get widgets_will_pop_scope_route_toast => '再按一次退出';
}

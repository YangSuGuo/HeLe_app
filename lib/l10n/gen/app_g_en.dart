import 'app_g.dart';

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get hello_World => 'Hello World!';

  @override
  String get bottomNavigationBar_title_home => 'home';

  @override
  String get widgets_will_pop_scope_route_toast => 'Press again to exit';
}

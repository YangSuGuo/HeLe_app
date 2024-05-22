import 'package:get/get.dart';
import 'package:hele_app/pages/index.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.MAIN,
      page: () => const BottomNavigation()
    )
  ];
}

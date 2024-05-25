import 'package:get/get.dart';
import 'package:hele_app/pages/home/bindings/home_binding.dart';
import 'package:hele_app/pages/home/views/home.dart';
import 'package:hele_app/pages/main/bindings/main_binding.dart';
import 'package:hele_app/pages/main/views/main.dart';
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
  ];
}

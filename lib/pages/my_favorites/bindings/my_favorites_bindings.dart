import 'package:get/get.dart';
import 'package:hele_app/pages/my_favorites/controllers/my_favorites_controllers.dart';

class MyFavoritesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyFavoritesControllers>(
      () => MyFavoritesControllers(),
    );
  }
}

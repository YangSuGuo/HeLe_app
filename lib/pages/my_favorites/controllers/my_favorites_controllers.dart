import 'package:get/get.dart';
import 'package:hele_app/db/database/app_database.dart';

class MyFavoritesControllers extends GetxController {
  final AppDatabase db = Get.find<AppDatabase>(); // 获取数据库实例

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> getAllUserFavorites() async {
  }
}

import 'package:get/get.dart';
import 'package:hele_app/db/database/app_database.dart';

class MyFavoritesControllers extends GetxController
    with GetTickerProviderStateMixin {
  final AppDatabase db = Get.find<AppDatabase>(); // 获取数据库实例

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> getAllUserFavorites() async {
    await db.subjectsStarDao.findSubjectsStarByTypeStatusTagsHidden(
      1, 1, "", false, true, "rating", 0,
      // type: 1,
      // status: 1,
      // tags: "",
      // isHidden: false,
      // isCollected: true,
      // sortBy: "rating",
      // offset: 0,
    );
  }
}

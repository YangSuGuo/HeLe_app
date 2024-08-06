import 'package:get/get.dart';
import 'package:hele_app/db/database/app_database.dart';

class BrowsingHistoryControllers extends GetxController
    with GetTickerProviderStateMixin {
  final AppDatabase db = Get.find<AppDatabase>(); // 获取数据库实例
}

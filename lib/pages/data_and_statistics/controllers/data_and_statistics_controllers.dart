import 'package:get/get.dart';
import 'package:hele_app/db/database/app_database.dart';

class DataAndStatisticsControllers extends GetxController{
  final AppDatabase db = Get.find<AppDatabase>(); // 获取数据库实例
}

import 'package:get/get.dart';
import 'package:hele_app/db/database/app_database.dart';
import 'package:hele_app/db/database/entity/subjects_user_tags.dart';

class UserTagsControllers extends GetxController with GetTickerProviderStateMixin {
  final AppDatabase db = Get.find<AppDatabase>(); // 获取数据库实例

  Future<List<SubjectsUserTags>> querySubjectsUserTags() async {
    return await db.subjectsUserTagsDao.findAllTags();
  }
}

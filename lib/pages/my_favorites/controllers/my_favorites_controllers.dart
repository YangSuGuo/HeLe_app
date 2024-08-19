import 'dart:developer';

import 'package:get/get.dart';
import 'package:hele_app/db/database/app_database.dart';
import 'package:hele_app/db/database/entity/subjects_star.dart';

class MyFavoritesControllers extends GetxController {
  final AppDatabase db = Get.find<AppDatabase>(); // 获取数据库实例

  bool isHidden = false;
  int offset = 0;
  String sortBy = "creationTime";

  RxList<SubjectsStar> stars = <SubjectsStar>[].obs;
  // RxInt length = 0.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  // 更新阅读条目
  Future updateSubjectsStarStatus(SubjectsStar subjectsStar) async {
    subjectsStar.isCollected = false;
    await db.subjectsStarDao.updateSubject(subjectsStar);
    log("收藏更新");
  }

  // 获取收藏
  Future getAllUserFavorites() async {
    List<SubjectsStar> subjectsStar = await db.subjectsStarDao.queryUserFavorites(true, isHidden, sortBy, offset);
    stars.value = subjectsStar;
    // length.value = subjectsStar.length;
    return subjectsStar;
  }
}

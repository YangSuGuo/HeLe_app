import 'dart:developer';

import 'package:get/get.dart';
import 'package:hele_app/db/database/app_database.dart';

class DataAndStatisticsControllers extends GetxController {
  final AppDatabase db = Get.find<AppDatabase>(); // 获取数据库实例
  List<int> totalSubjects = <int>[]; // all
  List<int> totalAnimeSubjects = <int>[]; // 动漫
  List<int> totalMangaSubjects = <int>[]; // 书籍

  // 总览数据
  Future getTotalSubjects() async {
    for (int i = 0; i < 4; i++) {
      int s = await db.subjectsStarDao.countSubjectsByStatus(i) ?? 0;
      totalSubjects.add(s);
    }
    log("总览：$totalSubjects");
    return totalSubjects;
  }

  // 分类统计数据
  Future getCategorySubjects(int type) async {
    for (int i = 0; i < 4; i++) {
      int s = await db.subjectsStarDao.countSubjectsByStatusAndType(i, type) ?? 0;
      type == 1 ? totalMangaSubjects.add(s) : totalAnimeSubjects.add(s);
    }
    type == 1 ? log("书籍分类：$totalMangaSubjects") : log("动漫分类：$totalAnimeSubjects");
    return type == 1 ? totalMangaSubjects : totalAnimeSubjects;
  }
}

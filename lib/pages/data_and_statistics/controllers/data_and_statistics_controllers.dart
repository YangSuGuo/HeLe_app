import 'dart:developer';

import 'package:get/get.dart';
import 'package:hele_app/common/utils/math_utils.dart';
import 'package:hele_app/db/database/app_database.dart';
import 'package:hele_app/model/rating.dart';

class DataAndStatisticsControllers extends GetxController {
  final AppDatabase db = Get.find<AppDatabase>(); // 获取数据库实例
  List<int> totalSubjects = <int>[]; // all
  List<int> totalAnimeSubjects = <int>[]; // 动漫
  List<int> totalMangaSubjects = <int>[]; // 书籍

  Count animeCount = Count(the1: 0, the2: 0, the3: 0, the4: 0, the5: 0, the6: 0, the7: 0, the8: 0, the9: 0, the10: 0);
  Count mangaCount = Count(the1: 0, the2: 0, the3: 0, the4: 0, the5: 0, the6: 0, the7: 0, the8: 0, the9: 0, the10: 0);

  @override
  void onInit() async {
    super.onInit();
  }

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
    // 计数
    for (int i = 0; i < 4; i++) {
      int s = await db.subjectsStarDao.countSubjectsByStatusAndType(i, type) ?? 0;
      type == 1 ? totalMangaSubjects.add(s) : totalAnimeSubjects.add(s);
    }
    type == 1 ? log("书籍分类：$totalMangaSubjects") : log("动漫分类：$totalAnimeSubjects");
    // 评分
    List<double> score = await db.subjectsStarDao.getScoreByType(type) ?? []; // 官方评分
    List<double> rating = await db.subjectsStarDao.getRatingByType(type) ?? []; // 用户评分

    if (type == 1) {
      mangaCount = MathUtils.countRating(rating);
    } else {
      animeCount = MathUtils.countRating(rating);
    }

    return type == 1 ? totalMangaSubjects : totalAnimeSubjects;
  }
}

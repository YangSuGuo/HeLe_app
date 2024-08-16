import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hele_app/db/database/app_database.dart';
import 'package:hele_app/db/database/entity/subjects_star.dart';
import 'package:hele_app/pages/manage_entries/model/tracking_type_list.dart';

class ManageEntriesControllers extends GetxController {
  final AppDatabase db = Get.find<AppDatabase>(); // 获取数据库实例
  ScrollController scrollController = ScrollController();
  List<String> trackingType = [
    "想读",
    "在看",
    "看过",
    "搁置",
    "抛弃",
  ];

  RxInt type = 2.obs;
  int tabIndex = 0;
  int offset = 0;
  String sortBy = "creationTime";

  TrackingTypeList trackingTypeList = TrackingTypeList([], [], [], [], []);
  late RxList length = [].obs;
  List<String> buttonList = ["在看", "看过", "收藏", "想看", "想看"];

  @override
  void onInit() {
    super.onInit();
    getTrackingType();
  }

  // 获取当前tab下数据
  Future getTrackingType() async {
    for (int i = 0; i < 5; i++) {
      List<SubjectsStar> subjectsStar =
          await db.subjectsStarDao.findSubjectsStarByTypeStatusTagsHidden(type.value, i, false, sortBy, offset);

      switch (i) {
        case 0:
          trackingTypeList.wantToRead = subjectsStar;
          break;
        case 1:
          trackingTypeList.currentlyReading = subjectsStar;
          break;
        case 2:
          trackingTypeList.read = subjectsStar;
          break;
        case 3:
          trackingTypeList.onHold = subjectsStar;
          break;
        case 4:
          trackingTypeList.dropped = subjectsStar;
          break;
      }
      log("$i: ${subjectsStar.length.toString()}");
    }

    length.value = [
      trackingTypeList.wantToRead.length,
      trackingTypeList.currentlyReading.length,
      trackingTypeList.read.length,
      trackingTypeList.onHold.length,
      trackingTypeList.dropped.length
    ];

    log(length.toString());
    return trackingTypeList;
  }

  List<SubjectsStar> getTrackingListByIndex(int index) {
    switch (index) {
      case 0:
        return trackingTypeList.wantToRead;
      case 1:
        return trackingTypeList.currentlyReading;
      case 2:
        return trackingTypeList.read;
      case 3:
        return trackingTypeList.onHold;
      case 4:
        return trackingTypeList.dropped;
      default:
        throw ArgumentError('索引无效: $index');
    }
  }

  // 删除条目
  Future deleteSubjectsStar(SubjectsStar subjectsStar) async {
    await db.subjectsStarDao.removeSubject(subjectsStar);
  }

  Future updateSubjectsStar(SubjectsStar subjectsStar) async {
    await db.subjectsStarDao.updateSubject(subjectsStar);
  }
}

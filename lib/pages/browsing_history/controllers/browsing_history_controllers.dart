import 'dart:developer';

import 'package:get/get.dart';
import 'package:hele_app/db/database/app_database.dart';
import 'package:hele_app/db/database/entity/subjects_history.dart';
import 'package:hele_app/model/search/search.dart';

class BrowsingHistoryControllers extends GetxController with GetTickerProviderStateMixin {
  final AppDatabase db = Get.find<AppDatabase>(); // 获取数据库实例
  RxList<SubjectsHistory> subjectsHistoryList = <SubjectsHistory>[].obs;
  late RxList<Datum> datumList = <Datum>[].obs;

  SubjectsHistory subjectsHistory = SubjectsHistory(
      subjectId: 1,
      name: "十二国记",
      nameCn: "十二国记",
      type: 2,
      url: "https://lain.bgm.tv/pic/cover/l/60/10/12818_9pvqv.jpg",
      platform: "TV",
      summary:
          "《十二国记》是小野不由美所著奇幻小说系列作品，故事借由一个日本女高中生卷入异世界的经过，带出庞大的十二个国家的兴衰史。\r\n自1991年推出《魔性之子》（十二国记前传），不定期连载中。2002年改编为TV动画。\r\n\r\n文庫未収録：\r\n漂舶",
      totalEpisodes: 12,
      volumes: 12,
      eps: 12,
      airDate: "",
      images: "https://lain.bgm.tv/pic/cover/l/60/10/12818_9pvqv.jpg",
      score: 9.0,
      rank: 1,
      creationTime: DateTime.now().millisecondsSinceEpoch);

  @override
  void onInit() async {
    super.onInit();
    if (false) {
      await db.subjectsHistoryDao.insertSubjectsHistory(subjectsHistory);
    }
  }

  // 查询全部历史记录
  Future<List<SubjectsHistory>> findAllSubjectsHistory() async {
    subjectsHistoryList.value = await db.subjectsHistoryDao.findAllSubjectsHistory();
    datumList.value = subjectsHistoryList.map((e) => e.toDatum()).toList();
    log(subjectsHistoryList.length.toString());
    return subjectsHistoryList;
  }

  // 清空历史记录
  Future<void> deleteAllSubjectsHistory() async {
    await db.subjectsHistoryDao.deleteAllSubjectsHistory();
  }

  // 添加历史记录
  Future<void> insertSubjectsHistory(SubjectsHistory subjectsHistory) async {
    await db.subjectsHistoryDao.insertSubjectsHistory(subjectsHistory);
  }
}

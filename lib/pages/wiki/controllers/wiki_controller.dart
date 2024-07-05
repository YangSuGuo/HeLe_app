import 'package:get/get.dart';
import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/model/subjects/subjects.dart';

class WikiController extends GetxController {
  late int id;
  late LegacySubjectSmall legacySubjectSmall;
  late Rx<Subjects> subjects;

  String title = '';
  String imgUrl = '';

  @override
  void onInit() {
    super.onInit();
    legacySubjectSmall = Get.arguments['bangumiItem'];
    // querySubjectDetails(legacySubjectSmall.id!);
    title = (legacySubjectSmall.nameCn ?? legacySubjectSmall.name)!;
    imgUrl = legacySubjectSmall.images?.large ??
        'https://img.picui.cn/free/2024/07/01/66824a43e0e23.png';
  }

// 请求番剧详情
/*  Future querySubjectDetails(int subjectId) async {
    var result = await BangumiNet.bangumiSubject(subjectId);
    subjects.value = result;
  }*/
}

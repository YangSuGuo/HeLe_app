import 'package:get/get.dart';
import 'package:hele_app/common/utils/math_utils.dart';
import 'package:hele_app/http/bangumi_net.dart';
import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/model/infobox.dart';
import 'package:hele_app/model/subjects/subjects.dart';

class WikiController extends GetxController {
  late LegacySubjectSmall legacySubjectSmall; // 番剧信息
  Rxn<Subjects> subjects = Rxn<Subjects>(); // 条目信息
  RxList tags = [].obs; // Tabs列表

  String title = '';
  String imgUrl = '';
  RxString production = ''.obs;

  // 标准差
  RxDouble deviation = 0.0.obs;
  RxString dispute = ''.obs;

  @override
  void onInit() {
    super.onInit();
    legacySubjectSmall = Get.arguments['bangumiItem'];
    querySubjectDetails(legacySubjectSmall.id!);

    title = legacySubjectSmall.nameCn != "" || legacySubjectSmall.name != ""
        ? legacySubjectSmall.nameCn != ""
            ? legacySubjectSmall.nameCn!
            : legacySubjectSmall.name!
        : "获取失败！";
    imgUrl = legacySubjectSmall.images?.large ?? 'https://img.picui.cn/free/2024/07/01/66824a43e0e23.png';
  }

  // 获取infobox
  String getInfobox(List<Item> infobox, String key) {
    for (var item in infobox) {
      if (item.key == key) {
        // 检查是否是列表且列表不为空且第一个元素包含键
        if (item.value is List && item.value.isNotEmpty && item.value.first.containsKey('v')) {
          return item.value.first['v'].toString();
        } else {
          return item.value.toString();
        }
      }
    }
    return "";
  }

  // 计算争议度
  String getDispute(double deviation) {
    if (deviation == 0) return '-';
    if (deviation < 1) return '异口同声';
    if (deviation < 1.15) return '基本一致';
    if (deviation < 1.3) return '略有分歧';
    if (deviation < 1.45) return '莫衷一是';
    if (deviation < 1.6) return '各执一词';
    if (deviation < 1.75) return '你死我活';
    return '厨黑大战';
  }

  // 请求番剧详情
  Future querySubjectDetails(int subjectId) async {
    Subjects result = await BangumiNet.bangumiSubject(subjectId);
    subjects.value = result;
    production.value = getInfobox(result.infobox!, '製作');
    // 标签列表
    tags.value = result.tags.map((tag) => tag.name).toList();
    // 标准差
    deviation.value =
        MathUtils.calculateStandardDeviation(result.rating.total, result.rating.count, result.rating.score);
    dispute.value = getDispute(deviation.value);
    return result;
  }
}

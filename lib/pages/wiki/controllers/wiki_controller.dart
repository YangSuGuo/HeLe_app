import 'dart:developer';

import 'package:get/get.dart';
import 'package:hele_app/common/utils/math_utils.dart';
import 'package:hele_app/db/database/app_database.dart';
import 'package:hele_app/http/bangumi_net.dart';
import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/model/character_list/character_list.dart';
import 'package:hele_app/model/derivation/related_works_query.dart';
import 'package:hele_app/model/infobox.dart';
import 'package:hele_app/model/person_career/person_career.dart';
import 'package:hele_app/model/subjects/subjects.dart';

class WikiController extends GetxController {
  late LegacySubjectSmall legacySubjectSmall; // 番剧信息
  List<String> tags = []; // 标签列表
  final AppDatabase db = Get.find<AppDatabase>(); // 获取数据库实例

  // 组件状态
  RxBool recommendation = false.obs; // todo 推荐 占位
  RxBool mark = false.obs; // 标记
  RxBool favorite = false.obs; // 收藏

  // 番剧信息
  int subjectId = 0;
  String title = '';
  String imgUrl = '';
  RxString production = ''.obs;

  // 标准差
  RxDouble deviation = 0.0.obs;
  RxString dispute = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    // 番剧信息
    legacySubjectSmall = Get.arguments['bangumiItem'];
    subjectId = legacySubjectSmall.id!;
    title = legacySubjectSmall.nameCn != "" || legacySubjectSmall.name != ""
        ? legacySubjectSmall.nameCn != ""
            ? legacySubjectSmall.nameCn!
            : legacySubjectSmall.name!
        : "获取失败！";
    imgUrl = legacySubjectSmall.images?.large ?? "";

    // 组件状态
    mark.value = await db.subjectsStarDao.isSubjectExists(subjectId) ?? false;
    favorite.value = await db.subjectsStarDao.isSubjectCollectedById(subjectId, true) ?? false;
    log("标记状态：${mark.value}");
    log("收藏状态：${favorite.value}");
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

  // 获取副标题
  String? getSubTitle(String? subtitle, List<PersonCareer>? personCareerList) {
    if (subtitle != null && subtitle != "") {
      return subtitle;
    } else if (personCareerList != null && !personCareerList.isNotEmpty) {
      if (personCareerList.first != "" && personCareerList.first.name != "") {
        return personCareerList.first.name;
      }
    }
    return "暂无";
  }

  /////////////////////////////////////////////////////////////////////////////

  /////////////////////////////////////////////////////////////////////////////
  // 请求条目详情
  Future<Subjects> querySubjectDetails(int subjectId) async {
    Subjects result = await BangumiNet.bangumiSubject(subjectId);
    production.value = getInfobox(result.infobox!, '製作');
    // 标签列表
    tags = result.tags.map((tag) => tag.name).toList();
    // 计算标准差
    deviation.value =
        MathUtils.calculateStandardDeviation(result.rating.total, result.rating.count, result.rating.score);
    dispute.value = getDispute(deviation.value);
    return result;
  }

  // 请求条目人物信息列表
  Future<List<CharacterList>> querySubjectCharacterList(int subjectId) async {
    List<CharacterList> resultCharacterList = await BangumiNet.bangumiSubjectCharacterList(subjectId);
    return resultCharacterList;
  }

  // 请求条目演员信息列表
  Future<List<PersonCareer>> querySubjectPersons(int subjectId) async {
    List<PersonCareer> resultPersons = await BangumiNet.bangumiSubjectPersons(subjectId);
    return resultPersons;
  }

  // 请求条目衍生相关作品
  Future<List<RelatedWorksQuery>> querySubjectDerivation(int subjectId) async {
    List<RelatedWorksQuery> resultDerivation = await BangumiNet.bangumiSubjectDerivation(subjectId);
    return resultDerivation;
  }
}

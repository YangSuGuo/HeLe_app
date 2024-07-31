import 'dart:developer';

import 'package:get/get.dart';
import 'package:hele_app/common/utils/math_utils.dart';
import 'package:hele_app/db/database/app_database.dart';
import 'package:hele_app/db/database/entity/subjects_star.dart';
import 'package:hele_app/db/database/entity/subjects_user_tags.dart';
import 'package:hele_app/http/bangumi_net.dart';
import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/model/character_list/character_list.dart';
import 'package:hele_app/model/derivation/related_works_query.dart';
import 'package:hele_app/model/infobox.dart';
import 'package:hele_app/model/person_career/person_career.dart';
import 'package:hele_app/model/subjects/subjects.dart';

class WikiController extends GetxController {
  late final LegacySubjectSmall legacySubjectSmall; // 番剧信息
  late final RxList<String> tags = <String>[].obs; // 标签列表
  final AppDatabase db = Get.find<AppDatabase>(); // 获取数据库实例

  // 组件状态
  RxBool recommendation = false.obs; // todo 推荐 占位
  RxBool mark = false.obs; // 标记
  RxBool favorite = false.obs; // 收藏

  // 用户评分
  RxDouble userRating = 0.0.obs;
  RxString qualityRating = ''.obs;

  // 用户标签
  late final RxList<SubjectsUserTags> userTags = <SubjectsUserTags>[].obs;
  RxList<SubjectsUserTags> userActiveTag = <SubjectsUserTags>[].obs;

  // 标签激活状态
  RxList<bool> isUserTags = <bool>[].obs;
  RxList<bool> isTags = <bool>[].obs;

  // 是否隐藏
  RxBool isHidden = false.obs;

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

    if (false) {
      SubjectsUserTags tags = SubjectsUserTags(
        tag: "·测试-1·",
        creationTime: DateTime.now().millisecondsSinceEpoch,
      );

      await db.subjectsUserTagsDao.insertTag(tags);
    }

    // 初始化评分评价
    qualityRating.value = getRecommendation(0.0);

    // 组件状态
    mark.value = await db.subjectsStarDao.isSubjectExists(subjectId) ?? false;
    favorite.value = await db.subjectsStarDao.isSubjectCollectedById(subjectId, true) ?? false;
    log("标记状态：${mark.value}");
    log("收藏状态：${favorite.value}");

    userTags.value = await db.subjectsUserTagsDao.findAllTags();
    log(userTags[0].tag);
    // 标签激活状态

    // todo 标签激活状态
    // 1. 创建 tags 长度一致的 bool 列表
    // 2. 遍历 userTags 列表，将每个标签的 tag 值与 tags 列表进行比较，如果存在则将对应的 bool 值设为 true，否则设为 false
    syncUserActiveTags();
  }

  // 初始化激活标签
  void syncUserActiveTags() {
    // 初始化列表
    isTags.value = List.filled(tags.length, false);
    isUserTags.value = List.filled(userTags.length, false);

    log(isTags.length.toString());

    if (userActiveTag.isEmpty) return;

    // 初始化激活标签
    for (var activeTag in userActiveTag) {
      int indexInOfficialTags = tags.indexOf(activeTag.tag);
      isTags[indexInOfficialTags] = true;

      int indexInCustomTags = userTags.indexWhere((tag) => tag.tag == activeTag.tag);
      isUserTags[indexInCustomTags] = true;
    }
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

  // 计算推荐度
  String getRecommendation(double deviation) {
    if (deviation == 0) return '¬‿¬';
    if (deviation <= 0.5) return '不忍直视';
    if (deviation <= 1) return '很差';
    if (deviation <= 1.5) return '差';
    if (deviation <= 2) return '较差';
    if (deviation <= 2.5) return '不过不失';
    if (deviation <= 3) return '还行';
    if (deviation <= 3.5) return '推荐';
    if (deviation <= 4) return '力荐';
    if (deviation <= 4.5) return '神作';
    if (deviation <= 5) return '超神作';
    return '-';
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

  // 添加标签
  Future<void> addTag(bool isUserTag, int index) async {
    List<String> sourceTags = isUserTag ? userTags.map((tag) => tag.tag).toList() : tags;

    isUserTag ? isUserTags[index] = !isUserTags[index] : isTags[index] = !isTags[index];

    if (isUserTag ? isUserTags[index] : isTags[index]) {
      final SubjectsUserTags newTag = SubjectsUserTags(
        tag: sourceTags[index],
        creationTime: DateTime.now().millisecondsSinceEpoch,
      );
      userActiveTag.add(newTag);
      log("添加标签：${sourceTags[index]}");
    } else {
      userActiveTag.removeWhere((tag) => tag.tag == sourceTags[index]);
      log("移除标签：${sourceTags[index]}");
    }
  }

  // 保存到数据库
  Future<void> save(Subjects subject) async {
    SubjectsStar subjectsStar = subject.toSubjectsStar(
      isHidden: isHidden.value,
      status: 2,
      userRating: userRating.value,
      tags: userActiveTag.map((tag) => tag.tag).toList(),
    );
  }

  /////////////////////////////////////////////////////////////////////////////

  // 请求条目详情
  Future<Subjects> querySubjectDetails(int subjectId) async {
    Subjects result = await BangumiNet.bangumiSubject(subjectId);
    production.value = getInfobox(result.infobox!, '製作');
    // 标签列表
    tags.value = result.tags.map((tag) => tag.name).toList();
    isTags.value = List.filled(tags.length, false);
    log(tags.toString());
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

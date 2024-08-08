import 'dart:developer';

import 'package:get/get.dart';
import 'package:hele_app/common/utils/evaluation_utils.dart';
import 'package:hele_app/common/utils/math_utils.dart';
import 'package:hele_app/db/database/app_database.dart';
import 'package:hele_app/db/database/entity/subjects_history.dart';
import 'package:hele_app/db/database/entity/subjects_star.dart';
import 'package:hele_app/db/database/entity/subjects_user_tags.dart';
import 'package:hele_app/http/bangumi_net.dart';
import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/model/character_list/character_list.dart';
import 'package:hele_app/model/derivation/related_works_query.dart';
import 'package:hele_app/model/person_career/person_career.dart';
import 'package:hele_app/model/subjects/subjects.dart';

class WikiController extends GetxController {
  late final LegacySubjectSmall legacySubjectSmall; // 番剧信息

  final AppDatabase db = Get.find<AppDatabase>(); // 获取数据库实例

  // 组件状态
  RxBool recommendation = false.obs; // todo 推荐 占位
  RxBool mark = false.obs; // 标记
  RxBool favorite = false.obs; // 收藏

  // 用户评分
  RxDouble userRating = 0.0.obs;
  RxString qualityRating = ''.obs;

  // 用户标签
  late final RxList<String> tags = <String>[].obs; // 标签列表
  late final RxList<SubjectsUserTags> userTags = <SubjectsUserTags>[].obs;

  // 标签激活状态
  RxList<String> userActiveTag = <String>[].obs;
  RxList<bool> isUserTags = <bool>[].obs;
  RxList<bool> isTags = <bool>[].obs;

  // 番剧标注进度
  int subjectType = 0;

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
    // 初始化评分评价
    qualityRating.value = EvaluationUtils.getRecommendation(0.0);

    // 组件状态
    mark.value = await db.subjectsStarDao.isSubjectExists(subjectId) ?? false;
    favorite.value = await db.subjectsStarDao.isSubjectCollectedById(subjectId, true) ?? false;
    userTags.value = await db.subjectsUserTagsDao.findAllTags();

    log("标记状态：${mark.value}");
    log("收藏状态：${favorite.value}");

    // isTags.value = List.filled(tags.length, false);
    isUserTags.value = List.filled(userTags.length, false);

    // 初始化激活列表
    if (mark.value) {
      String? s = await db.subjectsStarDao.getTagsForSubject(subjectId);
      if (s != null) {
        userActiveTag.value = EvaluationUtils.toTagsList(s);
        log("激活列表：${userActiveTag.toString()}");
      }
    }
  }

  // 初始化激活标签
  void syncUserActiveTags() {
    for (String activeTag in userActiveTag) {
      // 查找官方标签中的索引
      int indexInOfficialTags = tags.indexOf(activeTag);
      log(activeTag.toString());
      log(indexInOfficialTags.toString());
      if (indexInOfficialTags != -1) {
        isTags[indexInOfficialTags] = true;
      }

      // 查找用户自定义标签中的索引
      int indexInCustomTags = userTags.indexWhere((tag) => tag.tag == activeTag);
      if (indexInCustomTags != -1) {
        isUserTags[indexInCustomTags] = true;
      }
    }
  }

  /////////////////////////////////////////////////////////////////////////////

  // 添加标签
  Future<void> addTag(bool isUserTag, int index) async {
    List<String> sourceTags = isUserTag ? userTags.map((tag) => tag.tag).toList() : tags;

    isUserTag ? isUserTags[index] = !isUserTags[index] : isTags[index] = !isTags[index];

    if (isUserTag ? isUserTags[index] : isTags[index]) {
      userActiveTag.add(sourceTags[index]);
      log("添加标签：${sourceTags[index]}");
    } else {
      userActiveTag.removeWhere((tag) => tag == sourceTags[index]);
      log("移除标签：${sourceTags[index]}");
    }
  }

  // 保存到数据库
  Future<void> save(Subjects subject, bool isCollected) async {
    SubjectsStar subjectsStar = subject.toSubjectsStar(
        isHidden: isHidden.value,
        status: subjectType,
        userRating: userRating.value,
        tags: userActiveTag,
        isCollected: isCollected);
    // 更新 or 插入
    if (mark.value) {
      await db.subjectsStarDao.updateSubject(subjectsStar);
      log("更新标注");
    } else {
      await db.subjectsStarDao.addSubject(subjectsStar);
      mark.value = !mark.value;
      log("添加标注");
    }
  }

  // 添加历史记录
  Future<void> addHistory(Subjects subject) async {
    SubjectsHistory subjectsHistory = subject.toSubjectsHistory();
    await db.subjectsHistoryDao.insertSubjectsHistory(subjectsHistory);
  }

  /////////////////////////////////////////////////////////////////////////////

  // 请求条目详情
  Future<Subjects> querySubjectDetails(int subjectId) async {
    Subjects result = await BangumiNet.bangumiSubject(subjectId);
    production.value = EvaluationUtils.getInfobox(result.infobox!, '製作');
    // 标签列表
    tags.value = result.tags.map((tag) => tag.name).toList();
    isTags.value = List.filled(tags.length, false);

    // 初始化激活
    if (userActiveTag.isNotEmpty) {
      syncUserActiveTags();
    }
    log(tags.toString());

    // 添加历史记录
    addHistory(result);

    // 计算标准差
    deviation.value =
        MathUtils.calculateStandardDeviation(result.rating.total, result.rating.count, result.rating.score);
    dispute.value = EvaluationUtils.getDispute(deviation.value);
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

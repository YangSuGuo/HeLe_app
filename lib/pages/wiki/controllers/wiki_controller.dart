import 'package:get/get.dart';
import 'package:hele_app/common/utils/math_utils.dart';
import 'package:hele_app/http/bangumi_net.dart';
import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/model/character_list/character_list.dart';
import 'package:hele_app/model/derivation/related_works_query.dart';
import 'package:hele_app/model/infobox.dart';
import 'package:hele_app/model/person_career/person_career.dart';
import 'package:hele_app/model/subjects/subjects.dart';

class WikiController extends GetxController {
  late LegacySubjectSmall legacySubjectSmall; // 番剧信息
  // Rxn<Subjects> subjects = Rxn<Subjects>(); // 条目信息
  // RxList<CharacterList> characterList = <CharacterList>[].obs; // 角色列表
  // RxList<PersonCareer> person = <PersonCareer>[].obs; // 演员信息
  // RxList<RelatedWorksQuery> derivation = <RelatedWorksQuery>[].obs; // 衍生相关作品
  List<String> tags = []; // 标签列表

  int subjectId = 0;
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
    subjectId = legacySubjectSmall.id!;

    // querySubjectDetails(subjectId); // 获取条目详情
    // querySubjectCharacterList(subjectId); // 获取角色列表
    // querySubjectPersons(subjectId); // 获取演员信息
    // querySubjectDerivation(subjectId); // 获取衍生相关作品

    title = legacySubjectSmall.nameCn != "" || legacySubjectSmall.name != ""
        ? legacySubjectSmall.nameCn != ""
            ? legacySubjectSmall.nameCn!
            : legacySubjectSmall.name!
        : "获取失败！";
    imgUrl = legacySubjectSmall.images?.large ?? "" /*?? 'https://img.picui.cn/free/2024/07/01/66824a43e0e23.png'*/;
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

  String? getSubTitle(String? subtitle, List<PersonCareer>? personCareerList) {
    if (subtitle != null && subtitle != "") {
      return subtitle;
    } else if (personCareerList != null && !personCareerList.isNotEmpty) {
      if(personCareerList.first != "" && personCareerList.first.name != ""){
        return personCareerList.first.name;
      }
    }
    return "暂无";
  }

  // 请求条目详情
  Future<Subjects>  querySubjectDetails(int subjectId) async {
    Subjects result = await BangumiNet.bangumiSubject(subjectId);
    // subjects.value = result;
    production.value = getInfobox(result.infobox!, '製作');
    // 标签列表
    tags = result.tags.map((tag) => tag.name).toList();
    // 标准差
    deviation.value =
        MathUtils.calculateStandardDeviation(result.rating.total, result.rating.count, result.rating.score);
    dispute.value = getDispute(deviation.value);
    return result;
  }

  // 请求条目人物信息列表
  Future<List<CharacterList>> querySubjectCharacterList(int subjectId) async {
    List<CharacterList> resultCharacterList = await BangumiNet.bangumiSubjectCharacterList(subjectId);

    // characterList.value = resultCharacterList;
    return resultCharacterList;
  }

  // 请求条目演员信息列表
  Future<List<PersonCareer>> querySubjectPersons(int subjectId) async {
    List<PersonCareer> resultPersons = await BangumiNet.bangumiSubjectPersons(subjectId);

    // person.value = resultPersons;
    return resultPersons;
  }

  // 请求条目衍生相关作品
  Future<List<RelatedWorksQuery>> querySubjectDerivation(int subjectId) async {
    List<RelatedWorksQuery> resultDerivation = await BangumiNet.bangumiSubjectDerivation(subjectId);

    // derivation.value = resultDerivation;
    return resultDerivation;
  }
}

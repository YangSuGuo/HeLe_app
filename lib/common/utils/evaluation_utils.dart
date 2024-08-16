import 'package:hele_app/model/infobox.dart';
import 'package:hele_app/model/person_career/person_career.dart';

class EvaluationUtils {
  // 计算争议度
  static String getDispute(double deviation) {
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
  static String getRecommendation(double deviation) {
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
  static String? getSubTitle(String? subtitle, List<PersonCareer>? personCareerList) {
    if (subtitle != null && subtitle != "") {
      return subtitle;
    } else if (personCareerList != null && !personCareerList.isNotEmpty) {
      if (personCareerList.first != "" && personCareerList.first.name != "") {
        return personCareerList.first.name;
      }
    }
    return "暂无";
  }

  // 获取infobox
  static String getInfobox(List<Item> infobox, String key) {
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

  // tags 字符串转换为列表
  static List<String> toTagsList(String tag) {
    if (tag != "[]") {
      String trimmedString = tag.substring(1, tag.length - 1).trim();
      List<String> tags = trimmedString.split(', ').map((tag) => tag.trim()).toList();
      return tags;
    }
    return [];
  }
}

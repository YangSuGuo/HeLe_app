import 'dart:developer';

import 'package:get/get.dart';
import 'package:hele_app/http/bangumi_net.dart';
import 'package:hele_app/model/character_list/character_involvement.dart';
import 'package:hele_app/model/wiki_detail.dart';

class ExtraInfoControllers extends GetxController {
  // 1: CharacterList, 2: PersonCareer
  late int type = 1;
  late WikiDetail wikiDetail;
  late List<CharacterInvolvement> involvement = <CharacterInvolvement>[];
  late int id;
  String header = '';
  List<Map<String, dynamic>> infoList = [];

  @override
  void onInit() {
    super.onInit();
    type = Get.arguments['type'];
    id = Get.arguments['id'];
    header = Get.arguments['name'];
  }

  // 请求条目演员信息列表
  Future<WikiDetail> querySubjectInfo(int id, int type) async {
    if (type == 1) {
      wikiDetail = await BangumiNet.bangumiCharacterInfo(id);
      infoList = wikiDetail.infobox!;
      log("角色信息");
      log(infoList.toString());
      return wikiDetail;
    } else {
      wikiDetail = await BangumiNet.bangumiPersonsInfo(id);
      infoList = wikiDetail.infobox!;
      log("人物信息");
      log(infoList.toString());
      return wikiDetail;
    }
  }

  Future<List<CharacterInvolvement>> querySubjectInvolvement(int id, int type) async {
    if (type == 1) {
      involvement = await BangumiNet.bangumiCharacterInvolvement(id);
    } else {
      involvement = await BangumiNet.bangumiPersonsInvolvement(id);
    }
    log("list：${involvement.length.toString()}");
    return involvement;
  }
}

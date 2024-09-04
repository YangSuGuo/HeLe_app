import 'dart:developer';

import 'package:get/get.dart';
import 'package:hele_app/http/bangumi_net.dart';
import 'package:hele_app/model/wiki_detail.dart';

class ExtraInfoControllers extends GetxController {
  // 1: CharacterList, 2: PersonCareer
  late int type = 1;
  late WikiDetail wikiDetail;
  late int id;
  String header = '';

  @override
  void onInit() {
    super.onInit();
    type = Get.arguments['type'];
    id = Get.arguments['id'];
    type == 1 ? header = "角色信息" : header = "人物信息";
  }

  // 请求条目演员信息列表
  Future<WikiDetail> querySubjectInfo(int id, int type) async {
    if (type == 1) {
      wikiDetail = await BangumiNet.bangumiCharacterInfo(id);
      log("角色信息");
      return wikiDetail;
    } else {
      wikiDetail = await BangumiNet.bangumiPersonsInfo(id);
      log("人物信息");
      return wikiDetail;
    }
  }
}

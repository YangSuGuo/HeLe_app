import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/utils/date_utils.dart';
import 'package:hele_app/http/bangumi_net.dart';
import 'package:hele_app/model/search/query_parameters.dart';
import 'package:hele_app/model/search/request_body.dart';
import 'package:hele_app/model/search/search.dart';

class RankController extends GetxController with GetSingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late RxList<Datum> rankList = <Datum>[].obs;
  List<String> tags = ["书籍", "动漫", "电影", "电视剧"];
  late RxInt type = 2.obs;
  late int limit = 50;
  late int offset = 0;

  late DateTime date;
  late DateTime startTime = DateTime.now();
  late DateTime endTime = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    date = DateTime.now();
  }

  // 重置时间
  void restoreDefaultFilters() {
    offset = 0;
    getRankingList([]);
  }

  // 筛选
  void applySearchFilters() {
    if (!startTime.isAfter(date) && endTime.isAfter(startTime)) {
      String start = DateUtils.formatDate(startTime);
      String end = DateUtils.formatDate(endTime);
      List<String> airDate = [">$start", "<$end"];
      getRankingList(airDate);
    } else {
      offset = 0;
      getRankingList([]);
    }
  }

  // 选择类型
  void onSelected(bool value, int index) {
    switch (index) {
      case 0: // 书籍
        type.value = 1;
        offset = 0;
        // getRankingList([]);
        break;
      case 1: // 动漫
        type.value = 2;
        offset = 0;
        // getRankingList([]);
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
    }
  }

  // 下一页
  Future next() async {
    offset += 50;
    await getRankingList([]);
  }

  // 获取排行榜数据
  Future getRankingList(List<String>? airDate) async {
    // 构建请求体
    final RequestBody requestBody = RequestBody(
      keyword: "",
      sort: Sort.RANK,
      filter: Filter(type: [type.value], rank: [">0", "<=100"], airDate: airDate ?? []),
    );

    final QueryParameters queryParameters = QueryParameters(
      limit: limit,
      offset: offset,
    );

    var result = await BangumiNet.getHotRecommendedComics(queryParameters, requestBody);
    List<Datum>? res = result.data;
    if (offset > 0) {
      rankList.addAll(res ?? []);
    } else {
      rankList.value = res ?? [];
    }
    log(rankList.length.toString());
    return res;
  }
}

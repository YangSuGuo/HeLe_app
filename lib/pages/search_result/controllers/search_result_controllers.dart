import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hele_app/http/bangumi_net.dart';
import 'package:hele_app/model/search/query_parameters.dart';
import 'package:hele_app/model/search/request_body.dart';
import 'package:hele_app/model/search/search.dart';

class SearchResultControllers extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late RxList<Datum> searchResults = <Datum>[].obs;
  late int limit = 50;
  late int offset = 0;

  // 筛选条件
  RxString keyword = ''.obs;
  late RxInt type = 0.obs;

  // late DateTime startTime = DateTime.now();
  // late DateTime endTime = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    keyword.value = Get.arguments['keyword'];
    type.value = Get.arguments['type'] ?? 0;
    // startTime = Get.arguments['startTime'];
    // endTime = Get.arguments['endTime'];
  }

  // 下一页
  // todo 暂未实现
  Future next() async {
    offset += 50;
  }

  // 获取搜索结果
  Future getSearchResults() async {
    // 构建请求体
    final RequestBody requestBody = RequestBody(
      keyword: keyword.value,
      sort: Sort.MATCH,
      filter: type.value != 0 ? Filter(type: [type.value]) : null,
    );

    final QueryParameters queryParameters = QueryParameters(
      limit: limit,
      offset: offset,
    );

    var result =
        await BangumiNet.getHotRecommendedComics(queryParameters, requestBody);
    List<Datum>? res = result.data;

    if (offset > 0) {
      searchResults.addAll(res ?? []);
    } else {
      searchResults.value = res ?? [];
    }
    log(searchResults.length.toString());

    return res;
  }
}

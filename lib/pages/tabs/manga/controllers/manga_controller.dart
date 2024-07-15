import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hele_app/http/bangumi_net.dart';
import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/model/search/query_parameters.dart';
import 'package:hele_app/model/search/request_body.dart';
import 'package:hele_app/model/search/search.dart';

class MangaController extends GetxController {
  final ScrollController scrollController = ScrollController();
  int limit = 20;
  int offset = 0;
  RxList<LegacySubjectSmall> bangumiList = <LegacySubjectSmall>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  // 触底加载
  Future next() async {
    offset += 20;
    await getHotRecommendations();
  }

  // 获取漫画热门推荐
  Future getHotRecommendations() async {
    final QueryParameters queryParameters = QueryParameters(
      limit: limit,
      offset: offset,
    );

    final RequestBody requestBody = RequestBody(
      filter: Filter(
        tag: ["漫画"],
        type: [1],
      ),
      keyword: "",
      sort: Sort.HEAT,
    );

    var result = await BangumiNet.getHotRecommendedComics(queryParameters,requestBody);
    List<Datum>? data = result.data;
    List<LegacySubjectSmall>? res = data?.map((e) => e.toLegacySubjectSmall()).toList();

    if (offset > 0) {
      bangumiList.addAll(res ?? []);
    } else {
      bangumiList.value = res ?? [];
    }
    return res;
  }
}

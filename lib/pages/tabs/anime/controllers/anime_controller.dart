import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hele_app/common/utils/date_utils.dart';
import 'package:hele_app/http/bangumi_net.dart';
import 'package:hele_app/model/calendar.dart';

class AnimeController extends GetxController {
  DateTime dateTime = DateTime.now();
  RxList<Calendar> bangumiCalendar = <Calendar>[].obs;
  RxInt bangumiItemsLength = 0.obs; // 追番表长度

  RxInt dayOfWeekIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    queryBangumiCalendarFeed();


    dayOfWeekIndex.value = DateUtils.getDayOfWeekIndex() - 1; // 星期几 id


    // log(todayOfWeek.toString());
    log(dayOfWeekIndex.toString());
  }

  // 请求追番表
  Future queryBangumiCalendarFeed() async {
    var result = await BangumiNet.bangumiCalendar();
    bangumiCalendar.value = result;
    // todo 长度 开发测试
    bangumiItemsLength.value = result[dayOfWeekIndex.value].items!.length;
    log(bangumiCalendar[dayOfWeekIndex.value].items![0].nameCn.toString());
    log(bangumiItemsLength.toString());
  }
}

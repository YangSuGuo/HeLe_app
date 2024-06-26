import 'dart:developer';

import 'package:get/get.dart';
import 'package:hele_app/common/utils/date_utils.dart';
import 'package:hele_app/http/bangumi_net.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
import 'package:hele_app/model/calendar.dart';

class AnimeController extends GetxController {
  DateTime dateTime = DateTime.now();
  RxList<Calendar> bangumiCalendar = <Calendar>[].obs;
  RxInt bangumiItemsLength = 0.obs; // 追番表长度

  final RxInt TODAY_ID = 0.obs;
  RxInt dayOfWeekIndex = 0.obs;
  RxInt initialValue = 2.obs;

  RxString yesterday = S.of(Get.context!).tab_anime_calendar_yesterday.obs;
  RxString today = S.of(Get.context!).tab_anime_calendar_today.obs;
  RxString tomorrow = S.of(Get.context!).tab_anime_calendar_tomorrow.obs;

  @override
  void onInit() {
    super.onInit();
    queryBangumiCalendarFeed();

    TODAY_ID.value = DateUtils.getDayOfWeekIndex();
    dayOfWeekIndex.value = DateUtils.getDayOfWeekIndex() - 1; // 星期几 id

    log(TODAY_ID.toString());
    log(dayOfWeekIndex.toString());
  }

  // 分段器改变事件
  tapSegmentChanger(v) async {
    switch (v) {
      case 1: // -
        if (TODAY_ID.value == 1) {
          dayOfWeekIndex.value = 6;
          log("当前索引：${dayOfWeekIndex.value}");
        } else if (TODAY_ID.value == 7) {
          dayOfWeekIndex.value = 0;
          log("当前索引：${dayOfWeekIndex.value}");
        } else {
          dayOfWeekIndex.value = TODAY_ID.value - 2;
          log("当前索引：${dayOfWeekIndex.value}");
        }
        break;
      case 2:
        dayOfWeekIndex.value = TODAY_ID.value - 1;
        log("当前索引：${dayOfWeekIndex.value}");
        break;
      case 3: // +
        if (TODAY_ID.value == 7) {
          dayOfWeekIndex.value = 0;
          log("当前索引：${dayOfWeekIndex.value}");
        } else {
          dayOfWeekIndex.value = TODAY_ID.value;
          log("当前索引：${dayOfWeekIndex.value}");
        }
        break;
    }
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

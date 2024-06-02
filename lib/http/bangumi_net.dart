import 'package:hele_app/model/calendar.dart';

import 'bangumi_api.dart';
import 'net/init.dart';

class BangumiNet {
  // 获取追番表
  static Future<List<Calendar>> bangumiCalendar() async {
    var res = await Request().get(BangumiApi.calendar);
    if (res.statusCode == 200) {
      List<dynamic> jsonData = res.data;
      List<Calendar> calendars = jsonData.map((item) => Calendar.fromJson(item)).toList();
      return calendars;
    } else {
      throw Exception('获取追番表数据失败');
    }
  }
}

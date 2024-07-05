import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/model/subjects/subjects.dart';

import 'bangumi_api.dart';
import 'net/init.dart';

class BangumiNet {
  // 获取追番表
  static Future<List<Calendar>> bangumiCalendar() async {
    var res = await Request().get(BangumiApi.calendar);
    if (res.statusCode == 200) {
      List<dynamic> jsonData = res.data;
      List<Calendar> calendars =
          jsonData.map((item) => Calendar.fromJson(item)).toList();
      return calendars;
    } else {
      throw Exception('获取追番表数据失败');
    }
  }

  // 获取影视条目信息
  static Future<Subjects> bangumiSubject(int subjectId) async {
    var res = await Request().get(BangumiApi.subject + subjectId.toString());
    if (res.statusCode == 200) {
      Subjects subjects = Subjects.fromJson(res.data);
      return subjects;
    } else {
      print("报错：$res");
      throw Exception('获取条目信息数据失败');
    }
  }
}

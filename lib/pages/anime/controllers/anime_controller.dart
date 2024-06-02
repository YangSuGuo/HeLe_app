import 'package:get/get.dart';
import 'package:hele_app/common/utils/date_utils.dart';
import 'package:hele_app/http/bangumi_net.dart';
import 'package:hele_app/model/calendar.dart';

class AnimeController extends GetxController {
  DateTime dateTime =DateTime.now();
  RxList<Calendar> bangumiCalendar = <Calendar>[].obs;

  @override
  void onInit() {
    super.onInit();
    queryBangumiCalendarFeed();
  }

  Future queryBangumiCalendarFeed() async {
    var result = await BangumiNet.bangumiCalendar();
    bangumiCalendar.value = result;
    print(bangumiCalendar.length);
  }
}

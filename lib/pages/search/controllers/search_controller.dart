import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hele_app/db/preference/preferences_db.dart';
import 'package:hele_app/routes/app_pages.dart';

class SearchPageController extends GetxController with GetTickerProviderStateMixin {
  final FocusNode searchFocusNode = FocusNode();
  Rx<TextEditingController> controller = TextEditingController().obs;

  // 搜索组件
  String hintText = '搜索';
  RxList<String> historyList = <String>[].obs;

  // 筛选条件
  RxString keyword = ''.obs;
  late RxInt type = 2.obs;
  List<String> tags = ["ALL", "书籍", "动漫", "电影", "电视剧"];
  late DateTime startTime = DateTime.now();
  late DateTime endTime = DateTime.now();

  @override
  void onInit() async {
    super.onInit();
    historyList.value = await PreferencesDB.db.getAppHistoryList();
  }

  // 清空搜索词
  void onClear() {
    if (keyword.value.isNotEmpty && controller.value.text != '') {
      controller.value.clear();
      keyword.value = '';
    }
  }

  // 清空历史记录
  Future<void> onClearHis() async {
    historyList.value = [];
    await PreferencesDB.db.setAppHistoryList([]);
  }

  // 搜索历史点击
  onTagClick(String value) {
    keyword.value = value;
    controller.value.text = value;
    submit();
  }

  // 提交搜索
  // 数组去重 【区分大小写】
  Future<void> submit() async {
    if (keyword.value.isNotEmpty) {
      List<String> history = historyList.value;
      history.removeWhere((item) => item == keyword.value);
      history.insert(0, keyword.value);
      if (historyList.value.length > 20) {
        historyList.removeLast();
        await PreferencesDB.db.setAppHistoryList(history);
        Get.toNamed(Routes.SEARCH_RESULT, arguments: {
          'keyword': keyword.value,
          'type': type.value,
          'startTime': startTime,
          'endTime': endTime,
        });
      } else {
        await PreferencesDB.db.setAppHistoryList(history);
        Get.toNamed(Routes.SEARCH_RESULT, arguments: {
          'keyword': keyword.value,
          'type': type.value,
          'startTime': startTime,
          'endTime': endTime,
        });
      }
    } else {
      SmartDialog.showToast('你是不是忘了什么？');
    }
  }
}

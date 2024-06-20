import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateUtils {
  // 转换时间戳并格式化为星期几
  static String getTodayOfWeekInChinese() {
    // 获取当前日期时间
    DateTime now = DateTime.now();
    Locale currentLocale = Localizations.localeOf(Get.context!);
    String currentLanguageCode = currentLocale.languageCode;
    final formatWeek = DateFormat('EEE', currentLanguageCode);
    return formatWeek.format(now);
  }

  /// 转换时间戳并格式化为星期几
  /// @return 返回 id
  static int getDayOfWeekIndex() {
    DateTime now = DateTime.now();
    int dayOfWeekIndex = now.weekday;
    return dayOfWeekIndex;
  }
}

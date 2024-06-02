import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateUtils {
  // 转换日期为星期几
  static String getTodayOfWeekInChinese() {
    // 获取当前日期时间
    DateTime now = DateTime.now();
    Locale currentLocale = Localizations.localeOf(Get.context!);
    String currentLanguageCode = currentLocale.languageCode;

    // 创建一个 DateFormat 对象，用于格式化星期
    final formatWeek = DateFormat('EEEE', currentLanguageCode);

    // 格式化星期并返回
    return formatWeek.format(now);
  }
}

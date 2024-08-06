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

  /// 获取当前季度的起始日期
  /// 如果当前正好是季度开始时间，则返回上一季度时间
  static String getAdjustedQuarterStartDate() {
    DateTime now = DateTime.now();
    int currentMonth = now.month;

    // 特殊处理1月份的情况
    if (currentMonth == 1) {
      DateTime previousYearQ4Start = DateTime(now.year - 1, 10, 1);
      return DateFormat('yyyy-MM-dd').format(previousYearQ4Start);
    } else {
      // 计算当前季度的起始月份
      int quarterStartMonth = (currentMonth - 1) ~/ 3 * 3 + 1;

      // 判断是否为当前季度的第一天
      if (quarterStartMonth == currentMonth && now.day == 1) {
        // 减去3个月获取上一季度
        DateTime previousQuarterStart =
            DateTime(now.year, quarterStartMonth - 3, 1);
        return DateFormat('yyyy-MM-dd').format(previousQuarterStart);
      } else {
        // 不是则直接返回当前季度的开始日期
        DateTime thisQuarterStart = DateTime(now.year, quarterStartMonth, 1);
        return DateFormat('yyyy-MM-dd').format(thisQuarterStart);
      }
    }
  }

  /// 格式化时间 2023-01-01
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}

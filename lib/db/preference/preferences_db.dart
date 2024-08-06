import 'package:flutter/material.dart';
import 'package:hele_app/themes/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

// todo 更换更好的 hive: ^2.2.3
// 单例模式 存储APP关键设置
class PreferencesDB {
  PreferencesDB._();

  static final PreferencesDB db = PreferencesDB._();
  SharedPreferences? _db;

  Future<SharedPreferences> get database async =>
      _db ??= await SharedPreferences.getInstance();

  /// ** APP相关 **
  static const appThemeDarkMode = "themes"; // app主题
  static const appMultipleThemesMode = 'appMultipleThemesMode'; // 多主题
  static const appLocale = 'appLocale'; // 语言
  static const appIsLocaleSystem = 'appIsLocaleSystem'; // 语言是否跟随系统

  /// ** 搜索相关 **
  static const appHistoryList = "historyList"; // 搜索历史

  /// 设置-主题外观模式
  Future<bool> setAppThemeDarkMode(ThemeMode themeMode) async {
    final SharedPreferences prefs = await database;
    return prefs.setString(appThemeDarkMode, themeMode.name);
  }

  /// 获取-主题外观模式
  Future<ThemeMode> getAppThemeDarkMode() async {
    final SharedPreferences prefs = await database;
    final String themeDarkMode = prefs.getString(appThemeDarkMode) ?? 'system';
    return darkThemeMode(themeDarkMode);
  }

  /// 设置-多主题模式
  Future<bool> setMultipleThemesMode(String value) async {
    final SharedPreferences prefs = await database;
    return prefs.setString(appMultipleThemesMode, value);
  }

  /// 获取-多主题模式
  Future<String> getMultipleThemesMode() async {
    final SharedPreferences prefs = await database;
    return prefs.getString(appMultipleThemesMode) ?? 'default';
  }

  /// 设置-APP地区语言
  Future<bool> setAppLocale(Locale locale) async {
    final SharedPreferences prefs = await database;
    print(locale.toLanguageTag());
    return prefs.setString(appLocale, locale.toLanguageTag());
  }

  /// 获取-APP地区语言
  Future<Locale> getAppLocale() async {
    final SharedPreferences prefs = await database;
    final String getAppLocale = prefs.getString(appLocale) ?? 'zh';
    final appLocaleList = getAppLocale.split('-');
    return Locale(
      appLocaleList[0],
      appLocaleList.length > 1 ? appLocaleList[1] : '',
    );
  }

  /// 设置-APP地区语言是否跟随系统
  Future<bool> setAppIsLocaleSystem(bool isLocaleSystem) async {
    final SharedPreferences prefs = await database;
    return prefs.setBool(appIsLocaleSystem, isLocaleSystem);
  }

  /// 获取-APP地区语言是否跟随系统
  Future<bool> getAppIsLocaleSystem() async {
    final SharedPreferences prefs = await database;
    return prefs.getBool(appIsLocaleSystem) ?? true;
  }

  // 设置-APP搜索历史
  Future<bool> setAppHistoryList(List<String> value) async {
    final SharedPreferences prefs = await database;
    return prefs.setStringList(appHistoryList, value);
  }

  // 获取-APP搜索历史
  Future<List<String>> getAppHistoryList() async {
    final SharedPreferences prefs = await database;
    return prefs.getStringList(appHistoryList) ?? [];
  }
}

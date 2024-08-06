import 'package:flutter/material.dart';
import 'package:hele_app/db/preference/preferences_db.dart';

/// App相关
class ApplicationProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // 主题模式
  String _multipleThemesMode = 'default'; // 多主题模式
  bool _localeSystem = true; // 语言是否跟随系统
  Locale _locale = const Locale('zh_CH'); // 语言

  ThemeMode get themeMode => _themeMode;

  String get multipleThemesMode => _multipleThemesMode;

  Locale get locale => _locale;

  bool get localeSystem => _localeSystem;

  /// 获取-主题模式
  void loadThemeMode() async {
    _themeMode = await PreferencesDB.db.getAppThemeDarkMode();
    notifyListeners();
  }

  /// 设置-主题模式
  set themeMode(ThemeMode themeMode) {
    PreferencesDB.db.setAppThemeDarkMode(themeMode);
    _themeMode = themeMode;
    notifyListeners();
  }

  /// 获取-多主题模式
  void loadMultipleThemesMode() async {
    _multipleThemesMode = await PreferencesDB.db.getMultipleThemesMode();
    notifyListeners();
  }

  /// 设置-多主题模式
  set multipleThemesMode(String multipleThemesMode) {
    PreferencesDB.db.setMultipleThemesMode(multipleThemesMode);
    _multipleThemesMode = multipleThemesMode;
    notifyListeners();
  }

  /// 获取-语言是否跟随系统
  void loadLocaleSystem() async {
    _localeSystem = await PreferencesDB.db.getAppIsLocaleSystem();
    notifyListeners();
  }

  /// 设置-语言是否跟随系统
  set localeSystem(bool localeSystem) {
    PreferencesDB.db.setAppIsLocaleSystem(localeSystem);
    _localeSystem = localeSystem;
    notifyListeners();
  }

  /// 获取-语言
  void loadLocale() async {
    _locale = await PreferencesDB.db.getAppLocale();
    notifyListeners();
  }

  /// 设置-语言
  set locale(Locale locale) {
    localeSystem = false;
    PreferencesDB.db.setAppLocale(locale);
    _locale = locale;
    notifyListeners();
  }
}

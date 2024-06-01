import 'package:flutter/material.dart';
import 'package:hele_app/themes/app_style/colors/app_theme_color_scheme.dart';
import 'package:hele_app/themes/multiple_themes_mode/material_scheme.dart';

enum AppMultipleThemesMode { light, dark }

/// 多主题
Map<String, Map<AppMultipleThemesMode, ThemeData>> appMultipleThemesMode = {
  'default': {
    AppMultipleThemesMode.light:
        AppThemeUtils.themeUtils(AppThemeColorScheme.lightDefaultScheme()),
    AppMultipleThemesMode.dark:
        AppThemeUtils.themeUtils(AppThemeColorScheme.darkDefaultScheme()),
  },
  'red': {
    AppMultipleThemesMode.light:
        AppThemeUtils.themeUtils(AppThemeColorScheme.lightRedScheme()),
    AppMultipleThemesMode.dark:
        AppThemeUtils.themeUtils(AppThemeColorScheme.darkRedScheme()),
  },
  'orange': {
    AppMultipleThemesMode.light:
        AppThemeUtils.themeUtils(AppThemeColorScheme.lightOrangeScheme()),
    AppMultipleThemesMode.dark:
        AppThemeUtils.themeUtils(AppThemeColorScheme.darkOrangeScheme()),
  },
  'yellow': {
    AppMultipleThemesMode.light:
        AppThemeUtils.themeUtils(AppThemeColorScheme.lightYellowScheme()),
    AppMultipleThemesMode.dark:
        AppThemeUtils.themeUtils(AppThemeColorScheme.darkYellowScheme()),
  },
  'cyan': {
    AppMultipleThemesMode.light:
        AppThemeUtils.themeUtils(AppThemeColorScheme.lightCyanScheme()),
    AppMultipleThemesMode.dark:
        AppThemeUtils.themeUtils(AppThemeColorScheme.darkCyanScheme()),
  }
};

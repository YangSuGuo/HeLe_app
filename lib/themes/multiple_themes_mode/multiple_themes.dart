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
    // AppMultipleThemesMode.light: AppTheme,
    // AppMultipleThemesMode.dark: AppTheme,
  },
  'orange': {
    // AppMultipleThemesMode.light: AppTheme,
    // AppMultipleThemesMode.dark: AppTheme,
  },
  'yellow': {
    // AppMultipleThemesMode.light: AppTheme,
    // AppMultipleThemesMode.dark: AppTheme,
  },
  'green': {
    // AppMultipleThemesMode.light: AppTheme,
    // AppMultipleThemesMode.dark: AppTheme,
  },
  'cyan': {
    // AppMultipleThemesMode.light: AppTheme,
    // AppMultipleThemesMode.dark: AppTheme,
  },
  'purple': {
    // AppMultipleThemesMode.light: AppTheme,
    // AppMultipleThemesMode.dark: AppTheme,
  },
};

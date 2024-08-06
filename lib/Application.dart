import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
import 'package:hele_app/providers/application/application.dart';
import 'package:hele_app/routes/app_pages.dart';
import 'package:hele_app/themes/app_theme.dart';
import 'package:provider/provider.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    // 状态管理
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ApplicationProvider()),
        ],
        builder: (context, child) {
          final watchApplicationProvider = context.watch<ApplicationProvider>();

          return ScreenUtilInit(
              // 屏幕适配
              designSize: const Size(750.0, 1334.0),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return GetMaterialApp(
                    // APP 配置
                    title: "HeLe",
                    // 主题
                    themeMode: watchApplicationProvider.themeMode,
                    theme: AppTheme(getMultipleThemesMode(context))
                        .multipleThemesLightMode(),
                    darkTheme: AppTheme(getMultipleThemesMode(context))
                        .multipleThemesDarkMode(),
                    // 路由
                    initialRoute: AppPages.INITIAL,
                    getPages: AppPages.routes,
                    defaultTransition: Transition.cupertino,
                    transitionDuration: const Duration(milliseconds: 500),
                    // 国际化
                    supportedLocales: S.supportedLocales,
                    localizationsDelegates: S.localizationsDelegates,
                    locale: watchApplicationProvider.localeSystem
                        ? null
                        : watchApplicationProvider.locale,
                    localeListResolutionCallback: (locales, supportedLocales) {
                      log('当前地区语言$locales');
                      log('设备支持的地区语言$supportedLocales');
                      return null;
                    },
                    // 弹框提示
                    navigatorObservers: [FlutterSmartDialog.observer],
                    builder: FlutterSmartDialog.init(),
                    debugShowCheckedModeBanner: false);
              });
        });
  }
}

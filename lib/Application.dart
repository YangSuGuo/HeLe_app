import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/flavors/build_config.dart';
import 'package:hele_app/common/flavors/env_config.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
import 'package:hele_app/providers/application/application.dart';
import 'package:hele_app/routes/app_pages.dart';
import 'package:provider/provider.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final EnvConfig _envConfig = BuildConfig.instance.config;

  /// ToDo 状态管理，设置配置持久化，懒加载
  @override
  Widget build(BuildContext context) {
    // 状态管理
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ApplicationProvider()),
        ],
        builder: (context, child) {
          return ScreenUtilInit(
              // 屏幕适配
              designSize: const Size(750.0, 1334.0),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return GetMaterialApp(
                    // APP 配置
                    title: _envConfig.appName,
                    // 主题
                    theme: ThemeData(
                      colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
                      useMaterial3: true,
                    ),
                    // 路由
                    initialRoute: AppPages.INITIAL,
                    getPages: AppPages.routes,
                    defaultTransition: Transition.cupertino,
                    transitionDuration: const Duration(milliseconds: 450),
                    // 国际化
                    supportedLocales: S.supportedLocales,
                    localizationsDelegates: S.localizationsDelegates,
                    locale: const Locale('zh'),
                    localeListResolutionCallback: (locales, supportedLocales) {
                      print('当前地区语言$locales');
                      print('设备支持的地区语言$supportedLocales');
                      return null;
                    },
                    // 弹框提示
                    navigatorObservers: [FlutterSmartDialog.observer],
                    builder: FlutterSmartDialog.init(),
                    // home: const DoubleCheckConfirmation(child: Init(child: home())),
                    debugShowCheckedModeBanner: false);
              });
        });
  }
}

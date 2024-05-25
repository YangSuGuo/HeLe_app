import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hele_app/themes/app_theme.dart';
import 'package:provider/provider.dart';

import 'providers/application/application.dart';

class Init extends StatefulWidget {
  const Init({super.key, required this.child});

  final Widget child;

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> {
  late final AppLifecycleListener _appLifecycleListener;

  @override
  void initState() {
    super.initState();

    /// App 生命周期
    _appLifecycleListener = AppLifecycleListener(
      onResume: () => print('App Resume'),
      // 从后台回到前台时调用
      onInactive: () => print('App Inactive'),
      // 进入后台但仍在活动状态时调用
      onHide: () => print('App Hide'),
      // 被隐藏时调用
      onShow: () => print('App Show'),
      // 从隐藏状态重新显示时调用
      onPause: () => print('App Pause'),
      // 即将进入后台时调用
      onRestart: () => print('App Restart'),
      // 重新启动时调用
      onDetach: () => print('App Detach'), // 完全退出时调用
    );

    /// 初始化
    WidgetsBinding.instance.endOfFrame.then((_) {
      if (mounted) init();
    });
  }

  @override
  void dispose() {
    _appLifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 沉浸模式（全屏模式）
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      // 夜间模式：Brightness.dark
      // 日间模式：Brightness.light : false
      // View.of(context).platformDispatcher.platformBrightness == Brightness.dark
      isDarkMode(context)
          ? SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.transparent)
          : SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.transparent,
            ),
    );
    return widget.child;
  }

  /// 应用初始化
  void init() async {
    final ApplicationProvider applicationProvider =
        context.read<ApplicationProvider>();

    // 获取APP主题深色模式
    applicationProvider.loadThemeMode();
    // 获取APP多主题模式
    applicationProvider.loadMultipleThemesMode();
    // 获取APP地区语言
    applicationProvider.loadLocale();
    // 获取APP地区语言是否跟随系统
    applicationProvider.loadLocaleSystem();
  }
}

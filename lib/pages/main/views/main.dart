import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/doubleCheckConfirmation.dart';
import 'package:hele_app/init.dart';
import 'package:hele_app/pages/main/controllers/main_controllers.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final MainController _mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return DoubleCheckConfirmation(
        child: Init(
            child: Scaffold(
      body: buildBody(),
    )));
  }

  // 主页面
  Widget buildBody() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _mainController.pageController,
      onPageChanged: (index) => _mainController.selectedIndex = index,
      children: _mainController.pages,
    );
  }

  // MD3 底部导航栏
  Widget buildBottomNavigationBar() {
    return const Text('data');
  }
}

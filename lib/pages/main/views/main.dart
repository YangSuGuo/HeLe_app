import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/doubleCheckConfirmation.dart';
import 'package:hele_app/init.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
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
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    )));
  }

  // 主页面
  Widget _buildBody() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _mainController.pageController,
      onPageChanged: (index) => _mainController.selectedIndex.value = index,
      children: _mainController.pages,
    );
  }

  // MD3 底部导航栏
  Widget _buildBottomNavigationBar() {
    return Obx(
        () => /*ClipRRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child:*/
            NavigationBar(
              height: 100.h,
              backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
              animationDuration: const Duration(milliseconds: 300),
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              onDestinationSelected: (value) => _mainController.setIndex(value),
              selectedIndex: _mainController.selectedIndex.value,
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.image_outlined),
                  selectedIcon: const Icon(Icons.image),
                  label: S.of(context).navigationBar_title_home,
                  tooltip: S.of(context).navigationBar_title_home,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.image_outlined),
                  selectedIcon: const Icon(Icons.image),
                  label: S.of(context).navigationBar_title_rank_list,
                  tooltip: S.of(context).navigationBar_title_rank_list,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.image_outlined),
                  selectedIcon: const Icon(Icons.image),
                  label: S.of(context).navigationBar_title_my,
                  tooltip: S.of(context).navigationBar_title_my,
                )
              ],
            ));
  }
}

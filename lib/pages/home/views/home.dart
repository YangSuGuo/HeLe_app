import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/gradient_background.dart';
import 'package:hele_app/pages/home/controllers/home_controller.dart';
import 'package:hele_app/pages/home/widget/custom_tabs.dart';
import 'package:hele_app/pages/home/widget/search_appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController _homeController = Get.find<HomeController>();
  late Stream<bool> stream;

  @override
  void initState() {
    super.initState();
    stream = _homeController.searchBarStream.stream;
  }

  @override
  void dispose() {
    // stream.listen((_) {}, onDone: () {}).cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // 渐变背景
        const GradientBackground(),
        Column(
          children: [
            // AppBar
            CustomAppBar(stream: stream, homeController: _homeController),
            Gap(8.h),
            // TabBar
            const CustomTabs(),
            Expanded(
              child: TabBarView(
                controller: _homeController.tabController,
                children: _homeController.tabsPageList,
              ),
            ),
          ],
        )
      ],
    ));
  }
}

// 顶部栏
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Stream<bool>? stream;
  final HomeController? homeController;

  const CustomAppBar({
    super.key,
    this.stream,
    this.homeController,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      initialData: true,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final double top = MediaQuery.of(context).padding.top;
        return AnimatedOpacity(
          opacity: snapshot.data ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: AnimatedContainer(
            curve: Curves.easeInOutCubicEmphasized,
            duration: const Duration(milliseconds: 500),
            height: snapshot.data ? top + 52 : top,
            padding: EdgeInsets.fromLTRB(14, top + 6, 14, 0),
            child: SearchAppBar(homeController: homeController),
          ),
        );
      },
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hele_app/pages/home/controllers/home_controller.dart';
import 'package:hele_app/pages/home/widget/custom_tabs.dart';
import 'package:hele_app/pages/home/widget/search_appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController _homeController = Get.put(HomeController());
  late Stream<bool> stream;

  @override
  void initState() {
    super.initState();
    stream = _homeController.searchBarStream.stream;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // 渐变背景
        gradientBackground(),
        Column(
          children: [
            // AppBar
            CustomAppBar(
              stream: _homeController.hideSearchBar
                  ? stream
                  : StreamController<bool>.broadcast().stream,
              homeController: _homeController,
            ),
            SizedBox(height: 8.h,),
            // TabBar
            const CustomTabs(),
            /*SizedBox(
                width: double.infinity,
                height: 60.h,
                child: TabBar(
                  controller: _homeController.tabController,
                  tabAlignment: TabAlignment.center,
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  enableFeedback: true,
                  splashBorderRadius: BorderRadius.circular(10),
                  tabs: [
                    for (var i in _homeController.tabs) Tab(text: i['label'])
                  ],
                  onTap: (i) {
                    if (_homeController.initialIndex.value == i) {
                      _homeController.tabsCtrList[i]().animateToTop();
                    }
                    _homeController.initialIndex.value = i;
                  },
                )),*/
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

  /// 渐变背景
  Widget gradientBackground() => Align(
        alignment: Alignment.topLeft,
        child: Opacity(
          opacity: 0.6,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.9),
                    Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    Theme.of(context).colorScheme.surface
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, 0.0034, 0.34]),
            ),
          ),
        ),
      );
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

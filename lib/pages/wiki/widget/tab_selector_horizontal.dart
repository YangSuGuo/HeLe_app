import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hele_app/pages/wiki/controllers/wiki_controller.dart';

class TabSelectorHorizontal extends StatefulWidget {
  const TabSelectorHorizontal({super.key});

  @override
  State<TabSelectorHorizontal> createState() => _TabSelectorHorizontalState();
}

class _TabSelectorHorizontalState extends State<TabSelectorHorizontal> with TickerProviderStateMixin {
  final WikiController _wikiController = Get.find<WikiController>();
  late TabController tabController;
  List<String> tabs = ["想看", "在看", "看过", "搁置", "抛弃"];

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 5,
      initialIndex: _wikiController.subjectType,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
          padding: EdgeInsets.only(top: 26.h, bottom: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                controller: tabController,
                // todo 根据 条目类型 动态设置文字
                tabs: List.generate(tabs.length, (index) {
                  return Tab(text: tabs[index]);
                }),
                isScrollable: false,
                splashFactory: NoSplash.splashFactory,
                padding: EdgeInsets.zero,
                automaticIndicatorColorAdjustment: true,
                indicatorPadding: EdgeInsets.zero,
                indicatorWeight: 0,
                // indicatorPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                indicator: BoxDecoration(
                  color: colorScheme.primaryContainer.withOpacity(0.8),
                  // colorScheme.primary.withOpacity(0.8),
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: colorScheme.onSecondaryContainer,
                labelStyle: TextStyle(fontSize: 28.sp),
                labelPadding: EdgeInsets.zero,
                dividerColor: Colors.transparent,
                unselectedLabelColor: colorScheme.outline,
                // tabAlignment: TabAlignment.start,
                onTap: (int index) {
                  _wikiController.subjectType = index;
                },
              ),
            ],
          ));
    });
  }
}

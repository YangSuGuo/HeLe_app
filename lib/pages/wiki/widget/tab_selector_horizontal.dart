import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabSelectorHorizontal extends StatelessWidget {
  const TabSelectorHorizontal({
    super.key,
    required this.tabs,
    required this.tabController,
    required this.onTap,
  });

  final List<String> tabs;
  final TabController tabController;
  final Function(int index) onTap;

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
                  color: colorScheme.primary.withOpacity(0.8),
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: colorScheme.onSecondaryContainer,
                labelStyle: TextStyle(fontSize: 28.sp),
                labelPadding: EdgeInsets.zero,
                dividerColor: Colors.transparent,
                unselectedLabelColor: colorScheme.outline,
                // tabAlignment: TabAlignment.start,
                onTap: onTap,
              ),
            ],
          ));
    });
  }
}

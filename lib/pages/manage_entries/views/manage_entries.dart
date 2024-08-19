import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/pages/manage_entries/controllers/manage_entries_controllers.dart';

import '../widget/tracking_type.dart';

// todo 自定义头部页
// todo 监听滚动触底刷新
// todo 实现筛选，更新，删除，点击事件
// todo 点击跳转wiki页面
// todo 不同风格的列表【优先度：极低】
class ManageEntries extends StatefulWidget {
  const ManageEntries({super.key});

  @override
  State<ManageEntries> createState() => _ManageEntriesState();
}

class _ManageEntriesState extends State<ManageEntries> with TickerProviderStateMixin {
  final ManageEntriesControllers _manageEntriesControllers = Get.find<ManageEntriesControllers>();
  late TabController? _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: 5,
      initialIndex: _manageEntriesControllers.tabIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(children: [
        Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 30.w, top: 70.h),
            color: colorScheme.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent, // 点击时的水波纹颜色设置为透明
                    highlightColor: Colors.transparent, // 点击时的背景高亮颜色设置为透明
                  ),
                  child: TabBar(
                    controller: _tabController,
                    tabs: [
                      for (var i in _manageEntriesControllers.trackingType) Tab(text: i),
                    ],
                    isScrollable: true,
                    indicatorWeight: 0,
                    indicatorPadding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                    indicator: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: colorScheme.onSecondaryContainer,
                    labelStyle: const TextStyle(fontSize: 13),
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: colorScheme.outline,
                    tabAlignment: TabAlignment.start,
                    onTap: (index) {
                      _manageEntriesControllers.tabIndex = index;
                    },
                  ),
                ),
/*                SizedBox(
                  width: 100.w,
                  height: 32,
                  child: IconButton(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                    ),
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_list_outlined,
                      size: 18,
                      color: colorScheme.primary,
                    ),
                  ),
                ),*/

                SizedBox(
                  width: 100.w,
                  height: 32,
                  child: PopupMenuButton<int>(
                      icon: const Icon(
                        Icons.filter_list_outlined,
                        size: 23,
                      ),
                      offset: const Offset(0, 45),
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(EdgeInsets.zero),
                        backgroundColor: WidgetStateProperty.all(colorScheme.secondaryContainer.withOpacity(0.1)),
                      ),
                      onSelected: (int index) {
                        _manageEntriesControllers.type.value = index + 1;
                        _manageEntriesControllers.getTrackingType();
                        // todo 其他分类
                      },
                      itemBuilder: (BuildContext context) {
                        List<String> list = ["书籍", "动漫", "其他"];
                        return list.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return PopupMenuItem<int>(
                            height: 40,
                            value: index,
                            textStyle: const TextStyle(fontSize: 13),
                            child: Center(child: Text(item)), // 显示文本
                          );
                        }).toList();
                      }),
                ),
                const Gap(1)
              ],
            )),
        const Gap(14),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              for (int i in Iterable.generate(5)) ...{TrackingType(index: i)}
            ],
          ),
        ),
      ]),
    );
  }
}

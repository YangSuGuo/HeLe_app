import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/pages/manage_entries/controllers/manage_entries_controllers.dart';

class ManageEntries extends StatefulWidget {
  const ManageEntries({super.key});

  @override
  State<ManageEntries> createState() => _ManageEntriesState();
}

class _ManageEntriesState extends State<ManageEntries> with TickerProviderStateMixin {
  final ManageEntriesControllers _manageEntriesControllers = Get.put(ManageEntriesControllers());
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
            color: Theme.of(context).colorScheme.surface,
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
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Theme.of(context).colorScheme.onSecondaryContainer,
                    labelStyle: const TextStyle(fontSize: 13),
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: Theme.of(context).colorScheme.outline,
                    tabAlignment: TabAlignment.start,
                    onTap: (index) {
                      _manageEntriesControllers.tabIndex = index;
                    },
                  ),
                ),
                // const Spacer(),
                SizedBox(
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
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const Gap(1)
              ],
            )),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [for (var i in _manageEntriesControllers.trackingType) ...{}],
          ),
        ),
      ]),
    );
  }
}

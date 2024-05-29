import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/tab_type.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late bool hideSearchBar; // 是否隐藏搜索栏
  late final StreamController<bool> searchBarStream =
      StreamController<bool>.broadcast();
  RxString defaultSearch = '推荐搜索'.obs; // 默认搜索内容

  late TabController tabController;
  late RxList tabs = [].obs; // Tab列表
  late List defaultTabs; // 默认Tab列表
  late List<String> tabbarSort; // Tab排序
  late List tabsCtrList; // TabController列表
  RxInt initialIndex = 1.obs; // 初始Tab索引
  late List<Widget> tabsPageList; // Tab页面列表

  @override
  void onInit() {
    super.onInit();
    hideSearchBar = true;
    initialIndex.value = 1;
    tabbarSort = ['anime', 'manga', 'movie', 'series', 'lightNovel'];
    setTabConfig();
  }

  void setTabConfig() async {
    defaultTabs = [...tabsConfig];
    defaultTabs.retainWhere(
        (item) => tabbarSort.contains((item['type'] as TabType).id));
    defaultTabs.sort((a, b) => tabbarSort
        .indexOf((a['type'] as TabType).id)
        .compareTo(tabbarSort.indexOf((b['type'] as TabType).id)));

    tabs.value = defaultTabs;
    tabsCtrList = tabs.map((e) => e['controller']).toList();
    tabsPageList = tabs.map<Widget>((e) => e['page']).toList();

    print(tabs.map((e)=>e['label']).toList());
    tabController = TabController(
      initialIndex: initialIndex.value,
      length: tabs.length,
      vsync: this,
    );

    // 监听 tabController 切换
    tabController.animation!.addListener(() {
      if (tabController.indexIsChanging) {
        if (initialIndex.value != tabController.index) {
          initialIndex.value = tabController.index;
        }
      } else {
        final int temp = tabController.animation!.value.round();
        if (initialIndex.value != temp) {
          initialIndex.value = temp;
          tabController.index = initialIndex.value;
        }
      }
    });
  }
}

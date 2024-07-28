import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/entry_title.dart';
import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/pages/home/controllers/home_controller.dart';
import 'package:hele_app/pages/tabs/anime/widget/bangumu_card.dart';
import 'package:hele_app/pages/tabs/lightNovel/controllers/lightNovel_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LightNovel extends StatefulWidget {
  const LightNovel({super.key});

  @override
  State<LightNovel> createState() => _LightNovelState();
}

class _LightNovelState extends State<LightNovel> with AutomaticKeepAliveClientMixin {
  final LightNovelController _lightNovelController = Get.put(LightNovelController());
  StreamController<bool> searchBarStream = Get.find<HomeController>().searchBarStream;
  Future? _hotRecommendations;
  late ScrollController scrollController;

  // 页面保活
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _hotRecommendations = _lightNovelController.getHotRecommendations();
    scrollController = _lightNovelController.scrollController;
    scrollController.addListener(
      () async {
        // 触底加载
        if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
          EasyThrottle.throttle('LightNovel', const Duration(seconds: 1), () {
            _lightNovelController.next();
          });
        }
        // 收起搜索栏
        final ScrollDirection direction = scrollController.position.userScrollDirection;
        if (direction == ScrollDirection.forward) {
          searchBarStream.add(true);
        } else if (direction == ScrollDirection.reverse) {
          searchBarStream.add(false);
        }
      },
    );
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: CustomScrollView(controller: _lightNovelController.scrollController, slivers: [
          EntryTitle(title: "热门推荐", fontWeight: FontWeight.bold, size: 44.sp),
          SliverGap(16.h),
          FutureBuilder(
              future: _hotRecommendations,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // List<LegacySubjectSmall> s = snapshot.data;
                  return Obx(() => contentGrid(_lightNovelController.bangumiList));
                } else {
                  return SliverToBoxAdapter(
                      child: Center(
                    child: LoadingAnimationWidget.stretchedDots(
                      color: colorScheme.primary,
                      size: 140.sp,
                    ),
                  ));
                }
              })
        ]));
  }

  // 推荐
  SliverGrid contentGrid(List<LegacySubjectSmall> bangumiList) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        crossAxisCount: 3,
        mainAxisExtent: Get.size.width / 2 + MediaQuery.textScalerOf(context).scale(16),
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return BangumiCard(bangumiItem: bangumiList[index]);
        },
        childCount: bangumiList.length,
      ),
    );
  }
}

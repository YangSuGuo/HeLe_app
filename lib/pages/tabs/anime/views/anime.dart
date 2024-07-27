import 'dart:async';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/entry_title.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/model/pagination.dart';
import 'package:hele_app/model/search/search.dart';
import 'package:hele_app/pages/home/controllers/home_controller.dart';
import 'package:hele_app/pages/tabs/anime/controllers/anime_controller.dart';
import 'package:hele_app/pages/tabs/anime/widget/bangumu_card.dart';
import 'package:hele_app/pages/tabs/anime/widget/recommendations_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Anime extends StatefulWidget {
  const Anime({super.key});

  @override
  State<Anime> createState() => _AnimeState();
}

class _AnimeState extends State<Anime> with AutomaticKeepAliveClientMixin {
  final AnimeController _animeController = Get.put(AnimeController());
  StreamController<bool> searchBarStream = Get.find<HomeController>().searchBarStream;
  late Future? _futureBuilderFuture;
  late Future? _getRecommendations;
  late ScrollController scrollController;

  @override
  // 页面保活
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _futureBuilderFuture = _animeController.queryBangumiCalendarFeed();
    _getRecommendations = _animeController.getRecommendations();
    scrollController = _animeController.scrollController;
    scrollController.addListener(
      () async {
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
    super.build(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: CustomScrollView(
          controller: _animeController.scrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            /// 推荐
            /// 根据当前时间所处季度，按收藏人数进行排序，取前5个为推荐
            EntryTitle(
              title: "为你推荐",
              size: 44.sp,
              fontWeight: FontWeight.bold,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              sliver: FutureBuilder(
                  future: _getRecommendations,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      Pagination s = snapshot.data;
                      // todo 显示推荐
                      return recommendations(s);
                    } else if (snapshot.hasError) {
                      return SliverToBoxAdapter(
                          child: Center(
                        child: LoadingAnimationWidget.stretchedDots(
                          color: colorScheme.primary,
                          size: 140.sp,
                        ),
                      ));
                    } else {
                      return SliverToBoxAdapter(
                          child: Center(
                        child: LoadingAnimationWidget.stretchedDots(
                          color: colorScheme.primary,
                          size: 140.sp,
                        ),
                      ));
                    }
                  }),
            ),
            SliverGap(12.h),
            // 追番表
            EntryTitle(
              title: S.of(context).tab_anime_calendar,
              size: 48.sp,
              fontWeight: FontWeight.bold,
              semanticsLabel: S.of(context).tab_anime_calendar,
              child: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: segmentControl(_animeController)),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              sliver: FutureBuilder(
                  future: _futureBuilderFuture,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<Calendar> data = snapshot.data;
                      return Obx(
                          () => contentGrid(data[_animeController.dayOfWeekIndex.value].items!));
                    } else if (snapshot.hasError) {
                      return SliverToBoxAdapter(
                          child: Center(
                        child: LoadingAnimationWidget.stretchedDots(
                          color: colorScheme.primary,
                          size: 140.sp,
                        ),
                      ));
                    } else {
                      return SliverToBoxAdapter(
                          child: Center(
                        child: LoadingAnimationWidget.stretchedDots(
                          color: colorScheme.primary,
                          size: 140.sp,
                        ),
                      ));
                    }
                  }),
            )
          ]),
    );
  }

  // 水平滚动的推荐
  SliverToBoxAdapter recommendations(Pagination pagination) {
    return SliverToBoxAdapter(
        child: SizedBox(
      height: 200.h,
      child: ListView.separated(
          itemCount: pagination.limit ?? 5,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (BuildContext context, int index) {
            return Gap(20.w);
          },
          itemBuilder: (BuildContext context, int index) {
            List<Datum>? data = pagination.data;
            return RecommendationsCard(data: data?[index]);
          }),
    ));
  }

  // 追番剧列表
  Widget contentGrid(List<LegacySubjectSmall> bangumiList) {
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

  // 分段器
  Widget segmentControl(crt) {
    return CustomSlidingSegmentedControl<int>(
      initialValue: crt.initialValue.value,
      children: {
        1: Text(
          _animeController.yesterday.value,
          style: TextStyle(fontSize: Theme.of(context).textTheme.labelMedium!.fontSize),
        ),
        2: Text(_animeController.today.value,
            style: TextStyle(fontSize: Theme.of(context).textTheme.labelMedium!.fontSize)),
        3: Text(_animeController.tomorrow.value,
            style: TextStyle(fontSize: Theme.of(context).textTheme.labelMedium!.fontSize))
      },
      // innerPadding: EdgeInsets.zero,
      // height: 50,
      padding: 12.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      thumbDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      onValueChanged: (v) {
        crt.tapSegmentChanger(v);
        crt.initialValue.value = v;
      },
    );
  }
}

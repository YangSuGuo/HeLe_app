import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
import 'package:hele_app/model/calendar.dart';
import 'package:hele_app/pages/tabs/anime/controllers/anime_controller.dart';
import 'package:hele_app/pages/tabs/anime/widget/bangumu_card.dart';
import 'package:nil/nil.dart';

class Anime extends StatefulWidget {
  const Anime({super.key});

  @override
  State<Anime> createState() => _AnimeState();
}

class _AnimeState extends State<Anime> {
  final AnimeController _animeController = Get.put(AnimeController());
  late Future? _futureBuilderFuture;

  @override
  void initState() {
    super.initState();
    _futureBuilderFuture = _animeController.queryBangumiCalendarFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(horizontal: 40.w),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          primary: false,
          shrinkWrap: false,
          slivers: [
            SliverGap(12.h),
            SliverToBoxAdapter(
              child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      S.of(context).tab_anime_calendar,
                      style: TextStyle(
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      semanticsLabel: S.of(context).tab_anime_calendar,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: Theme(
                          data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: segmentControl(_animeController)),
                    ),
                  ]),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              sliver: FutureBuilder(
                future: _futureBuilderFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // Map data = snapshot.data as Map;
                    return Obx(() => contentGrid(
                        _animeController,
                        _animeController
                            .bangumiCalendar[
                                _animeController.dayOfWeekIndex.value]
                            .items!));
                  } else {
                    // todo 骨架屏加载
                    return nil;
                  }
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "推荐",
                      style: TextStyle(
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      semanticsLabel: S.of(context).tab_anime_calendar,
                    )
                  ]),
            ),
          ]),
    );
  }

  // 追番剧列表
  Widget contentGrid(ctr, List<LegacySubjectSmall> bangumiList) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 7,
        crossAxisSpacing: 12,
        crossAxisCount: 3,
        mainAxisExtent: Get.size.width / 3 / 0.65 +
            MediaQuery.textScalerOf(context).scale(40.0),
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return BangumiCard(bangumiItem: bangumiList[index]);

          // 过滤 无图片 子项
          /* bangumiList[index].images != null
              ? BangumiCard(bangumiItem: bangumiList[index])
              : nil;*/
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
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.labelMedium!.fontSize),
        ),
        2: Text(_animeController.today.value,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.labelMedium!.fontSize)),
        3: Text(_animeController.tomorrow.value,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.labelMedium!.fontSize))
      },
      // innerPadding: EdgeInsets.zero,
      height: 50.h,
      padding: 12.0,
      decoration: BoxDecoration(
        color:
            Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.1),
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

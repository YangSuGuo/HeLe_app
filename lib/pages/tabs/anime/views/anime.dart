import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  ]),
            ),
            SliverPadding(
              padding: EdgeInsets.zero,
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
                    return contentGrid(_animeController, []);
                  }
                },
              ),
            ),
            // SliverAnimatedGrid(itemBuilder: itemBuilder, gridDelegate: gridDelegate)
          ]),
    );
  }

  Widget contentGrid(ctr, List<LegacySubjectSmall> bangumiList) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 7,
        crossAxisSpacing: 5,
        crossAxisCount: 3,
        mainAxisExtent: Get.size.width / 3 / 0.65 +
            MediaQuery.textScalerOf(context).scale(32.0),
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return bangumiList.isNotEmpty
              ? BangumiCard(bangumiItem: bangumiList[index])
              : nil;
        },
        childCount: bangumiList.isNotEmpty ? bangumiList.length : 10,
      ),
    );
  }
}

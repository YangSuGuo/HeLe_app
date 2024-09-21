import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/pages/apply_data/widget/common_card.dart';
import 'package:hele_app/pages/data_and_statistics/controllers/data_and_statistics_controllers.dart';
import 'package:hele_app/pages/wiki/widget/ratingGraph.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DataAndStatistics extends StatefulWidget {
  const DataAndStatistics({super.key});

  @override
  State<DataAndStatistics> createState() => _DataAndStatisticsState();
}

class _DataAndStatisticsState extends State<DataAndStatistics> {
  // final DataAndStatisticsControllers _andStatisticsControllers = Get.put(DataAndStatisticsControllers());
  final DataAndStatisticsControllers _andStatisticsControllers = Get.find<DataAndStatisticsControllers>();
  late Future _totalSubjects;
  late Future _totalAnimeSubjects;
  late Future _totalMangaSubjects;

  @override
  void initState() {
    super.initState();
    _totalSubjects = _andStatisticsControllers.getTotalSubjects();
    _totalMangaSubjects = _andStatisticsControllers.getCategorySubjects(1);
    _totalAnimeSubjects = _andStatisticsControllers.getCategorySubjects(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0,
          title: Text(
            '阅读与统计',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 20.h, left: 30.w, right: 30.w),
            child: ListView(
              children: [
                FutureBuilder(
                    future: _totalSubjects,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return CommonCard(
                          radius: 30,
                          onPressed: () {},
                          child: Container(
                            height: 150.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                statisticsItem(_andStatisticsControllers.totalSubjects[0].toString(), "想看"),
                                _verticalDivider(),
                                statisticsItem(_andStatisticsControllers.totalSubjects[2].toString(), "已看"),
                                _verticalDivider(),
                                statisticsItem(_andStatisticsControllers.totalSubjects[1].toString(), "在看"),
                                _verticalDivider(),
                                statisticsItem(_andStatisticsControllers.totalSubjects[3].toString(), "搁置"),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: LoadingAnimationWidget.stretchedDots(
                            color: Theme.of(context).colorScheme.primary,
                            size: 140.sp,
                          ),
                        );
                      }
                    }),
                Padding(
                    padding: EdgeInsets.only(left: 25.w, top: 20.h, bottom: 20.h),
                    child: AutoSizeText(
                      "动漫",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary, fontSize: 34.sp, fontWeight: FontWeight.w500),
                    )),
                FutureBuilder(
                    future: _totalAnimeSubjects,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return CommonCard(
                          radius: 30,
                          onPressed: () {},
                          child: Container(
                              height: 320.h,
                              child: Column(
                                children: [
                                  Gap(20.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      statisticsItem(_andStatisticsControllers.totalAnimeSubjects[0].toString(), "想看"),
                                      _verticalDivider(),
                                      statisticsItem(_andStatisticsControllers.totalAnimeSubjects[2].toString(), "已看"),
                                      _verticalDivider(),
                                      statisticsItem(_andStatisticsControllers.totalAnimeSubjects[1].toString(), "在看"),
                                      _verticalDivider(),
                                      statisticsItem(_andStatisticsControllers.totalAnimeSubjects[3].toString(), "搁置"),
                                    ],
                                  ),
                                  Gap(10.h),
                                  Container(
                                      height: 200.h,
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                                          child: RatingGraph(
                                            count: _andStatisticsControllers.animeCount,
                                          )))
                                ],
                              )),
                        );
                      } else {
                        return Center(
                          child: LoadingAnimationWidget.stretchedDots(
                            color: Theme.of(context).colorScheme.primary,
                            size: 140.sp,
                          ),
                        );
                      }
                    }),
                Padding(
                    padding: EdgeInsets.only(left: 25.w, top: 20.h, bottom: 20.h),
                    child: AutoSizeText(
                      "书籍",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary, fontSize: 34.sp, fontWeight: FontWeight.w500),
                    )),
                FutureBuilder(
                    future: _totalMangaSubjects,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return CommonCard(
                          radius: 30,
                          onPressed: () {},
                          child: Container(
                              height: 320.h,
                              child: Column(
                                children: [
                                  Gap(20.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      statisticsItem(_andStatisticsControllers.totalMangaSubjects[0].toString(), "想看"),
                                      _verticalDivider(),
                                      statisticsItem(_andStatisticsControllers.totalMangaSubjects[2].toString(), "已看"),
                                      _verticalDivider(),
                                      statisticsItem(_andStatisticsControllers.totalMangaSubjects[1].toString(), "在看"),
                                      _verticalDivider(),
                                      statisticsItem(_andStatisticsControllers.totalMangaSubjects[3].toString(), "搁置"),
                                    ],
                                  ),
                                  Gap(10.h),
                                  Container(
                                      height: 200.h,
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                                          child: RatingGraph(
                                            count: _andStatisticsControllers.mangaCount,
                                          )))
                                ],
                              )),
                        );
                      } else {
                        return Center(
                          child: LoadingAnimationWidget.stretchedDots(
                            color: Theme.of(context).colorScheme.primary,
                            size: 140.sp,
                          ),
                        );
                      }
                    }),
              ],
            )));
  }

  // 统计细项
  Widget statisticsItem(String statistics, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Gap(0.h),
        Gap(0.h),
        AutoSizeText(
          statistics,
          style: TextStyle(
            fontSize: 45.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
            height: 1.0,
          ),
        ),
        // Gap(10.h),
        AutoSizeText(
          title,
          style: TextStyle(
              fontSize: 30.sp,
              color: Theme.of(context).colorScheme.outline.withOpacity(0.75),
              height: 1.0,
              fontWeight: FontWeight.w500),
        ),
        Gap(0.h),
        Gap(0.h),
      ],
    );
  }

  // 竖向分割线
  Widget _verticalDivider() {
    return Container(
      width: 2.5.w,
      height: 80.h,
      // color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
    );
  }

  FutureBuilder futureBuilder({required Future? future, required double height, required Widget child}) {
    return FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CommonCard(
              radius: 30,
              onPressed: () {},
              child: Container(height: height, child: child),
            );
          } else {
            return Center(
              child: LoadingAnimationWidget.stretchedDots(
                color: Theme.of(context).colorScheme.primary,
                size: 140.sp,
              ),
            );
          }
        });
  }
}

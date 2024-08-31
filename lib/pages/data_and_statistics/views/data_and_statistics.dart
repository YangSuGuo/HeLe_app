import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hele_app/model/rating.dart';
import 'package:hele_app/pages/apply_data/widget/common_card.dart';
import 'package:hele_app/pages/wiki/widget/ratingGraph.dart';

class DataAndStatistics extends StatefulWidget {
  const DataAndStatistics({super.key});

  @override
  State<DataAndStatistics> createState() => _DataAndStatisticsState();
}

class _DataAndStatisticsState extends State<DataAndStatistics> {
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
                CommonCard(
                  radius: 30,
                  onPressed: () {},
                  child: Container(
                    height: 150.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        statisticsItem("54", "想看"),
                        Container(
                          width: 2.w,
                          height: 80.h,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        statisticsItem("12", "已看"),
                        Container(
                          width: 2.w,
                          height: 80.h,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        statisticsItem("125", "在看"),
                        Container(
                          width: 2.w,
                          height: 80.h,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        statisticsItem("0", "搁置"),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 25.w, top: 20.h, bottom: 20.h),
                    child: AutoSizeText(
                      "动漫",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary, fontSize: 34.sp, fontWeight: FontWeight.w500),
                    )),
                CommonCard(
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
                              statisticsItem("54", "想看"),
                              Container(
                                width: 2.w,
                                height: 80.h,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              statisticsItem("12", "已看"),
                              Container(
                                width: 2.w,
                                height: 80.h,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              statisticsItem("125", "在看"),
                              Container(
                                width: 2.w,
                                height: 80.h,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              statisticsItem("0", "搁置"),
                            ],
                          ),
                          Gap(10.h),
                          Container(
                              height: 200.h,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                                  child: RatingGraph(
                                    count: Count(
                                        the1: 20,
                                        the2: 50,
                                        the3: 32,
                                        the4: 66,
                                        the5: 88,
                                        the6: 44,
                                        the7: 21,
                                        the8: 11,
                                        the9: 30,
                                        the10: 10),
                                  )))
                        ],
                      )),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 25.w, top: 20.h, bottom: 20.h),
                    child: AutoSizeText(
                      "书籍",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary, fontSize: 34.sp, fontWeight: FontWeight.w500),
                    )),
                CommonCard(
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
                              statisticsItem("54", "想看"),
                              Container(
                                width: 2.w,
                                height: 80.h,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              statisticsItem("12", "已看"),
                              Container(
                                width: 2.w,
                                height: 80.h,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              statisticsItem("125", "在看"),
                              Container(
                                width: 2.w,
                                height: 80.h,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              statisticsItem("0", "搁置"),
                            ],
                          ),
                          Gap(10.h),
                          Container(
                              height: 200.h,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                                  child: RatingGraph(
                                    count: Count(
                                        the1: 20,
                                        the2: 50,
                                        the3: 32,
                                        the4: 66,
                                        the5: 88,
                                        the6: 44,
                                        the7: 21,
                                        the8: 11,
                                        the9: 30,
                                        the10: 10),
                                  )))
                        ],
                      )),
                )
              ],
            )));
  }

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
}

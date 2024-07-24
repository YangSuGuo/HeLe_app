import 'dart:developer';

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/badge.dart';
import 'package:hele_app/common/Widget/flexible_space_bar.dart';
import 'package:hele_app/common/Widget/gradient_background.dart';
import 'package:hele_app/common/Widget/network_img.dart';
import 'package:hele_app/common/Widget/show_modal_bottom_detail.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/model/search/search.dart';
import 'package:hele_app/pages/home/widget/custom_tabs.dart';
import 'package:hele_app/pages/rank_list/controllers/rank_controller.dart';
import 'package:hele_app/providers/application/application.dart';
import 'package:hele_app/routes/app_pages.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class RankList extends StatefulWidget {
  const RankList({super.key});

  @override
  State<RankList> createState() => _RankListState();
}

class _RankListState extends State<RankList> with AutomaticKeepAliveClientMixin {
  final RankController _rankController = Get.put(RankController());
  Future? _rankList;

  @override
  // 页面保活
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _rankList = _rankController.getRankingList([]);
    ScrollController scrollController = _rankController.scrollController;
    scrollController.addListener(() async {
      // 触底加载
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        EasyThrottle.throttle('my-throttler', const Duration(seconds: 1), () {
          if (_rankController.offset < 50) {
            _rankController.next();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        body: Stack(
      children: [
        // 渐变背景
        const GradientBackground(),
        CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              // SliverGap(60.h),
              // todo 状态栏 设置是否 浮动 或者 吸顶 或者 快速展开
              Consumer<ApplicationProvider>(builder: (_, applicationProvider, child) {
                return SliverAppBar(
                    expandedHeight: Get.height * 0.2,
                    pinned: true,
                    stretch: true,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    elevation: 0,
                    forceMaterialTransparency: true,
                    flexibleSpace: ExtendedFlexibleSpace(
                        centerTitle: false,
                        titlePadding: EdgeInsets.only(left: 40.w, top: 0.h, bottom: 20.h),
                        collapseMode: CollapseMode.parallax,
                        stretchModes: const [
                          StretchMode.blurBackground,
                          StretchMode.zoomBackground,
                        ],
                        title: AutoSizeText(
                            minFontSize: 12,
                            S.of(context).navigationBar_title_rank_list,
                            style: TextStyle(
                              fontSize: 52.sp,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.secondary,
                            )),
                        iconBuilder: (t) {
                          return Padding(
                              padding: EdgeInsets.only(top: 8.h, right: 36.w),
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomDetail(
                                      height: Get.height * 0.45,
                                      context: context,
                                      child: ListView(
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(bottom: 28.h, left: 24.w, right: 24.w),
                                        children: [
                                          Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                AutoSizeText(
                                                  "分类排行",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 42.sp,
                                                      color: colorScheme.secondary),
                                                ),
                                                MaterialButton(
                                                    minWidth: 10.w,
                                                    height: 45.h,
                                                    color: colorScheme.primary.withOpacity(0.8),
                                                    shape:
                                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
                                                    textTheme: ButtonTextTheme.primary,
                                                    onPressed: () {
                                                      _rankController.applySearchFilters();
                                                      Get.back();
                                                    },
                                                    child: const AutoSizeText("筛选"))
                                              ]),

                                          Gap(16.h),
                                          SizedBox(
                                              height: 80.h,
                                              child: ListView.separated(
                                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                                scrollDirection: Axis.horizontal,
                                                itemCount: 4,
                                                separatorBuilder: (BuildContext context, int index) {
                                                  return SizedBox(width: 20.w);
                                                },
                                                itemBuilder: (BuildContext context, int index) {
                                                  List<String> tags = ["书籍", "动漫", "电影", "电视剧"];
                                                  return Obx(() => FilterChip(
                                                      selected: index == _rankController.type.value - 1,
                                                      // avatar: const CircleAvatar(),
                                                      label: Text(tags[index]),
                                                      backgroundColor: colorScheme.primary.withAlpha(40),
                                                      side: const BorderSide(color: Colors.transparent),
                                                      showCheckmark: true,
                                                      visualDensity:
                                                          const VisualDensity(horizontal: 0.0, vertical: -2.0),
                                                      onSelected: (bool value) {
                                                        _rankController.onSelected(value, index);
                                                      }));
                                                },
                                              )),
                                          Gap(16.h),
                                          AutoSizeText(
                                            "年份筛选",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 42.sp,
                                                color: colorScheme.secondary),
                                          ),
                                          Gap(16.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              AutoSizeText("开始时间",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 30.sp,
                                                      color: colorScheme.secondary)),
                                              SizedBox(
                                                  width: 550.w,
                                                  height: 100.h,
                                                  child: CupertinoDatePicker(
                                                      mode: CupertinoDatePickerMode.monthYear,
                                                      minimumYear: DateTime(1980).year,
                                                      maximumYear: DateTime.now().year,
                                                      onDateTimeChanged: (date) {
                                                        log("开始时间：$date");
                                                        _rankController.startTime = date;
                                                      })),
                                            ],
                                          ),
                                          Gap(32.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              AutoSizeText("结束时间",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 30.sp,
                                                      color: colorScheme.secondary)),
                                              SizedBox(
                                                  width: 550.w,
                                                  height: 100.h,
                                                  child: CupertinoDatePicker(
                                                      mode: CupertinoDatePickerMode.monthYear,
                                                      minimumYear: DateTime(1980).year,
                                                      maximumYear: DateTime.now().year,
                                                      onDateTimeChanged: (date) {
                                                        log("结束时间：$date");
                                                        _rankController.endTime = date;
                                                      })),
                                            ],
                                          ),
                                          if (false)
                                            SizedBox(
                                                height: 405.h,
                                                child: YearPicker(
                                                  firstDate: DateTime(1980),
                                                  lastDate: DateTime(_rankController.date.year),
                                                  selectedDate: _rankController.date,
                                                  onChanged: (date) {},
                                                )),
                                          Gap(16.h),
                                         /* Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                            MaterialButton(
                                                minWidth: 100.w,
                                                color: colorScheme.primary.withOpacity(0.8),
                                                shape:
                                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
                                                textTheme: ButtonTextTheme.primary,
                                                onPressed: () {},
                                                child: const AutoSizeText("筛选"))
                                          ])*/
                                        ],
                                      ));
                                },
                                iconSize: 35.sp,
                                color: colorScheme.secondary,
                                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 5.h),
                                icon: const FaIcon(FontAwesomeIcons.sliders),
                                style: IconButton.styleFrom(
                                  backgroundColor: colorScheme.primary.withOpacity(0.12),
                                  minimumSize: const Size(52, 0),
                                ),
                              ));
                        },
                        subtitle: AutoSizeText("精选动漫Top 100",
                            minFontSize: 12,
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.secondary.withOpacity(0.7),
                            ))));
              }),

              FutureBuilder(
                  future: _rankList,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Obx(() => sliverList(_rankController.rankList));
                    } else {
                      return SliverToBoxAdapter(
                          child: Center(
                              child: LoadingAnimationWidget.stretchedDots(
                        color: colorScheme.primary,
                        size: 140.sp,
                      )));
                    }
                  })
            ]),
      ],
    ));
  }

  SliverList sliverList(List<Datum> s) {
    return SliverList.builder(
        itemCount: s.length,
        itemBuilder: (context, index) {
          return rankedCardsList(s[index], index);
        });
  }

  Widget rankedCardsList(Datum datum, int index) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return InkWell(
        onTap: () {
          final LegacySubjectSmall bangumiItem = datum.toLegacySubjectSmall();
          Get.toNamed(Routes.WIKI, arguments: {"bangumiItem": bangumiItem});
        },
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  NetworkImg(
                    src: datum.image,
                    width: 210.w,
                    height: 240.h,
                  ),
                  PBadge(text: "TOP ${(index + 1).toString()}", top: 6, left: 6),
                  if (datum.date != "")
                    PBadge(
                      text: DateTime.parse(datum.date).year.toString(),
                      bottom: 6,
                      right: 6,
                      bgColor: colorScheme.tertiaryContainer.withOpacity(0.4),
                    )
                ]),
                Gap(25.w),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gap(8.h),
                    AutoSizeText(
                      datum.nameCn != "" || datum.name != ""
                          ? datum.nameCn != ""
                              ? datum.nameCn!
                              : datum.name
                          : "获取失败！",
                      // datum.nameCn ?? datum.name,
                      maxLines: 1,
                      minFontSize: 17,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.secondary),
                    ),
                    if (datum.name != "")
                      AutoSizeText(
                        datum.name,
                        maxLines: 1,
                        minFontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w500, color: colorScheme.secondary.withOpacity(0.7)),
                      ),
                    // 星级评定
                    Gap(6.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AnimatedRatingStars(
                          initialRating: datum.score / 2,
                          maxRating: 5.0,
                          minRating: 0.0,
                          starSize: 16.sp,
                          filledColor: colorScheme.primary.withOpacity(0.8),
                          displayRatingValue: false,
                          interactiveTooltips: true,
                          readOnly: true,
                          onChanged: (double rating) {},
                          customFilledIcon: Icons.star,
                          customHalfFilledIcon: Icons.star_half,
                          customEmptyIcon: Icons.star_border,
                        ),
                        Gap(10.w),
                        AutoSizeText("${datum.score}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary.withOpacity(0.6),
                                fontSize: 28.sp)),
                      ],
                    ),
                    Gap(6.h),
                    // 上映时间
                    if (false)
                      AutoSizeText(
                        datum.date,
                        maxLines: 1,
                        maxFontSize: 20,
                        minFontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w500, color: colorScheme.secondary.withOpacity(0.7)),
                      ),
                    // 简介
                    Padding(
                        padding: EdgeInsets.only(right: 25.w),
                        child: AutoSizeText(
                          datum.summary.trim(),
                          minFontSize: 13,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: colorScheme.secondary,
                          ),
                        )),
                    // 标签
                    if (false)
                      SizedBox(
                          height: 50.h,
                          child: ListView.separated(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              itemCount: 2,
                              separatorBuilder: (BuildContext context, int index) {
                                return Gap(10.w);
                              },
                              itemBuilder: (BuildContext context, int index) {
                                List<String> tags = datum.tags.map((tag) => tag.name).toList();
                                return CustomChip(
                                  onTap: () {},
                                  label: tags[index],
                                  selected: false,
                                  isTranslucent: true,
                                );
                              })),
                  ],
                ))
              ],
            )));
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/flexible_space_bar.dart';
import 'package:hele_app/common/Widget/gradient_background.dart';
import 'package:hele_app/common/Widget/show_modal_bottom_detail.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
import 'package:hele_app/model/search/search.dart';
import 'package:hele_app/pages/rank_list/controllers/rank_controller.dart';
import 'package:hele_app/pages/rank_list/widget/ranked_cards_list.dart';
import 'package:hele_app/pages/rank_list/widget/scroll_year_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RankList extends StatefulWidget {
  const RankList({super.key});

  @override
  State<RankList> createState() => _RankListState();
}

class _RankListState extends State<RankList> with AutomaticKeepAliveClientMixin {
  final RankController _rankController = Get.put(RankController());
  Future? _rankList;
  late ScrollController scrollController;

  @override
  // 页面保活
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _rankList = _rankController.getRankingList([]);
    scrollController = _rankController.scrollController;
    scrollController.addListener(() async {
      // 触底加载
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        EasyThrottle.throttle('Rank', const Duration(seconds: 1), () {
          if (_rankController.offset < 50) {
            _rankController.next();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        body: Stack(
      children: [
        // 渐变背景
        const GradientBackground(),
        CustomScrollView(
            controller: _rankController.scrollController,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverAppBar(
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
                                HapticFeedback.lightImpact();
                                showModalBottomDetail(
                                    height: Get.height * 0.41, context: context, child: bottomSheet(context));
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
                      subtitle:
                          Obx(() => AutoSizeText("精选${_rankController.tags[_rankController.type.value - 1]}Top 100",
                              minFontSize: 12,
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.secondary.withOpacity(0.7),
                              ))))),
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

  // 构建列表
  SliverList sliverList(List<Datum> s) {
    return SliverList.builder(
        itemCount: s.length,
        itemBuilder: (context, index) {
          return RankedCardsList(
            datum: s[index],
            index: index,
          );
        });
  }

  // 分类筛选
  Widget filterBottomSheet(ColorScheme colorScheme) {
    return Container(
        height: 80.h,
        padding: EdgeInsets.only(bottom: 16.h, top: 8.h),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 20.w);
          },
          itemBuilder: (BuildContext context, int index) {
            return Obx(() => FilterChip(
                selected: index == _rankController.type.value - 1,
                // avatar: const CircleAvatar(),
                label: Text(_rankController.tags[index]),
                backgroundColor: colorScheme.primary.withAlpha(40),
                side: const BorderSide(color: Colors.transparent),
                showCheckmark: true,
                visualDensity: const VisualDensity(horizontal: 0.0, vertical: -2.0),
                onSelected: (bool value) {
                  _rankController.onSelected(value, index);
                }));
          },
        ));
  }

  // 底部弹框
  Widget bottomSheet(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 28.h, left: 24.w, right: 24.w),
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "分类排行",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42.sp, color: colorScheme.secondary),
                ),
                MaterialButton(
                    minWidth: 10.w,
                    height: 45.h,
                    color: colorScheme.primary.withOpacity(0.8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
                    textTheme: ButtonTextTheme.primary,
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      _rankController.applySearchFilters();
                      Get.back();
                    },
                    onLongPress: () {
                      _rankController.restoreDefaultFilters();
                      Get.back();
                    },
                    child: const AutoSizeText("筛选"))
              ]),
          filterBottomSheet(colorScheme),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeText(
                "年份筛选",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42.sp, color: colorScheme.secondary),
              ),
              AutoSizeText(
                "（长按筛选重置）",
                style: TextStyle(
                  fontSize: 21.sp,
                  color: colorScheme.secondary.withOpacity(0.5),
                ),
              ),
            ],
          ),
          Gap(24.h),
          ScrollYearPicker(
              startTime: _rankController.startTime,
              endTime: _rankController.endTime,
              startOnChange: (DateTime startTime) {
                _rankController.startTime = startTime;
              },
              endOnChange: (DateTime endTime) {
                _rankController.endTime = endTime;
              })
        ]);
  }
}

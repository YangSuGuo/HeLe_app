import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/flexible_space_bar.dart';
import 'package:hele_app/common/Widget/gradient_background.dart';
import 'package:hele_app/common/Widget/network_img.dart';
import 'package:hele_app/common/Widget/show_modal_bottom_detail.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/model/search/search.dart';
import 'package:hele_app/pages/rank_list/controllers/rank_controller.dart';
import 'package:hele_app/providers/application/application.dart';
import 'package:hele_app/routes/app_pages.dart';
import 'package:hele_app/themes/app_style/colors/app_theme_color_scheme.dart';
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
                    backgroundColor: Colors.white,
                    // excludeHeaderSemantics:true,
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
                                    context: context,
                                    child: ListView()
                                  );
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
                      return sliverList(_rankController.rankList);
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
          return rankedCardsList(s[index]);
        });
  }

  Widget rankedCardsList(Datum datum) {
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
                NetworkImg(
                  src: datum.image,
                  width: 210.w,
                  height: 240.h,
                ),
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
                        minFontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w500, color: colorScheme.secondary.withOpacity(0.7)),
                      ),
                    AutoSizeText(
                      datum.date,
                      maxLines: 1,
                      maxFontSize: 20,
                      minFontSize: 16,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w500, color: colorScheme.secondary.withOpacity(0.7)),
                    ),
                    AutoSizeText("${datum.score}",
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppThemeColorScheme.top, fontSize: 40.sp)),
                  ],
                ))
              ],
            )));
  }
}

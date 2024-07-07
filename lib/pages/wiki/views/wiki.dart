import 'dart:ui';

import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/utils/network_img.dart';
import 'package:hele_app/model/subjects/subjects.dart';
import 'package:hele_app/pages/home/widget/custom_tabs.dart';
import 'package:hele_app/pages/wiki/controllers/wiki_controller.dart';
import 'package:hele_app/pages/wiki/widget/introduction.dart';
import 'package:hele_app/themes/app_style/colors/app_theme_color_scheme.dart';
import 'package:nil/nil.dart';

class Wiki extends StatefulWidget {
  const Wiki({super.key});

  @override
  State<Wiki> createState() => _WikiState();
}

class _WikiState extends State<Wiki> with TickerProviderStateMixin {
  final WikiController _wikiController = Get.put(WikiController());
  late Future? _futureBuilder;

  @override
  void initState() {
    super.initState();
    _futureBuilder = _wikiController.querySubjectDetails(_wikiController.legacySubjectSmall.id!);
  }

  @override
  void dispose() {
    // _wikiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        body: Stack(children: [
      // 背景图片
      _buildBackgroundImage(),
      _buildAppBar(),
      Padding(
          padding: EdgeInsets.fromLTRB(40.w, 162.h, 40.w, 0.h),
          child: FutureBuilder(
              future: _futureBuilder,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Subjects s = snapshot.data;
                  return CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      primary: false,
                      shrinkWrap: false,
                      slivers: [
                        /* _buildAppBar(),*/
                        // 封面介绍
                        SliverToBoxAdapter(child: Introduction(data: s)),
                        SliverGap(16.h),
                        // 可展开的文本框
                        if (s.summary != "")
                          SliverToBoxAdapter(
                              child: ExpandText(
                            s.summary,
                            maxLines: 4,
                            style: TextStyle(color: colorScheme.secondary.withOpacity(0.85)),
                          )),
                        // SliverGap(0.h),

                        // 剧集展示  0 < x < 60
                        // todo 点击跳转到剧集详情
                        SliverToBoxAdapter(
                          child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text("剧集",
                                    style: TextStyle(
                                        fontSize: 42.sp, fontWeight: FontWeight.bold, color: colorScheme.secondary))
                              ]),
                        ),
                        SliverGap(16.h),
                        if ((s.eps != 0 && s.eps < 60) || (s.totalEpisodes != 0 && s.totalEpisodes < 60))
                          contentGrid(s.totalEpisodes != 0 ? s.totalEpisodes : s.eps),
                        SliverGap(24.h),

                        // 评分信息
                        SliverToBoxAdapter(
                          child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: '评分',
                                      style: TextStyle(
                                          fontSize: 42.sp, fontWeight: FontWeight.bold, color: colorScheme.secondary)),
                                  if(s.rating.score != 0)
                                  TextSpan(
                                      text: " ${s.rating.score}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppThemeColorScheme.top,
                                          fontSize: 40.sp)),
                                ])),
                                if(s.rating.rank != 0)
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 28.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    gradient: const LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        AppThemeColorScheme.top3,
                                        AppThemeColorScheme.top,
                                        AppThemeColorScheme.top2,
                                      ],
                                    ),
                                  ),
                                  child: Text(
                                    "${s.rating.rank} 名",
                                    style: TextStyle(color: colorScheme.onPrimary, fontSize: 28.sp , fontWeight: FontWeight.bold),
                                  ),
                                )
                              ]),
                        ),
                        SliverGap(16.h),

                      ]);
                } else {
                  return nil;
                }
              }))
    ]));
  }

  // 剧集列表
  Widget contentGrid(int eps) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 20.h,
        crossAxisSpacing: 5.w,
        crossAxisCount: 6,
        mainAxisExtent: 52.h,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CustomChip(
            onTap: () {},
            label: (index + 1).toString(),
            selected: false,
            isPadding: false,
            isTranslucent: true,
          );
        },
        childCount: eps,
      ),
    );
  }

  // AppBar
  Widget _buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      centerTitle: false,
      elevation: 0,
      automaticallyImplyLeading: true,
      forceMaterialTransparency: true,
      actions: [
        IconButton(
          onPressed: () => Get.toNamed('/historySearch'),
          icon: const Icon(Icons.search_outlined),
        ),
        PopupMenuButton<String>(
          onSelected: (String type) {
            // todo 处理菜单项选择的逻辑
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'pause',
              child: Text("1"),
            ),
            const PopupMenuItem<String>(
              value: 'clear',
              child: Text('2'),
            ),
            const PopupMenuItem<String>(
              value: 'del',
              child: Text('3'),
            ),
            const PopupMenuItem<String>(
              value: 'multiple',
              child: Text('4'),
            ),
          ],
        ),
        const SizedBox(width: 6),
      ],
    );
  }

  // 背景图
  Widget _buildBackgroundImage() {
    return Opacity(
      opacity: 0.2,
      child: ClipRect(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // 图片组件
            AspectRatio(
              aspectRatio: 1.5,
              child: NetworkImg(
                src: _wikiController.imgUrl,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),

            // 模糊滤镜
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: const SizedBox(),
            ),

            // 渐变遮罩
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      Theme.of(context).colorScheme.primary.withOpacity(0.5),
                      Theme.of(context).colorScheme.surface,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

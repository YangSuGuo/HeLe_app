import 'dart:ui';

import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/badge.dart';
import 'package:hele_app/common/utils/network_img.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
import 'package:hele_app/model/subjects/subjects.dart';
import 'package:hele_app/pages/home/widget/custom_tabs.dart';
import 'package:hele_app/pages/wiki/controllers/wiki_controller.dart';
import 'package:hele_app/pages/wiki/widget/introduction.dart';
import 'package:hele_app/pages/wiki/widget/subheading.dart';
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
    _futureBuilder = _wikiController
        .querySubjectDetails(_wikiController.legacySubjectSmall.id!);
  }

  @override
  void dispose() {
    _wikiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        body: Stack(children: [
      // 背景图片
      _buildBackgroundImage(),

      // Body
      ListView(children: [
        _buildAppBar(),
        Padding(
            padding: EdgeInsets.fromLTRB(40.w, 10.h, 40.w, 0.h),
            child: FutureBuilder(
                future: _futureBuilder,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Subjects s = snapshot.data;
                    return Column(children: [
                      Introduction(data: s),
                      Gap(12.h),
                      ExpandText(
                        s.summary,
                        maxLines: 4,
                        style: TextStyle(
                            color: colorScheme.secondary.withOpacity(0.85)),
                      ),
                    ]);
                  } else {
                    return nil;
                  }
                }))
      ])
    ]));
  }

  // 封面介绍页
  Widget introduction(Subjects s, ColorScheme colorScheme) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(children: [
        // 封面图片
        Stack(children: [
          NetworkImg(
            src: _wikiController.imgUrl,
            width: 210.w,
            height: 240.h,
          ),
          if (s.rating.score != 0.0 && s.rating.score != null)
            PBadge(
                text: s.rating.score.toString(),
                top: 6,
                right: 6,
                bottom: null,
                left: null),
        ]),
        Gap(25.w),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 标题
          SizedBox(
              width: constraints.maxWidth - 235.w,
              child: Text(_wikiController.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.secondary,
                  ))),

          // 播放平台
          Subheading(
            title: s.platform,
            minFontSize: 12,
            icon: FontAwesomeIcons.circlePlay,
            isOverflow: false,
          ),

          // 播出日期
          Subheading(
            title: s.date.toString(),
            minFontSize: 12,
            icon: FontAwesomeIcons.clock,
            isOverflow: false,
          ),

          // 制作
          if (_wikiController.production != "")
            Subheading(
              title: _wikiController.production.value,
              icon: FontAwesomeIcons.user,
              isOverflow: true,
              width: constraints.maxWidth - 267.5.w,
            ),

          // 标签列表
          SizedBox(
              width: constraints.maxWidth - 235.w,
              height: 80.h,
              child: ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: _wikiController.tags.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Gap(12.w);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return CustomChip(
                      onTap: () {},
                      label: _wikiController.tags[index],
                      selected: false,
                      isTranslucent: true,
                    );
                  })),

          // 按钮
          if (false)
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: colorScheme.onPrimary,
                    backgroundColor: colorScheme.primary.withOpacity(0.6),
                    // overlayColor: colorScheme.tertiary,
                    minimumSize: Size(constraints.maxWidth - 267.w, 60.h),
                  ),
                  onPressed: () {},
                  child: Text(S.of(context).wiki_track)),
            )
        ])
      ]);
    });
  }

  // AppBar
  AppBar _buildAppBar() {
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
              child: Text('1'),
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
              child: SizedBox(height: 0),
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

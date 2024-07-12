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
import 'package:hele_app/pages/wiki/widget/subheading.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key, required this.data});

  final Subjects data;

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  final WikiController _wikiController = Get.find<WikiController>();
  late final Subjects s;

  @override
  void initState() {
    super.initState();
    s = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Row(children: [
        // 封面图片
        Stack(children: [
          NetworkImg(
            src: _wikiController.imgUrl,
            width: 210.w,
            height: 240.h,
          ),
          if (s.rating.score != 0.0 && s.rating.score != null)
            PBadge(text: s.rating.score.toString(), top: 6, right: 6, bottom: null, left: null),
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

          if (s.type == 2)
            s.totalEpisodes != 0 || s.eps != 0
                // 剧集
                ? Subheading(
                    title: "${s.totalEpisodes != 0 ? s.totalEpisodes : s.eps} 集",
                    minFontSize: 12,
                    icon: FontAwesomeIcons.circlePlay,
                    isOverflow: false,
                  )
                // 播放平台
                : Subheading(
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
}

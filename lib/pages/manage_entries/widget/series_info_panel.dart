import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/network_img.dart';
import 'package:hele_app/db/database/entity/subjects_star.dart';
import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/pages/apply_data/widget/common_card.dart';
import 'package:hele_app/pages/home/widget/custom_tabs.dart';
import 'package:hele_app/routes/app_pages.dart';
import 'package:hele_app/themes/app_style/colors/app_theme_color_scheme.dart';

class SeriesInfoPanel extends StatelessWidget {
  const SeriesInfoPanel({
    super.key,
    required this.subjectsStar,
    this.tags,
    required this.buttonText,
    required this.edit,
    required this.delete,
    required this.onPressed,
    this.isSelected,
    this.showDeleteButton,
    this.showEditButton,
  });

  final SubjectsStar subjectsStar;
  final List<String>? tags;
  final String buttonText;
  final VoidCallback onPressed;
  final VoidCallback delete;
  final bool? isSelected;
  final void Function(int index) edit;
  final bool? showDeleteButton;
  final bool? showEditButton;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
        padding: EdgeInsets.only(bottom: 20.h, left: 24.w, right: 24.w),
        child: CommonCard(
            type: CommonCardType.plain,
            onPressed: () {
              final LegacySubjectSmall bangumiItem = subjectsStar.toLegacySubjectSmall();
              Get.toNamed(Routes.WIKI, arguments: {"bangumiItem": bangumiItem});
            },
            child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                  height: tags!.isNotEmpty ? 250.h : 250.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (tags!.isEmpty)
                        NetworkImg(
                          src: subjectsStar.images,
                          width: 210.w,
                          height: constraints.maxHeight,
                        ),
                      if (tags!.isNotEmpty)
                        NetworkImg(
                          src: subjectsStar.images,
                          width: 210.w,
                          height: constraints.maxHeight,
                        ),
                      Gap(20.w),
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 标题
                          if (!(showDeleteButton ?? true)) Gap(10.h),
                          Row(children: [
                            Expanded(
                                child: AutoSizeText(
                              subjectsStar.nameCn != "" || subjectsStar.name != ""
                                  ? subjectsStar.nameCn != ""
                                      ? subjectsStar.nameCn
                                      : subjectsStar.name
                                  : "获取失败！",
                              maxLines: 1,
                              minFontSize: 17,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.secondary),
                            )),
                            // 删除按钮
                            if (showDeleteButton ?? true)
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outlined,
                                ),
                                color: colorScheme.secondary,
                                onPressed: delete,
                              )
                          ]),

                          // 评分
                          // if(subjectsStar.rating != 0 && subjectsStar.score != 0)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AnimatedRatingStars(
                                initialRating:
                                    subjectsStar.rating == 0 ? subjectsStar.score! / 2 : subjectsStar.rating,
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
                              AutoSizeText("${subjectsStar.rating == 0
                                  ? subjectsStar.score
                                  : subjectsStar.rating}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.primary.withOpacity(0.6),
                                      fontSize: 28.sp)),
                            ],
                          ),

                          // 标签列表
                          if (tags!.isNotEmpty)
                            SizedBox(
                                height: 60.h,
                                child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: tags!.length,
                                    separatorBuilder: (BuildContext context, int index) {
                                      return Gap(12.w);
                                    },
                                    itemBuilder: (BuildContext context, int index) {
                                      return CustomChip(
                                        onTap: () {},
                                        label: tags![index],
                                        selected: false,
                                        isTranslucent: true,
                                      );
                                    })),

                          Row(
                            children: [
                              const Spacer(),
                              if (showEditButton ?? true)
                                PopupMenuButton<int>(
                                    icon: const FaIcon(Icons.edit_outlined),
                                    offset: const Offset(-50, 0),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(colorScheme.secondaryContainer.withOpacity(0.1)),
                                    ),
                                    onSelected: edit,
                                    itemBuilder: (BuildContext context) {
                                      List<String> list = ["想看", "在看", "看过", "搁置", "抛弃"];
                                      return list.asMap().entries.map((entry) {
                                        final index = entry.key;
                                        final item = entry.value;
                                        return PopupMenuItem<int>(
                                          height: 40,
                                          value: index,
                                          textStyle: const TextStyle(fontSize: 13),
                                          child: Center(child: Text(item)), // 显示文本
                                        );
                                      }).toList();
                                    }),
                              // Gap(8.w),

                              AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOutSine,
                                  margin: isSelected ?? false
                                      ? EdgeInsets.only(left: 25.w, right: 25.w)
                                      : EdgeInsets.only(left: 8.w, right: 25.w),
                                  child: AnimatedSize(
                                      duration: const Duration(milliseconds: 150),
                                      curve: Curves.easeInOutSine,
                                      child: TextButton(
                                          onPressed: onPressed,
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                isSelected ?? false ? AppThemeColorScheme.top2 : colorScheme.secondary,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                                            // padding: EdgeInsets.zero,
                                            child: AutoSizeText(
                                              isSelected ?? false ? "取消收藏" : buttonText,
                                              style: TextStyle(color: colorScheme.onPrimary),
                                            ),
                                          )))),
                              // Gap(25.w)
                            ],
                          ),
                          Gap(5.h)
                        ],
                      ))
                    ],
                  ));
            })));
  }
}

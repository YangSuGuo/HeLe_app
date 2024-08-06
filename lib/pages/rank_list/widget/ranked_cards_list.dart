import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/badge.dart';
import 'package:hele_app/common/Widget/network_img.dart';
import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/model/search/search.dart';
import 'package:hele_app/routes/app_pages.dart';

class RankedCardsList extends StatelessWidget {
  const RankedCardsList({
    super.key,
    required this.datum,
    required this.index,
    this.isRank = true,
  });

  final Datum datum;
  final int index;
  final bool? isRank;

  @override
  Widget build(BuildContext context) {
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
                  if (isRank ?? true)
                    PBadge(
                        text: "TOP ${(index + 1).toString()}", top: 6, left: 6),
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
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.secondary),
                    ),
                    if (datum.name != "")
                      AutoSizeText(
                        datum.name,
                        maxLines: 1,
                        minFontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: colorScheme.secondary.withOpacity(0.7)),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: colorScheme.secondary.withOpacity(0.7)),
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
                  ],
                ))
              ],
            )));
  }
}

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalRating extends StatelessWidget {
  const HorizontalRating({
    super.key,
    required this.score,
    required this.qualityRating,
    required this.onChanged,
  });

  final double score;
  final String qualityRating;
  final Function(double rating) onChanged;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 评分
            AnimatedRatingStars(
              initialRating: score,
              maxRating: 5.0,
              minRating: 0.0,
              starSize: 64.sp,
              filledColor: colorScheme.primaryContainer.withOpacity(0.9),
              displayRatingValue: false,
              interactiveTooltips: true,
              readOnly: false,
              onChanged: onChanged,
              customFilledIcon: Icons.star,
              customHalfFilledIcon: Icons.star_half,
              customEmptyIcon: Icons.star_border,
            ),
            // 评分描述
            AutoSizeText(
              "（$qualityRating）",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.secondary.withOpacity(0.8),
              ),
            ),
          ],
        ));
  }
}

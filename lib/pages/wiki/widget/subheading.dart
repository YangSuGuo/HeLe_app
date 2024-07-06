import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class Subheading extends StatelessWidget {
  const Subheading({
    super.key,
    required this.title,
    required this.icon,
    this.minFontSize,
    required this.isOverflow,
    this.width,
  });

  final String title;
  final IconData icon;
  final double? width; // 默认值
  final double? minFontSize; // 默认值 15
  final bool isOverflow;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 8.h, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              // FontAwesomeIcons.user,
              size: 28.sp,
              color: colorScheme.secondary.withOpacity(0.9),
            ),
            Gap(8.w),
            isOverflow == true
                ? SizedBox(
                    width: width ?? 200,
                    child: AutoSizeText(title,
                        minFontSize: minFontSize ?? 15,
                        maxFontSize: 20,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: colorScheme.secondary.withOpacity(0.9),
                        )),
                  )
                : AutoSizeText(title,
                    minFontSize: minFontSize ?? 15,
                    maxFontSize: 20,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: colorScheme.secondary.withOpacity(0.9),
                    )),
          ],
        ));
  }
}

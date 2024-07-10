import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hele_app/common/utils/network_img.dart';

class InfoSubitem extends StatelessWidget {
  const InfoSubitem({
    super.key,
    this.src,
    this.title,
    this.subtitle,
    this.containerWidth,
    this.width,
    this.height,
    this.radius,
    this.fit,
    this.onTap,
  });

  final String? src;
  final String? title;
  final double? containerWidth;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit? fit;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return InkWell(
        onTap: onTap,
        child: Container(
            width: containerWidth ?? 120.w,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NetworkImg(
                  src: src,
                  fit: fit,
                  radius: radius,
                  width: width ?? 100.w,
                  height: height ?? 100.h,
                ),
                AutoSizeText(title ?? "",
                    minFontSize: 12,
                    maxFontSize: 15,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.secondary.withOpacity(0.9),
                    )),
                AutoSizeText(
                  subtitle ?? "",
                  minFontSize: 12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.secondary.withOpacity(0.9),
                  ),
                )
              ],
            )));
  }
}

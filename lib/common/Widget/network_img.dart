import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NetworkImg extends StatelessWidget {
  const NetworkImg({
    super.key,
    this.src,
    required this.width,
    required this.height,
    this.type,
    this.fadeOutDuration,
    this.fadeInDuration,
    this.quality,
    this.origAspectRatio,
    this.radius,
    this.fit = BoxFit.cover,
  });

  final String? src;
  final double width;
  final double height;
  final double? radius;
  final String? type;
  final Duration? fadeOutDuration;
  final Duration? fadeInDuration;
  final int? quality;
  final double? origAspectRatio;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    // int? memCacheWidth, memCacheHeight;
    // double aspectRatio = (width / height).toDouble();
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    // void setMemCacheSizes() {
    //   if (aspectRatio > 1) {
    //     memCacheHeight = height.cacheSize(context);
    //   } else if (aspectRatio < 1) {
    //     memCacheWidth = width.cacheSize(context);
    //   } else {
    //     if (origAspectRatio != null && origAspectRatio! > 1) {
    //       memCacheWidth = width.cacheSize(context);
    //     } else if (origAspectRatio != null && origAspectRatio! < 1) {
    //       memCacheHeight = height.cacheSize(context);
    //     } else {
    //       memCacheWidth = width.cacheSize(context);
    //       memCacheHeight = height.cacheSize(context);
    //     }
    //   }
    // }
    //
    // setMemCacheSizes();
    //
    // if (memCacheWidth == null && memCacheHeight == null) {
    //   memCacheWidth = width.toInt();
    // }

    return src != "" && src != null
        ? ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(
              Radius.circular(radius ?? 10).x,
            ),
            child:
                /*Container(
          width: width,
          height: height,
          child: Image.network(
            src!,
            width: width,
            height: height,
            fit: fit,
            filterQuality: FilterQuality.low,
          )
        )*/

                CachedNetworkImage(
              imageUrl: src!,
              width: width,
              height: height,
              // memCacheWidth: memCacheWidth,
              // memCacheHeight: memCacheHeight,
              fit: fit,
              fadeOutDuration: fadeOutDuration ?? const Duration(milliseconds: 120),
              fadeInDuration: fadeInDuration ?? const Duration(milliseconds: 120),
              filterQuality: FilterQuality.low,
              errorWidget: (BuildContext context, String url, Object error) => placeholder(context, colorScheme),
              placeholder: (BuildContext context, String url) => loading(context, colorScheme),
            ),
          )
        : placeholder(context, colorScheme);
  }

  Widget loading(BuildContext context, ColorScheme colorScheme) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.4),
        borderRadius: BorderRadius.circular(const Radius.circular(10).x),
      ),
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: colorScheme.onPrimary,
          size: 100.sp,
        ),
      ),
    );
  }

  // todo 错误 点击事件
  Widget placeholder(BuildContext context, ColorScheme colorScheme) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.4),
        borderRadius: BorderRadius.circular(const Radius.circular(10).x),
      ),
      child: Center(
        child: TextButton(
          onPressed: () {},
          child: AutoSizeText(":(", style: TextStyle(fontSize: 100.sp, color: colorScheme.secondary)),
        ),
      ),
    );
  }
}

extension ImageExtension on num {
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
  });

  final String? src;
  final double width;
  final double height;
  final String? type;
  final Duration? fadeOutDuration;
  final Duration? fadeInDuration;
  final int? quality;
  final double? origAspectRatio;

  @override
  Widget build(BuildContext context) {
    final String imageUrl = src!.startsWith('//')
        ? 'https:${src!}'
        : src!;
    print(imageUrl);
    int? memCacheWidth, memCacheHeight;
    double aspectRatio = (width / height).toDouble();

    void setMemCacheSizes() {
      if (aspectRatio > 1) {
        memCacheHeight = height.cacheSize(context);
      } else if (aspectRatio < 1) {
        memCacheWidth = width.cacheSize(context);
      } else {
        if (origAspectRatio != null && origAspectRatio! > 1) {
          memCacheWidth = width.cacheSize(context);
        } else if (origAspectRatio != null && origAspectRatio! < 1) {
          memCacheHeight = height.cacheSize(context);
        } else {
          memCacheWidth = width.cacheSize(context);
          memCacheHeight = height.cacheSize(context);
        }
      }
    }

    setMemCacheSizes();

    if (memCacheWidth == null && memCacheHeight == null) {
      memCacheWidth = width.toInt();
    }

    return src != '' && src != null ?
    ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(
              type == 'avatar' ? 50 : type == 'emote' ? 0 : const Radius.circular(10).x,
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: width,
              height: height,
              memCacheWidth: memCacheWidth,
              memCacheHeight: memCacheHeight,
              fit: BoxFit.cover,
              fadeOutDuration:
                  fadeOutDuration ?? const Duration(milliseconds: 120),
              fadeInDuration:
                  fadeInDuration ?? const Duration(milliseconds: 120),
              filterQuality: FilterQuality.low,
              errorWidget: (BuildContext context, String url, Object error) =>
                  placeholder(context),
              placeholder: (BuildContext context, String url) =>
                  placeholder(context),
            ),
          )
        : placeholder(context);
  }

  Widget placeholder(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.4),
        borderRadius: BorderRadius.circular(type == 'avatar'
            ? 50
            : type == 'emote'
                ? 0
                : const Radius.circular(10).x),
      ),
      child: type == 'bg'
          ? const SizedBox()
          : Center(
              child: Image.asset(
                type == 'avatar'
                    ? 'assets/images/noface.jpeg'
                    : 'assets/images/loading.png',
                width: width,
                height: height,
                cacheWidth: width.cacheSize(context),
                cacheHeight: height.cacheSize(context),
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

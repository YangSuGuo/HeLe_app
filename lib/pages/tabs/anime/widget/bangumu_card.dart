import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hele_app/common/Widget/badge.dart';
import 'package:hele_app/common/utils/network_img.dart';
import 'package:hele_app/model/calendar.dart';

// 卡片 - 垂直布局
class BangumiCard extends StatelessWidget {
  const BangumiCard({
    super.key,
    required this.bangumiItem,
    this.longPress,
    this.longPressEnd,
  });

  final LegacySubjectSmall bangumiItem;
  final Function()? longPress;
  final Function()? longPressEnd;

  static String makeHeroTag(v) {
    return v.toString() + Random().nextInt(9999).toString();
  }

  @override
  Widget build(BuildContext context) {
    String heroTag = makeHeroTag(bangumiItem.id);
    return Card(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () async {},
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: AspectRatio(
                aspectRatio: 0.65,
                child: LayoutBuilder(builder: (context, boxConstraints) {
                  final double maxWidth = boxConstraints.maxWidth;
                  final double maxHeight = boxConstraints.maxHeight;
                  return Stack(
                    children: [
                      Hero(
                        tag: heroTag,
                        child: NetworkImg(
                          src: bangumiItem.images!.large,
                          width: maxWidth,
                          height: maxHeight,
                        ),
                      ),
                      // 评分
                      if (bangumiItem.rating!.score != null)
                        PBadge(
                            text: bangumiItem.rating!.score.toString(),
                            top: 6,
                            right: 6,
                            bottom: null,
                            left: null),
                      /* if (bangumiItem.order != null)
                        PBadge(
                          text: bangumiItem.order,
                          top: null,
                          right: null,
                          bottom: 6,
                          left: 6,
                          type: 'gray',
                        ),*/
                    ],
                  );
                }),
              ),
            ),
            BangumiContent(bangumiItem: bangumiItem)
          ],
        ),
      ),
      // ),
    );
  }
}

class BangumiContent extends StatelessWidget {
  const BangumiContent({super.key, required this.bangumiItem});

  // ignore: prefer_typing_uninitialized_variables
  final LegacySubjectSmall bangumiItem;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        // 多列
        padding: const EdgeInsets.fromLTRB(4, 5, 0, 3),
        // 单列
        // padding: const EdgeInsets.fromLTRB(14, 10, 4, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  bangumiItem.nameCn!.isEmpty
                      ? bangumiItem.name.toString()
                      : bangumiItem.nameCn.toString(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
           /* const SizedBox(height: 1),
            if (bangumiItem.indexShow != null)
              Text(
                bangumiItem.indexShow,
                maxLines: 1,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.labelMedium!.fontSize,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            if (bangumiItem.progress != null)
              Text(
                bangumiItem.progress,
                maxLines: 1,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.labelMedium!.fontSize,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),*/
          ],
        ),
      ),
    );
  }
}

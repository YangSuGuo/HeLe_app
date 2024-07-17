import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/badge.dart';
import 'package:hele_app/common/Widget/network_img.dart';
import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/routes/app_pages.dart';

// 卡片 - 垂直布局
class BangumiCard extends StatelessWidget {
  const BangumiCard({super.key, required this.bangumiItem});

  final LegacySubjectSmall bangumiItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () async {
          Get.toNamed(Routes.WIKI, arguments: {"bangumiItem": bangumiItem});
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: AspectRatio(
                aspectRatio: 0.7,
                child: LayoutBuilder(builder: (context, boxConstraints) {
                  final double maxWidth = boxConstraints.maxWidth;
                  final double maxHeight = boxConstraints.maxHeight;
                  return Stack(
                    children: [
                      NetworkImg(
                        src: bangumiItem.images?.large,
                        width: maxWidth,
                        height: maxHeight,
                      ),
                      // 评分
                      if (bangumiItem.rating?.score != null)
                        PBadge(
                            text: bangumiItem.rating!.score.toString(),
                            top: 6,
                            right: 6,
                            bottom: null,
                            left: null
                        ),
                       // 兼容 搜索API 评分
                       if (bangumiItem.score != null)
                        PBadge(
                          text: bangumiItem.score.toString(),
                          top: 6,
                          right: 6,
                          bottom: null,
                          left: null
                        ),
                    ],
                  );
                }),
              ),
            ),
            BangumiContent(bangumiItem: bangumiItem)
          ],
        ),
      ),
    );
  }
}

class BangumiContent extends StatelessWidget {
  const BangumiContent({super.key, required this.bangumiItem});

  final LegacySubjectSmall bangumiItem;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        // 多列
        padding: const EdgeInsets.fromLTRB(4, 5, 0, 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  bangumiItem.nameCn!.isEmpty ? bangumiItem.name.toString() : bangumiItem.nameCn.toString(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

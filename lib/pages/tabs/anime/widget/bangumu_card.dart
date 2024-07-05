import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/badge.dart';
import 'package:hele_app/common/utils/network_img.dart';
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
          Get.toNamed(Routes.WIKI,arguments: {"bangumiItem": bangumiItem});
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
                      if (bangumiItem.images != null)
                        Hero(
                          tag: bangumiItem.id.toString(),
                          child: NetworkImg(
                            src: bangumiItem.images?.common ??
                                'https://img.picui.cn/free/2024/07/01/66824a43e0e23.png',
                            width: maxWidth,
                            height: maxHeight,
                          ),
                        ),
                      if (bangumiItem.images == null)
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onInverseSurface
                                .withOpacity(0.4),
                            borderRadius: BorderRadius.circular(
                                const Radius.circular(10).x),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/images/svg/defaultPageNoImage.svg",
                            ),
                          ),
                        ),
                      // 评分
                      if (bangumiItem.rating?.score != null)
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
                  bangumiItem.nameCn!.isEmpty
                      ? bangumiItem.name.toString()
                      : bangumiItem.nameCn.toString(),
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

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hele_app/common/Widget/network_img.dart';
import 'package:hele_app/pages/apply_data/widget/common_card.dart';

class SeriesInfo extends StatelessWidget {
  const SeriesInfo({
    super.key,
    required this.name,
    required this.nameCn,
    required this.images,
    this.relation,
  });

  final String name;
  final String nameCn;
  final String images;
  final String? relation;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
        padding: EdgeInsets.only(bottom: 20.h, left: 24.w, right: 24.w),
        child: CommonCard(
            type: CommonCardType.plain,
            onPressed: () {},
            child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                  height: 170.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      NetworkImg(
                        src: images,
                        width: 140.w,
                        height: constraints.maxHeight,
                      ),
                      Gap(20.w),
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 标题
                          Gap(10.h),
                          Row(children: [
                            Expanded(
                              child: AutoSizeText(
                                relation!,
                                maxLines: 1,
                                minFontSize: 17,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, color: colorScheme.secondary.withOpacity(0.8)),
                              ),
                            ),
                          ]),
                          Gap(5.h),
                          AutoSizeText(
                            (nameCn != "" ? nameCn : name).trim(),
                            maxLines: 1,
                            minFontSize: 17,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.secondary),
                          )
                        ],
                      ))
                    ],
                  ));
            })));
  }
}

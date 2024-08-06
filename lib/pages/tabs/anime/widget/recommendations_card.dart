import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/network_img.dart';
import 'package:hele_app/model/calendar/calendar.dart';
import 'package:hele_app/model/search/search.dart';
import 'package:hele_app/routes/app_pages.dart';

class RecommendationsCard extends StatelessWidget {
  const RecommendationsCard({
    super.key,
    this.data,
  });

  final Datum? data;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: InkWell(onTap: () async {
          LegacySubjectSmall toLegacySubjectSmall =
              data!.toLegacySubjectSmall();
          await Get.toNamed(Routes.WIKI,
              arguments: {"bangumiItem": toLegacySubjectSmall});
        }, child: LayoutBuilder(builder: (context, constraints) {
          final double maxWidth = MediaQuery.of(context).size.width * 0.65;
          final double maxHeight = constraints.maxHeight;
          return Stack(
            children: [
              NetworkImg(
                src: data?.image ?? "",
                fit: BoxFit.fitWidth,
                width: maxWidth,
                height: maxHeight,
              ),
              // 渐变遮罩
              Positioned.fill(
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0),
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  ])))),
              Positioned(
                  bottom: 20.h,
                  left: 20.w,
                  child: SizedBox(
                    width: maxWidth - 60.w,
                    child: AutoSizeText(data?.nameCn ?? "",
                        minFontSize: 16,
                        maxFontSize: 20,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: colorScheme.onSecondary,
                        )),
                  ))
            ],
          );
        })));
  }
}

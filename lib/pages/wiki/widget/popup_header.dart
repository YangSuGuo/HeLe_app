import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PopupHeader extends StatelessWidget {
  const PopupHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.showClose,
  });

  final String title;
  final String? subtitle;
  final bool? showClose;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.secondary,
              ),
            ),
            // 副标题
            if (subtitle != "")
              Padding(
                  padding: EdgeInsets.only(top: 6.h, bottom: 16.h),
                  child: AutoSizeText(
                    subtitle ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.secondary.withOpacity(0.7),
                    ),
                  )),
          ],
        )),
        if (showClose ?? false)
          InkWell(
              onTap: () => SmartDialog.dismiss(force: true),
              child: Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: FaIcon(FontAwesomeIcons.xmark, size: 66.sp, color: colorScheme.secondary),
              ))
      ],
    );
  }
}

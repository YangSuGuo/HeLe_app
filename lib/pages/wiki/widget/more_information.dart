import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoreInformation extends StatelessWidget {
  const MoreInformation({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return InkWell(
        onTap: onTap,
        child: SizedBox(
            width: 80.w,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AutoSizeText("更多",
                      minFontSize: 12,
                      maxFontSize: 20,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: colorScheme.secondary.withOpacity(0.9),
                      )),
                  FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 23.sp,
                    color: colorScheme.secondary.withOpacity(0.9),
                  )
                ])));
  }
}

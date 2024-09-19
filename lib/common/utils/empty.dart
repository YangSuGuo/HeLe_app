import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          ":(",
          style: TextStyle(fontSize: 100.sp, color: colorScheme.secondary),
        ),
        Gap(10.h),
        AutoSizeText(
          "暂无数据",
          style: TextStyle(fontSize: 30.sp, color: colorScheme.secondary),
        ),
        Gap(150.h),
      ],
    ));
  }
}

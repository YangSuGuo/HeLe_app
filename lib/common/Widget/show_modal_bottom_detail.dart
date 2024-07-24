import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 底部模态框
Future<T?> showModalBottomDetail<T>({
  required BuildContext context,
  required Widget child,
  required double height,
}) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  return showModalBottomSheet<T>(
    context: context,
    // showDragHandle: true, // 显示拖拽小横条
    backgroundColor: colorScheme.surfaceContainerHighest,
    barrierColor: colorScheme.shadow.withOpacity(0.35),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(42.r),
        topRight: Radius.circular(42.r),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
          height: height,
          child: Column(
            children: [
              // 顶部拖拽小横条
              Semantics(
                button: true,
                onTap: () => Get.back(),
                child: Container(
                  margin: EdgeInsets.only(top: 24.h, bottom: 16.h),
                  height: 8.w,
                  width: 82.w,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              Expanded(child: child),
            ],
          ));
    },
  );
}

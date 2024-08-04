import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditPopup extends StatelessWidget {
  const EditPopup({
    super.key,
    required this.title,
    required this.controller,
    required this.onChanged,
    required this.onPressed,
  });

  final String title;
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: Get.width * 0.8,
      height: Get.height * 0.25,
      padding: EdgeInsets.fromLTRB(36.w, 36.h, 36.w, 24.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(36.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 标题
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
          Gap(12.h),
          TextField(
            autofocus: true,
            focusNode: FocusNode(),
            controller: controller,
            textInputAction: TextInputAction.search,
            style: TextStyle(color: colorScheme.secondary),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "标签",
              // filled: true,
              // fillColor: colorScheme.inversePrimary.withOpacity(0.2),
            ),
            onChanged: onChanged,
          ),
          Gap(12.h),
          Wrap(spacing: 100.w, children: [
            ElevatedButton(
              onPressed: () => SmartDialog.dismiss(force: true),
              style:
              ElevatedButton.styleFrom(elevation: 0, backgroundColor: colorScheme.inversePrimary.withOpacity(0.3)),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: onPressed,
              style:
              ElevatedButton.styleFrom(elevation: 0, backgroundColor: colorScheme.inversePrimary.withOpacity(0.4)),
              child: const Text('确定'),
            )
          ]),
        ],
      ),
    );
  }
}

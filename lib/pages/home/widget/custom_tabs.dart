import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hele_app/pages/home/controllers/home_controller.dart';

class CustomTabs extends StatefulWidget {
  const CustomTabs({super.key});

  @override
  State<CustomTabs> createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs> {
  final HomeController _homeController = Get.find<HomeController>();

  void onTap(int index) {
    if (_homeController.initialIndex.value == index) {
      _homeController.tabsCtrList[index]().animateToTop();
    }
    _homeController.initialIndex.value = index;
    _homeController.tabController.index = index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      margin: EdgeInsets.only(top: 8.h),
      child: Obx(
        () => ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          scrollDirection: Axis.horizontal,
          itemCount: _homeController.tabs.length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 20.w);
          },
          itemBuilder: (BuildContext context, int index) {
            String label = _homeController.tabs[index]['label'];
            return Obx(
              () => CustomChip(
                onTap: () => onTap(index),
                label: label,
                selected: index == _homeController.initialIndex.value,
              ),
            );
          },
        ),
      ),
    );
  }
}

// todo 标签切换动画
class CustomChip extends StatelessWidget {
  final Function onTap;
  final String label;
  final bool selected;
  final bool isTranslucent;

  const CustomChip({
    super.key,
    required this.onTap,
    required this.label,
    required this.selected,
    this.isTranslucent = false,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color selectedColor = colorScheme.secondaryContainer;
    final TextStyle chipTextStyle = selected
        ? TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp)
        : TextStyle(fontSize: 24.sp);

    return isTranslucent
        ? InputChip(
            side: const BorderSide(
              color: Colors.transparent,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            selectedColor: colorScheme.primary.withAlpha(120),
            backgroundColor: colorScheme.primary.withAlpha(40),
            padding: selected
                ? EdgeInsets.fromLTRB(12.w, 5.h, 12.w, 5.h)
                : EdgeInsets.fromLTRB(12.w, 5.h, 12.w, 5.h),
            label: Text(label),
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
            onPressed: () => onTap(),
            selected: selected,
            showCheckmark: false,
            visualDensity: const VisualDensity(horizontal: 0.0, vertical: -2.0),
          )
        : InputChip(
            side: const BorderSide(
              color: Colors.transparent,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            padding: selected
                ? EdgeInsets.fromLTRB(24.w, 5.h, 24.w, 5.h)
                : EdgeInsets.fromLTRB(12.w, 5.h, 12.w, 5.w),
            label: Text(label),
            labelStyle: chipTextStyle,
            onPressed: () => onTap(),
            selected: selected,
            showCheckmark: false,
            visualDensity: const VisualDensity(horizontal: 0.0, vertical: -2.0),
          );
  }
}

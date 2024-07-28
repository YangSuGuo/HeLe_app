import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeCard extends StatelessWidget {
  const ThemeCard({
    super.key,
    required this.child,
    this.title,
    this.selected,
    required this.width,
    required this.height,
    required this.borderCurvature,
    required this.containerCurvature,
    required this.iconOffset,
    this.isExplanationText,
    required this.showBorder,
    this.onTap,
  });

  final Widget child;
  final String? title;
  final bool? selected;
  final double width;
  final double height;
  final double borderCurvature;
  final double containerCurvature;
  final EdgeInsets iconOffset;
  final bool showBorder;
  final bool? isExplanationText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selected ?? false;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Container(
                width: width,
                height: height,
                decoration: showBorder
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(borderCurvature),
                        border: isSelected
                            ? Border.all(
                                width: 5.w,
                                color: colorScheme.shadow,
                              )
                            : Border.all(
                                width: 5.w,
                                color: colorScheme.outlineVariant,
                              ),
                      )
                    : const BoxDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(containerCurvature),
                  child: ExcludeSemantics(child: child),
                ),
              ),
              Builder(
                builder: (_) {
                  if (!isSelected) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: iconOffset,
                    child: Icon(
                      Icons.check_circle,
                      size: 40.sp,
                      color: colorScheme.primaryContainer,
                    ),
                  );
                },
              ),
            ],
          ),
          if (isExplanationText ?? false)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                title ?? '',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: colorScheme.secondary),
              ),
            ),
        ],
      ),
    );
  }
}

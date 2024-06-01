import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hele_app/common/Widget/animation.dart';
import 'package:hele_app/themes/app_theme.dart';

class FilterBottom extends StatelessWidget {
  const FilterBottom(
    this.text, {
    super.key,
    required this.width,
    required this.height,
    required this.radius,
    required this.fontSize,
    required this.checked,
    this.semanticsLabel,
    this.onTap,
  });

  final bool checked;
  final String text;
  final double width;
  final double height;
  final double radius;
  final double fontSize;
  final String? semanticsLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedPress(
      child: Semantics(
        button: true,
        label: semanticsLabel,
        excludeSemantics: true,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: width,
            height: height,
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: checked
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(radius),
              boxShadow: checked
                  ? [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        blurRadius: 6,
                      )
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 6,
                      )
                    ],
            ),
            child: Text(
              text,
              style: TextStyle(
                color: checked
                    ? Colors.white
                    : isDarkMode(context)
                        ? Colors.white
                        : Colors.black87,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EntryTitle extends StatelessWidget {
  const EntryTitle(
      {super.key,
      required this.title,
      this.semanticsLabel,
      this.size,
      required this.fontWeight,
      this.child});

  final String title;
  final String? semanticsLabel;
  final double? size;
  final FontWeight fontWeight;
  final Widget? child;

  @override
  SliverToBoxAdapter build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SliverToBoxAdapter(
      child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            AutoSizeText(
              title,
              style: TextStyle(
                  fontSize: size,
                  fontWeight: fontWeight,
                  color: colorScheme.secondary),
              semanticsLabel: semanticsLabel,
            ),
            SizedBox(height: 50.h, child: child)
          ]),
    );
  }
}

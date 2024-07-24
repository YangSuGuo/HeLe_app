import 'package:flutter/material.dart';
import 'package:nil/nil.dart';

class PBadge extends StatelessWidget {
  final String? text;
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  final String? stack;
  final double? fs;
  final Color? bgColor;

  const PBadge({
    super.key,
    this.text,
    this.top,
    this.right,
    this.bottom,
    this.left,
    this.bgColor,
    this.stack = 'position',
    this.fs = 11,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme t = Theme.of(context).colorScheme;
    Color bg = t.primary.withOpacity(0.85);
    Color color = t.onPrimary;
    Color borderColor = Colors.transparent;

    EdgeInsets paddingStyle =
        const EdgeInsets.symmetric(vertical: 1, horizontal: 6);
    BorderRadius br = BorderRadius.circular(4);

    Widget content = Container(
      padding: paddingStyle,
      decoration: BoxDecoration(
        borderRadius: br,
        color: bgColor ?? bg,
        border: Border.all(color: borderColor),
      ),
      child: Text(
        text!,
        style: TextStyle(fontSize: fs, color: color),
      ),
    );

    if (stack == 'position' && text != "") {
      return Positioned(
        top: top,
        left: left,
        right: right,
        bottom: bottom,
        child: content,
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(right: 5),
        child: nil,
      );
    }
  }
}

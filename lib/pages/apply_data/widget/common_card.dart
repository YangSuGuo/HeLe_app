import 'package:flutter/material.dart';
import 'package:hele_app/pages/apply_data/model/info.dart';
import 'package:hele_app/pages/apply_data/widget/info_header.dart';

enum CommonCardType { plain, filled }

class CommonCard extends StatelessWidget {
  const CommonCard({
    super.key,
    bool? isSelected,
    this.type = CommonCardType.plain,
    this.onPressed,
    this.info,
    this.selectWidget,
    this.radius = 12,
    required this.child,
  }) : isSelected = isSelected ?? false;

  final bool isSelected;
  final void Function()? onPressed;
  final Widget? selectWidget;
  final Widget child;
  final Info? info;
  final CommonCardType type;
  final double radius;

  //  边框
  BorderSide getBorderSide(BuildContext context, Set<WidgetState> states) {
    if (type == CommonCardType.filled) {
      return BorderSide.none;
    }
    final colorScheme = Theme.of(context).colorScheme;
    final hoverColor = isSelected ? colorScheme.primary.withOpacity(0.6) : colorScheme.primary.withOpacity(0.4);
    if (states.contains(WidgetState.hovered) ||
        states.contains(WidgetState.focused) ||
        states.contains(WidgetState.pressed)) {
      return BorderSide(
        color: hoverColor,
      );
    }
    return BorderSide(
      color: isSelected ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.12),
    );
  }

  // 颜色
  Color? getBackgroundColor(BuildContext context, Set<WidgetState> states) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (type) {
      case CommonCardType.plain:
        if (isSelected) {
          return colorScheme.secondaryContainer;
        }
        if (states.isEmpty) {
          return colorScheme.secondaryContainer.withOpacity(0.03);
        }
        return Theme.of(context).outlinedButtonTheme.style?.backgroundColor?.resolve(states);
      case CommonCardType.filled:
        if (isSelected) {
          return colorScheme.secondaryContainer;
        }
        if (states.isEmpty) {
          return colorScheme.surfaceContainerLow;
        }
        return colorScheme.surfaceContainer;
    }
  }

  @override
  Widget build(BuildContext context) {
    var childWidget = child;

    if (info != null) {
      childWidget = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 0,
            child: InfoHeader(
              info: info!,
            ),
          ),
          Flexible(
            child: child,
          ),
        ],
      );
    }
    return OutlinedButton(
      clipBehavior: Clip.antiAlias,
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => getBackgroundColor(context, states),
        ),
        side: WidgetStateProperty.resolveWith(
          (states) => getBorderSide(context, states),
        ),
      ),
      onPressed: onPressed,
      child: Builder(
        builder: (_) {
          if (selectWidget == null) {
            return childWidget;
          }
          List<Widget> children = [];
          children.add(childWidget);
          if (isSelected) {
            children.add(
              Positioned.fill(
                child: selectWidget!,
              ),
            );
          }
          return Stack(
            children: children,
          );
        },
      ),
    );
  }
}

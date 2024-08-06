import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActionItem extends StatelessWidget {
  final Icon? icon;
  final Icon? selectIcon;
  final Function? onTap;
  final String? text;
  final bool selectStatus;

  const ActionItem({
    super.key,
    this.icon,
    this.selectIcon,
    this.onTap,
    this.text,
    this.selectStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {HapticFeedback.lightImpact(), onTap!()},
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 4),
          selectStatus
              ? Icon(selectIcon!.icon!,
                  size: 18, color: Theme.of(context).colorScheme.primary)
              : Icon(icon!.icon!,
                  size: 18, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 6),
          Text(
            text ?? '',
            style: TextStyle(
              color: selectStatus
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline,
              fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
            ),
          )
        ],
      ),
    );
  }
}

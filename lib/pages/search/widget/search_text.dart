import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SearchText extends StatelessWidget {
  final String searchText;
  final bool? isSelected;
  final Function? onSelect;
  final Function? onLongSelect;
  final Color colors;

  const SearchText({
    super.key,
    required this.searchText,
    this.isSelected,
    this.onSelect,
    this.onLongSelect,
    this.colors = Colors.blueGrey,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ?? false ? colors : Theme.of(context).colorScheme.secondary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: EdgeInsets.zero,
        child: InkWell(
          onTap: () {
            onSelect!(searchText);
          },
          onLongPress: () {
            onLongSelect!(searchText);
          },
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 11, right: 11),
            child: AutoSizeText(
              searchText,
              minFontSize: 12,
              maxLines: 1,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
        ),
      ),
    );
  }
}

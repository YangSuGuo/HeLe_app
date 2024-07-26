import 'package:flutter/material.dart';

class SearchText extends StatelessWidget {
  final String searchText;
  final Function? onSelect;
  final Function? onLongSelect;

  const SearchText({
    super.key,
    required this.searchText,
    this.onSelect,
    this.onLongSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
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
            child: Text(
              searchText,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
        ),
      ),
    );
  }
}

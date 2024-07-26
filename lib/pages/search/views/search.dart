import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/pages/search/controllers/search_controller.dart';
import 'package:hele_app/pages/search/widget/search_text.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchPageController _searchController = Get.put(SearchPageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(colorScheme),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 搜索历史
            _history()
          ],
        ),
      ),
    );
  }

  // appbar
  AppBar _buildAppBar(ColorScheme colorScheme) {
    return AppBar(
      shape: Border(
        bottom: BorderSide(
          color: Theme.of(context).dividerColor.withOpacity(0.08),
          width: 1,
        ),
      ),
      titleSpacing: 0,
      actions: [
        IconButton(
            onPressed: () => _searchController.submit(), icon: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 40.sp)),
        Gap(20.w)
      ],
      title: Obx(
        () => TextField(
          autofocus: true,
          focusNode: _searchController.searchFocusNode,
          controller: _searchController.controller.value,
          textInputAction: TextInputAction.search,
          onChanged: (value) => _searchController.keyword.value = value,
          decoration: InputDecoration(
            hintText: _searchController.hintText,
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                size: 22,
                color: colorScheme.outline,
              ),
              onPressed: () {
                _searchController.onClear();
              },
            ),
          ),
          onSubmitted: (String value) {},
        ),
      ),
    );
  }

  // 搜索历史
  Widget _history() {
    return Obx(() => Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(36.w, 6.h, 36.w, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (_searchController.historyList.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '搜索历史',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => _searchController.onClearHis(),
                  child: const Text('清空'),
                )
              ],
            ),
          Obx(() =>
              Wrap(spacing: 8, runSpacing: 8, direction: Axis.horizontal, textDirection: TextDirection.ltr, children: [
                for (int i = 0; i < _searchController.historyList.length; i++)
                  SearchText(
                    searchText: _searchController.historyList[i],
                    searchTextIdx: i,
                    onSelect: (value) => _searchController.onTagClick(value),
                  )
              ]))
        ])));
  }
}

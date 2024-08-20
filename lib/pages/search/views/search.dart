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
  final SearchPageController _searchController = Get.find<SearchPageController>();

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
            // 筛选
            categoryFilter(colorScheme),
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

  // 分类筛选
  Widget categoryFilter(ColorScheme colorScheme) {
    return Container(
        height: 80.h,
        padding: EdgeInsets.fromLTRB(36.w, 12.h, 20.w, 0),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 20.w);
          },
          itemBuilder: (BuildContext context, int index) {
            return Obx(() => FilterChip(
                selected: index == _searchController.type.value,
                // avatar: const CircleAvatar(),
                label: Text(_searchController.tags[index]),
                backgroundColor: colorScheme.primary.withAlpha(40),
                side: const BorderSide(color: Colors.transparent),
                showCheckmark: true,
                visualDensity: const VisualDensity(horizontal: 0.0, vertical: -2.0),
                onSelected: (bool value) {
                  _searchController.type.value = index;
                }));
          },
        ));
  }

  // 搜索历史
  Widget _history() {
    return Obx(() => Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(36.w, 0.h, 36.w, 0),
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
                    onSelect: (value) => _searchController.onTagClick(value),
                  )
              ]))
        ])));
  }
}

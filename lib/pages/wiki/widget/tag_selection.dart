import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hele_app/pages/search/widget/search_text.dart';
import 'package:hele_app/pages/wiki/controllers/wiki_controller.dart';

class TagSelection extends StatefulWidget {
  const TagSelection({super.key});

  @override
  State<TagSelection> createState() => _TagSelectionState();
}

class _TagSelectionState extends State<TagSelection> {
  final WikiController _wikiController = Get.find<WikiController>();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth,
        height: Get.height * 0.21,
        // color: Colors.teal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(colorScheme),
            SizedBox(
                height: Get.height * 0.17,
                child: PageView(children: [
                  _tabNavigator(List.generate(_wikiController.tags.length, (index) {
                    return Obx(() => SearchText(
                          searchText: _wikiController.tags[index],
                          isSelected: _wikiController.isTags[index],
                          colors: colorScheme.primaryContainer.withOpacity(0.25),
                          onSelect: (value) {
                            _wikiController.addTag(false, index);
                          },
                        ));
                  })),
                  if (_wikiController.userTags.isNotEmpty)
                    _tabNavigator(List.generate(_wikiController.userTags.length, (index) {
                      return Obx(() => SearchText(
                            searchText: _wikiController.userTags[index].tag,
                            isSelected: _wikiController.isUserTags[index],
                            colors: colorScheme.primaryContainer.withOpacity(0.25),
                            onSelect: (value) {
                              _wikiController.addTag(true, index);
                            },
                          ));
                    })),
                ])),
          ],
        ),
      );
    });
  }

  // 标题
  Widget _title(ColorScheme colorScheme) {
    return Wrap(alignment: WrapAlignment.start, crossAxisAlignment: WrapCrossAlignment.center, children: [
      AutoSizeText(
        "标签",
        style: TextStyle(fontSize: 34.sp, fontWeight: FontWeight.w600, color: colorScheme.secondary.withOpacity(0.8)),
      ),
      AutoSizeText(
        "（右划用户标签）",
        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: colorScheme.secondary.withOpacity(0.8)),
      ),
    ]);
  }

  // 标签页
  Widget _tabNavigator(List<Widget> children) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Wrap(
            spacing: 8,
            runSpacing: 8,
            direction: Axis.horizontal,
            textDirection: TextDirection.ltr,
            children: children),
      ],
    );
  }
}

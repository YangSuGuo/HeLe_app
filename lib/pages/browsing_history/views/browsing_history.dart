import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hele_app/pages/browsing_history/controllers/browsing_history_controllers.dart';
import 'package:hele_app/pages/rank_list/widget/ranked_cards_list.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BrowsingHistory extends StatefulWidget {
  const BrowsingHistory({super.key});

  @override
  State<BrowsingHistory> createState() => _BrowsingHistoryState();
}

class _BrowsingHistoryState extends State<BrowsingHistory> {
  final BrowsingHistoryControllers _browsingHistoryControllers = Get.put(BrowsingHistoryControllers());
  Future? _history;

  @override
  void initState() {
    super.initState();
    _history = _browsingHistoryControllers.findAllSubjectsHistory();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme
        .of(context)
        .colorScheme;

    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: Theme
                .of(context)
                .dividerColor
                .withOpacity(0.08),
            width: 1,
          ),
        ),
        titleSpacing: 0,
        centerTitle: false,
        title: Text(
          "浏览历史",
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: IconButton(
                icon: const Icon(
                  Icons.delete_outlined,
                ),
                color: colorScheme.secondary,
                onPressed: () {
                  _show(_delete(colorScheme));
                },
              ))
        ],
      ),
      body: FutureBuilder(
          future: _history,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Obx(() =>
                  ListView.builder(
                      itemCount: _browsingHistoryControllers.subjectsHistoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RankedCardsList(
                          datum: _browsingHistoryControllers.datumList[index],
                          index: index,
                          isRank: false,
                        );
                      }));
            } else {
              return Center(
                child: LoadingAnimationWidget.stretchedDots(
                  color: colorScheme.primary,
                  size: 140.sp,
                ),
              );
            }
          }),
    );
  }

  void _show(Widget child) async {
    await SmartDialog.show(
        clickMaskDismiss: true,
        usePenetrate: false,
        debounce: true,
        onDismiss: () => SmartDialog.config.attach = SmartConfigAttach(),
        builder: (_) {
          return child;
        });
  }

  Widget _delete(ColorScheme colorScheme) {
    return Container(
      width: Get.width * 0.8,
      height: Get.height * 0.18,
      padding: EdgeInsets.fromLTRB(36.w, 36.h, 36.w, 24.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(36.r),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        AutoSizeText(
          "清空全部历史记录？",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 36.sp,
            fontWeight: FontWeight.bold,
            color: colorScheme.secondary,
          ),
        ),
        Wrap(spacing: 100.w, children: [
          ElevatedButton(
            onPressed: () => SmartDialog.dismiss(force: true),
            style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: colorScheme.inversePrimary.withOpacity(0.3)),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              _browsingHistoryControllers.deleteAllSubjectsHistory();
              _browsingHistoryControllers.findAllSubjectsHistory();
              SmartDialog.dismiss(force: true);
            },
            style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: colorScheme.inversePrimary.withOpacity(0.4)),
            child: const Text('确定'),
          )
        ]),
      ]),
    );
  }
}

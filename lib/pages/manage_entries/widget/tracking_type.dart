import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/utils/evaluation_utils.dart';
import 'package:hele_app/db/database/entity/subjects_star.dart';
import 'package:hele_app/pages/manage_entries/controllers/manage_entries_controllers.dart';
import 'package:hele_app/pages/manage_entries/widget/series_info_panel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TrackingType extends StatefulWidget {
  const TrackingType({super.key, required this.index});

  final int index;

  @override
  State<TrackingType> createState() => _TrackingTypeState();
}

class _TrackingTypeState extends State<TrackingType> with AutomaticKeepAliveClientMixin {
  final ManageEntriesControllers _manageEntriesControllers = Get.find<ManageEntriesControllers>();
  Future? trackingType;
  late ScrollController scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    trackingType = _manageEntriesControllers.getTrackingType();
    scrollController = _manageEntriesControllers.scrollController;
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        EasyThrottle.throttle('trackingType', const Duration(seconds: 1), () {
          _manageEntriesControllers.next();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return FutureBuilder(
        future: trackingType,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(() {
              if (_manageEntriesControllers.length[widget.index] != 0) {
                return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _manageEntriesControllers.length[widget.index],
                    itemBuilder: (BuildContext context, int index) {
                      final SubjectsStar subjectsStar =
                          _manageEntriesControllers.getTrackingListByIndex(widget.index)[index];
                      final List<String> tags = EvaluationUtils.toTagsList(subjectsStar.tags ?? "[]");
                      return SeriesInfoPanel(
                        subjectsStar: subjectsStar,
                        tags: tags,
                        buttonText: _manageEntriesControllers.buttonList[widget.index],
                        isSelected: subjectsStar.isCollected,
                        onPressed: () {
                          int s = _manageEntriesControllers.statusList[widget.index];
                          _manageEntriesControllers.updateSubjectsStarStatus(subjectsStar, s);
                          _manageEntriesControllers.getTrackingType();
                        },
                        edit: (int index) {
                          _manageEntriesControllers.updateSubjectsStarStatus(subjectsStar, index);
                          _manageEntriesControllers.getTrackingType();
                        },
                        delete: () {
                          _show(_deleteTag(subjectsStar, colorScheme));
                        },
                      );
                    });
              } else {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      ":(",
                      style: TextStyle(fontSize: 100.sp, color: colorScheme.secondary),
                    ),
                    Gap(10.h),
                    AutoSizeText(
                      "暂无数据",
                      style: TextStyle(fontSize: 30.sp, color: colorScheme.secondary),
                    ),
                    Gap(150.h),
                  ],
                ));
              }
            });
          } else {
            return Center(
              child: LoadingAnimationWidget.stretchedDots(
                color: colorScheme.primary,
                size: 140.sp,
              ),
            );
          }
        });
  }

  // 弹框
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

  // 删除
  Widget _deleteTag(SubjectsStar subjectsStar, ColorScheme colorScheme) {
    return Container(
      width: Get.width * 0.8,
      height: Get.height * 0.2,
      padding: EdgeInsets.fromLTRB(36.w, 36.h, 36.w, 24.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(36.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 标题
          AutoSizeText(
            "确定删除？",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
              color: colorScheme.secondary,
            ),
          ),
          Gap(12.h),
          AutoSizeText(
            subjectsStar.nameCn != "" || subjectsStar.name != ""
                ? subjectsStar.nameCn != ""
                    ? subjectsStar.nameCn
                    : subjectsStar.name
                : "获取失败！",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              color: colorScheme.secondary.withOpacity(0.7),
            ),
          ),
          Wrap(spacing: 100.w, children: [
            ElevatedButton(
              onPressed: () => SmartDialog.dismiss(force: true),
              style:
                  ElevatedButton.styleFrom(elevation: 0, backgroundColor: colorScheme.inversePrimary.withOpacity(0.3)),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () {
                _manageEntriesControllers.deleteSubjectsStar(subjectsStar);
                _manageEntriesControllers.getTrackingType();
                SmartDialog.dismiss(force: true);
              },
              style:
                  ElevatedButton.styleFrom(elevation: 0, backgroundColor: colorScheme.inversePrimary.withOpacity(0.4)),
              child: const Text('确定'),
            )
          ]),
        ],
      ),
    );
  }
}

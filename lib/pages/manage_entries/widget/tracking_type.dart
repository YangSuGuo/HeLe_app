import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/utils/evaluation_utils.dart';
import 'package:hele_app/db/database/entity/subjects_star.dart';
import 'package:hele_app/pages/manage_entries/controllers/manage_entries_controllers.dart';
import 'package:hele_app/pages/manage_entries/widget/series_info_panel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TrackingType extends StatefulWidget {
  const TrackingType({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<TrackingType> createState() => _TrackingTypeState();
}

class _TrackingTypeState extends State<TrackingType> with AutomaticKeepAliveClientMixin {
  final ManageEntriesControllers _manageEntriesControllers = Get.put(ManageEntriesControllers());
  Future? trackingType;
  late ScrollController scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    trackingType = _manageEntriesControllers.getTrackingType();
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
}

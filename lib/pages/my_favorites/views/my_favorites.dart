import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/utils/evaluation_utils.dart';
import 'package:hele_app/db/database/entity/subjects_star.dart';
import 'package:hele_app/pages/manage_entries/widget/series_info_panel.dart';
import 'package:hele_app/pages/my_favorites/controllers/my_favorites_controllers.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyFavorites extends StatefulWidget {
  const MyFavorites({super.key});

  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  final MyFavoritesControllers _myFavoritesControllers = Get.find<MyFavoritesControllers>();

  // final MyFavoritesControllers _myFavoritesControllers = Get.put(MyFavoritesControllers());
  Future? _userFavorites;

  @override
  void initState() {
    super.initState();
    _userFavorites = _myFavoritesControllers.getAllUserFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.08),
            width: 1,
          ),
        ),
        titleSpacing: 0,
        centerTitle: false,
        title: Text(
          "我的收藏",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: FutureBuilder(
          future: _userFavorites,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<SubjectsStar> subjectsStar = snapshot.data;
              if (subjectsStar.isNotEmpty) {
                return Obx(() {
                  return ListView.builder(
                      padding: EdgeInsets.only(top: 20.h),
                      itemCount: _myFavoritesControllers.stars.length,
                      itemBuilder: (BuildContext context, int index) {
                        final SubjectsStar star = _myFavoritesControllers.stars[index];
                        final List<String> tags = EvaluationUtils.toTagsList(star.tags ?? "[]");
                        return SeriesInfoPanel(
                          subjectsStar: star,
                          tags: tags,
                          buttonText: "取消收藏",
                          isSelected: star.isCollected,
                          onPressed: () {
                            _myFavoritesControllers.updateSubjectsStarStatus(star);
                            _myFavoritesControllers.getAllUserFavorites();
                          },
                          edit: (int index) {},
                          delete: () {},
                          showDeleteButton: false,
                          showEditButton: false,
                        );
                      });
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
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/utils/empty.dart';
import 'package:hele_app/db/database/entity/subjects_user_tags.dart';
import 'package:hele_app/pages/user_tags/controllers/user_tags_controllers.dart';
import 'package:hele_app/pages/user_tags/widget/edit_popup.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserTags extends StatefulWidget {
  const UserTags({super.key});

  @override
  State<UserTags> createState() => _UserTagsState();
}

class _UserTagsState extends State<UserTags> {
  final UserTagsControllers _userTagsControllers = Get.put(UserTagsControllers());
  Future? _userTags;

  @override
  void initState() {
    super.initState();
    _userTags = _userTagsControllers.querySubjectsUserTags();
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
            "编辑分类",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: FutureBuilder(
            future: _userTags,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // todo 统一空数据展示
                return Obx(() {
                  if (_userTagsControllers.tags.isNotEmpty) {
                    return ListView.builder(
                        itemCount: _userTagsControllers.tags.length,
                        itemBuilder: (BuildContext context, int index) {
                          return tagCard(_userTagsControllers.tags[index], colorScheme);
                        });
                  } else {
                    return const Empty();
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
            }),
        floatingActionButton: Container(
          width: 170.w,
          // padding: EdgeInsets.only(right: 20.w),
          child: FloatingActionButton(
            // todo 重复项检查
            onPressed: () {
              _show(EditPopup(
                title: "添加标签",
                controller: _userTagsControllers.controller.value,
                onChanged: (value) {
                  _userTagsControllers.tag.value = value;
                },
                onPressed: () {
                  _userTagsControllers.editTag(true, null);
                },
              ));
            },
            elevation: 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.add,
                  color: colorScheme.onPrimary,
                ),
                Text(
                  "添加",
                  style: TextStyle(color: colorScheme.onPrimary, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ) // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
  }

  // todo 点击跳转该分类作品
  Widget tagCard(SubjectsUserTags tag, ColorScheme colorScheme) {
    return Padding(
        padding: EdgeInsets.fromLTRB(25.w, 20.h, 25.w, 0.h),
        child: Container(
            height: 145.h,
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
            decoration: BoxDecoration(
              // color: colorScheme.inversePrimary.withOpacity(0.26),
              color: colorScheme.onInverseSurface,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Gap(12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15.w, left: 20.w),
                      child: FaIcon(
                        Icons.label_outline,
                        color: colorScheme.primary,
                        size: 46.sp,
                      ),
                    ),
                    Expanded(
                        child: AutoSizeText(
                      tag.tag,
                      maxLines: 1,
                      style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.w500),
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          _userTagsControllers.controller.value.text = tag.tag;
                          // _show(_addTag("修改标签", false, colorScheme, tag));
                          _show(EditPopup(
                            title: "修改标签",
                            controller: _userTagsControllers.controller.value,
                            onChanged: (value) {
                              _userTagsControllers.tag.value = value;
                            },
                            onPressed: () {
                              _userTagsControllers.editTag(false, tag);
                            },
                          ));
                        },
                        iconSize: 45.sp,
                        color: colorScheme.primary,
                        icon: const FaIcon(
                          Icons.edit_outlined,
                        )),
                    IconButton(
                        onPressed: () {
                          _show(_deleteTag(tag, colorScheme));
                        },
                        iconSize: 45.sp,
                        color: colorScheme.primary,
                        icon: const FaIcon(
                          Icons.delete_outline,
                        ))
                  ],
                )
              ],
            )));
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
  Widget _deleteTag(SubjectsUserTags tag, ColorScheme colorScheme) {
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
            "确定删除标签？",
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
            tag.tag,
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
                _userTagsControllers.deleteSubjectsUserTags(tag);
                _userTags = _userTagsControllers.querySubjectsUserTags();
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

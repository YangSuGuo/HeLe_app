import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/db/database/entity/subjects_user_tags.dart';
import 'package:hele_app/pages/user_tags/controllers/user_tags_controllers.dart';
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
                List<SubjectsUserTags> s = snapshot.data;
                log(s.length.toString());
                return ListView.builder(
                    itemCount: s.length,
                    itemBuilder: (BuildContext context, int index) {
                      return tagCard(s[index].tag, colorScheme);
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
            // todo 添加逻辑
            onPressed: () {},
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

  // todo 点击事件 修改与删除
  Widget tagCard(String tag, ColorScheme colorScheme) {
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
                      tag,
                      maxLines: 1,
                      style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.w500),
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {},
                        iconSize: 45.sp,
                        color: colorScheme.primary,
                        icon: const FaIcon(
                          Icons.edit_outlined,
                        )),
                    IconButton(
                        onPressed: () {},
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
}

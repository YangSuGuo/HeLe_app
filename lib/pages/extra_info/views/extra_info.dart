import 'dart:developer';

import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/entry_title.dart';
import 'package:hele_app/common/Widget/network_img.dart';
import 'package:hele_app/model/character_list/character_involvement.dart';
import 'package:hele_app/pages/extra_info/controllers/extra_info_controllers.dart';
import 'package:hele_app/pages/wiki/widget/info_subitem.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ExtraInfo extends StatefulWidget {
  const ExtraInfo({super.key});

  @override
  State<ExtraInfo> createState() => _ExtraInfoState();
}

class _ExtraInfoState extends State<ExtraInfo> {
  final ExtraInfoControllers _infoControllers = Get.put(ExtraInfoControllers());
  Future? _info;
  Future? _involvement;

  @override
  void initState() {
    super.initState();
    _info = _infoControllers.querySubjectInfo(_infoControllers.id, _infoControllers.type);
    _involvement = _infoControllers.querySubjectInvolvement(_infoControllers.id, _infoControllers.type);
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
          _infoControllers.header,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: FutureBuilder(
          future: _info,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              log(_infoControllers.involvement.length.toString());
              return CustomScrollView(
                slivers: [
                  // 图片
                  if (_infoControllers.wikiDetail.images?.large != null)
                    SliverToBoxAdapter(
                        child: Padding(
                            padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                            child: NetworkImg(
                              src: _infoControllers.wikiDetail.images?.large,
                              width: 1.sw,
                              height: 1.2.sw,
                              fit: BoxFit.fitHeight,
                            ))),
                  // 角色信息
                  SliverList.builder(
                    itemCount: _infoControllers.infoList.length,
                    itemBuilder: (context, index) {
                      var item = _infoControllers.infoList[index];
                      Widget valueWidget;

                      if (item['value'] is List) {
                        // 如果值是一个列表，则遍历它以显示多个条目
                        valueWidget = Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: (item['value'] as List).map((e) => Text("${e['k']}:  ${e['v']}")).toList(),
                            ));
                      } else {
                        // 否则，直接显示单个值
                        valueWidget = Text(item['value'].toString());
                      }

                      return ListTile(
                        title: Text(
                          item['key'],
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        visualDensity: const VisualDensity(vertical: 2),
                        subtitle: valueWidget,
                      );
                    },
                  ),
                  // 角色简介
                  SliverPadding(
                      padding: EdgeInsets.fromLTRB(35.w, 0, 35.w, 8.h),
                      sliver: EntryTitle(
                        title: "角色简介",
                        size: 32.sp,
                        fontWeight: FontWeight.w400,
                      )),
                  SliverToBoxAdapter(
                      child: Theme(
                          data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 35.w),
                              child: ExpandText(
                                _infoControllers.wikiDetail.summary,
                                maxLines: 5,
                                style: TextStyle(color: colorScheme.secondary.withOpacity(0.85)),
                              )))),
                  // 角色参与作品
                  SliverPadding(
                      padding: EdgeInsets.fromLTRB(24.w, 0, 35.w, 8.h),
                      sliver: EntryTitle(
                        title: "参与作品",
                        size: 32.sp,
                        fontWeight: FontWeight.w400,
                      )),
                  if (_infoControllers.involvement.isNotEmpty)
                    FutureBuilder(
                        future: _involvement,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            List<CharacterInvolvement> s = snapshot.data;
                            return SliverPadding(
                                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 8.h, bottom: 50.h),
                                sliver: SliverToBoxAdapter(
                                    child: SizedBox(
                                        height: 330.h,
                                        child: ListView.builder(
                                          itemBuilder: (context, index) {
                                            return InfoSubitem(
                                              containerWidth: 200.w,
                                              src: s[index].image,
                                              width: 200.w,
                                              height: 230.h,
                                              fit: BoxFit.cover,
                                              title: s[index].name,
                                              subtitle: s[index].staff,
                                              onTap: () {},
                                            );
                                          },
                                          itemCount: _infoControllers.involvement.length,
                                          scrollDirection: Axis.horizontal,
                                        ))));
                          } else {
                            return SliverToBoxAdapter(child: Container());
                          }
                        }),
                ],
              );
            } else {
              return Center(
                child: LoadingAnimationWidget.stretchedDots(
                  color: Theme.of(context).colorScheme.primary,
                  size: 140.sp,
                ),
              );
            }
          }),
    );
  }
}

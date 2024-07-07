import 'dart:ui';

import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/badge.dart';
import 'package:hele_app/common/utils/network_img.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
import 'package:hele_app/model/subjects/subjects.dart';
import 'package:hele_app/pages/home/widget/custom_tabs.dart';
import 'package:hele_app/pages/wiki/controllers/wiki_controller.dart';
import 'package:hele_app/pages/wiki/widget/introduction.dart';
import 'package:hele_app/pages/wiki/widget/subheading.dart';
import 'package:nil/nil.dart';

class Wiki extends StatefulWidget {
  const Wiki({super.key});

  @override
  State<Wiki> createState() => _WikiState();
}

class _WikiState extends State<Wiki> with TickerProviderStateMixin {
  final WikiController _wikiController = Get.put(WikiController());
  late Future? _futureBuilder;

  @override
  void initState() {
    super.initState();
    _futureBuilder = _wikiController
        .querySubjectDetails(_wikiController.legacySubjectSmall.id!);
  }

  @override
  void dispose() {
    _wikiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        body: Stack(children: [
      // 背景图片
      _buildBackgroundImage(),
      Padding(
          padding: EdgeInsets.fromLTRB(40.w, 10.h, 40.w, 0.h),
          child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              primary: false,
              shrinkWrap: false,
              slivers: [
                _buildAppBar(),
                SliverToBoxAdapter(
                    child: FutureBuilder(
                        future: _futureBuilder,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Subjects s = snapshot.data;

                            return Column(
                              children: [
                                Introduction(data: s),
                                Gap(12.h),
                                // 可展开的文本框
                                ExpandText(
                                  s.summary,
                                  maxLines: 4,
                                  style: TextStyle(
                                      color: colorScheme.secondary
                                          .withOpacity(0.85)),
                                ),
                              ],
                            );
                          } else {
                            return nil;
                          }
                        })),
              ]))
    ]));
  }

  // AppBar
  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      titleSpacing: 0,
      centerTitle: false,
      elevation: 0,
      automaticallyImplyLeading: true,
      forceMaterialTransparency: true,
      actions: [
        IconButton(
          onPressed: () => Get.toNamed('/historySearch'),
          icon: const Icon(Icons.search_outlined),
        ),
        PopupMenuButton<String>(
          onSelected: (String type) {
            // todo 处理菜单项选择的逻辑
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'pause',
              child: Text('1'),
            ),
            const PopupMenuItem<String>(
              value: 'clear',
              child: Text('2'),
            ),
            const PopupMenuItem<String>(
              value: 'del',
              child: Text('3'),
            ),
            const PopupMenuItem<String>(
              value: 'multiple',
              child: Text('4'),
            ),
          ],
        ),
        const SizedBox(width: 6),
      ],
    );
  }

  // 背景图
  Widget _buildBackgroundImage() {
    return Opacity(
      opacity: 0.2,
      child: ClipRect(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // 图片组件
            AspectRatio(
              aspectRatio: 1.5,
              child: NetworkImg(
                src: _wikiController.imgUrl,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),

            // 模糊滤镜
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: SizedBox(height: 0),
            ),

            // 渐变遮罩
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      Theme.of(context).colorScheme.primary.withOpacity(0.5),
                      Theme.of(context).colorScheme.surface,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

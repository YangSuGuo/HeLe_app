import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/utils/network_img.dart';
import 'package:hele_app/pages/wiki/controllers/wiki_controller.dart';

class Wiki extends StatefulWidget {
  const Wiki({super.key});

  @override
  State<Wiki> createState() => _WikiState();
}

class _WikiState extends State<Wiki> with TickerProviderStateMixin {
  final WikiController _wikiController = Get.put(WikiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景图片
          _buildBackgroundImage(),
          Column(
            children: [
              _buildAppBar(),
              Padding(
                padding: EdgeInsets.fromLTRB(40.w, 10.h, 40.w, 0.h),
                child: Row(
                  children: [
                    NetworkImg(
                      src: _wikiController.imgUrl,
                      width: 200.w,
                      height: 230.h,
                    ),
                    Gap(25.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_wikiController.title,
                              style: TextStyle(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.8),
                              )),
                          // Text(_wikiController.subjects.value.id.toString())
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // AppBar
  Widget _buildAppBar() {
    return AppBar(
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
              child: Text('暂停观看记录'),
            ),
            const PopupMenuItem<String>(
              value: 'clear',
              child: Text('清空观看记录'),
            ),
            const PopupMenuItem<String>(
              value: 'del',
              child: Text('删除已看记录'),
            ),
            const PopupMenuItem<String>(
              value: 'multiple',
              child: Text('多选删除'),
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

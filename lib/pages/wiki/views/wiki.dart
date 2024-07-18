import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/entry_title.dart';
import 'package:hele_app/common/Widget/network_img.dart';
import 'package:hele_app/model/character_list/character_list.dart';
import 'package:hele_app/model/derivation/related_works_query.dart';
import 'package:hele_app/model/person_career/person_career.dart';
import 'package:hele_app/model/subjects/subjects.dart';
import 'package:hele_app/pages/home/widget/custom_tabs.dart';
import 'package:hele_app/pages/wiki/controllers/wiki_controller.dart';
import 'package:hele_app/pages/wiki/widget/info_subitem.dart';
import 'package:hele_app/pages/wiki/widget/introduction.dart';
import 'package:hele_app/pages/wiki/widget/more_information.dart';
import 'package:hele_app/pages/wiki/widget/ratingGraph.dart';
import 'package:hele_app/themes/app_style/colors/app_theme_color_scheme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Wiki extends StatefulWidget {
  const Wiki({super.key});

  @override
  State<Wiki> createState() => _WikiState();
}

// BUG 该页面在生产模式下会出现空指针解引用（null pointer dereference）
class _WikiState extends State<Wiki> with TickerProviderStateMixin {
  // final WikiController _wikiController = Get.put(WikiController());
  final WikiController _wikiController = Get.find<WikiController>();
  int subjectId = 0; // 条目id
  late Future _future;

  // late Future _futureBuilder; // 条目基础信息
  // late Future _characters; // 角色列表
  // late Future _person; // 演职信息
  // late Future _derivation; // 衍生条目

  @override
  void initState() {
    super.initState();

    subjectId = _wikiController.subjectId;

    List<Future<dynamic>> futureList = [
      _wikiController.querySubjectDetails(subjectId),
      _wikiController.querySubjectCharacterList(subjectId),
      _wikiController.querySubjectPersons(subjectId),
      _wikiController.querySubjectDerivation(subjectId)
    ];

    try {
      _future = Future.wait(futureList);
    } catch (error) {
      print('Error: $error');
    }

    // _futureBuilder = _wikiController.querySubjectDetails(subjectId);
    // _characters = _wikiController.querySubjectCharacterList(subjectId);
    // _person = _wikiController.querySubjectPersons(subjectId);
    // _derivation = _wikiController.querySubjectDerivation(subjectId);
  }

  @override
  void dispose() {
    // _wikiController.dispose();
    super.dispose();
  }

  // todo 评论吐槽（无接口） HTML解析转实体
  // todo 剧中相关地点，景点展示
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        body: Stack(children: [
      // 背景图片
      _buildBackgroundImage(),
      _buildAppBar(),
      Padding(
          padding: EdgeInsets.fromLTRB(40.w, 162.h, 40.w, 0.h),
          child: FutureBuilder(
              future: _future,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Subjects s = snapshot.data[0]; // 条目信息
                  List<CharacterList> characters = snapshot.data[1]; // 角色列表
                  List<PersonCareer> persons = snapshot.data[2]; // 演员信息
                  List<RelatedWorksQuery> derivation = snapshot.data[3]; // 衍生条目

                  return CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      slivers: [
                        /* _buildAppBar(),*/
                        // 封面介绍
                        SliverToBoxAdapter(
                            child: Introduction(
                          s: s,
                          imgUrl: _wikiController.imgUrl,
                          title: _wikiController.title,
                          production: _wikiController.production.value,
                          tags: _wikiController.tags,
                        )),
                        SliverGap(16.h),
                        // 可展开的文本框
                        if (s.summary != "")
                          SliverToBoxAdapter(
                              child: Theme(
                                  data: ThemeData(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                  ),
                                  child: ExpandText(
                                    s.summary,
                                    maxLines: 4,
                                    style: TextStyle(color: colorScheme.secondary.withOpacity(0.85)),
                                  ))),

                        // 剧集展示  0 < x < 60
                        // todo 点击跳转到剧集详情
                        if ((s.eps != 0 && s.eps < 60) || (s.totalEpisodes != 0 && s.totalEpisodes < 60))
                          EntryTitle(
                            title: "剧集",
                            size: 42.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        if ((s.eps != 0 && s.eps < 60) || (s.totalEpisodes != 0 && s.totalEpisodes < 60))
                          SliverGap(16.h),
                        if ((s.eps != 0 && s.eps < 60) || (s.totalEpisodes != 0 && s.totalEpisodes < 60))
                          contentGrid(s.totalEpisodes != 0 ? s.totalEpisodes : s.eps),
                        if ((s.eps != 0 && s.eps < 60) || (s.totalEpisodes != 0 && s.totalEpisodes < 60))
                          SliverGap(24.h),

                        // 评分信息
                        if (s.rating.total >= 10)
                          SliverToBoxAdapter(
                            child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: '评分',
                                        style: TextStyle(
                                            fontSize: 42.sp,
                                            fontWeight: FontWeight.bold,
                                            color: colorScheme.secondary)),
                                    if (s.rating.score != 0)
                                      TextSpan(
                                          text: " ${s.rating.score}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppThemeColorScheme.top,
                                              fontSize: 40.sp)),
                                  ])),
                                  if (s.rating.rank != 0)
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 28.w),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        gradient: const LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          colors: [
                                            AppThemeColorScheme.top3,
                                            AppThemeColorScheme.top,
                                            AppThemeColorScheme.top2,
                                          ],
                                        ),
                                      ),
                                      child: Text(
                                        "${s.rating.rank} 名",
                                        style: TextStyle(
                                            color: colorScheme.onPrimary, fontSize: 28.sp, fontWeight: FontWeight.bold),
                                      ),
                                    )
                                ]),
                          ),
                        if (s.rating.total >= 10) SliverGap(16.h),
                        if (s.rating.total >= 10)
                          SliverToBoxAdapter(child: SizedBox(height: 250.h, child: RatingGraph(count: s.rating.count))),
                        if (s.rating.total >= 10) SliverGap(8.h),
                        if (s.rating.total >= 10)
                          SliverToBoxAdapter(
                              child: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                AutoSizeText(
                                  "共计 ${s.rating.total} 条评分",
                                  style: TextStyle(
                                    fontSize: 27.sp,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.secondaryContainer.withOpacity(0.85),
                                  ),
                                ),
                                AutoSizeText("当前评价：${_wikiController.dispute}",
                                    style: TextStyle(
                                      fontSize: 26.5.sp,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.secondaryContainer.withOpacity(0.85),
                                    ))
                              ])),

                        SliverGap(24.h),
                        // 角色信息
                        if (characters.isNotEmpty)
                          EntryTitle(
                              title: "角色", fontWeight: FontWeight.bold, size: 42.sp, child: const MoreInformation()),
                        if (characters.isNotEmpty) SliverGap(16.h),
                        if (characters.isNotEmpty)
                          SliverToBoxAdapter(
                              child: SizedBox(
                                  height: 200.h,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return InfoSubitem(
                                        src: characters[index].images?.medium,
                                        radius: 5,
                                        fit: BoxFit.fitHeight,
                                        title: characters[index].name,
                                        subtitle: _wikiController.getSubTitle(
                                            characters[index].relation, characters[index].actors ?? []),
                                        onTap: () {},
                                      );
                                    },
                                    itemCount: characters.length,
                                    scrollDirection: Axis.horizontal,
                                  ))),
                        SliverGap(24.h),

                        // 制作人员
                        if (persons.isNotEmpty)
                          EntryTitle(
                              title: "制作人员", fontWeight: FontWeight.bold, size: 42.sp, child: const MoreInformation()),
                        if (persons.isNotEmpty) SliverGap(16.h),
                        if (persons.isNotEmpty)
                          SliverToBoxAdapter(
                              child: SizedBox(
                                  height: 200.h,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return InfoSubitem(
                                        src: persons[index].images?.medium,
                                        title: persons[index].name,
                                        subtitle: persons[index].relation,
                                        onTap: () {},
                                      );
                                    },
                                    itemCount: persons.length,
                                    scrollDirection: Axis.horizontal,
                                  ))),
                        SliverGap(24.h),

                        // 关联作品
                        if (derivation.isNotEmpty)
                          EntryTitle(
                              title: "相关作品", fontWeight: FontWeight.bold, size: 42.sp, child: const MoreInformation()),
                        if (derivation.isNotEmpty) SliverGap(16.h),
                        if (derivation.isNotEmpty)
                          SliverToBoxAdapter(
                              child: SizedBox(
                                  height: 330.h,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      String? title = derivation[index].nameCn != "" && derivation[index].nameCn != null
                                          ? derivation[index].nameCn
                                          : derivation[index].name;
                                      return InfoSubitem(
                                        containerWidth: 200.w,
                                        src: derivation[index].images?.medium,
                                        width: 200.w,
                                        height: 230.h,
                                        fit: BoxFit.cover,
                                        title: title,
                                        subtitle: derivation[index].relation,
                                        onTap: () {},
                                      );
                                    },
                                    itemCount: derivation.length,
                                    scrollDirection: Axis.horizontal,
                                  )))

                        // 相关景点，地点
                      ]);
                } else if (snapshot.hasError) {
                  // todo 网络重试点击事件
                  return Center(
                      child: InkWell(
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeText("网络异常，请稍后重试！",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 40.sp, color: colorScheme.secondary)),
                              Gap(8.w),
                              AutoSizeText(":(", style: TextStyle(fontSize: 70.sp, color: colorScheme.secondary)),
                            ],
                          )));
                } else {
                  return Center(
                    child: LoadingAnimationWidget.stretchedDots(
                      color: colorScheme.primary,
                      size: 140.sp,
                    ),
                  );
                }
              }))
    ]));
  }

  // 剧集列表
  Widget contentGrid(int eps) {
    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20.h,
          crossAxisSpacing: 5.w,
          crossAxisCount: 6,
          mainAxisExtent: 52.h,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return CustomChip(
              onTap: () {},
              label: (index + 1).toString(),
              selected: false,
              isPadding: false,
              isTranslucent: true,
            );
          },
          childCount: eps,
        ));
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
              child: Text("1"),
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
            child: Stack(alignment: Alignment.bottomCenter, children: [
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
            child: const SizedBox(),
          ),

          // 渐变遮罩
          Positioned.fill(
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.7),
            Theme.of(context).colorScheme.primary.withOpacity(0.5),
            Theme.of(context).colorScheme.surface,
          ]))))
        ])));
  }
}

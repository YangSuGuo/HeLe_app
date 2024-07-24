import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/show_modal_bottom_detail.dart';
import 'package:hele_app/pages/home/controllers/home_controller.dart';
import 'package:hele_app/pages/home/widget/theme_card.dart';
import 'package:hele_app/providers/application/application.dart';
import 'package:hele_app/themes/app_style/colors/app_theme_color_scheme.dart';
import 'package:hele_app/themes/multiple_themes_mode/multiple_themes.dart';
import 'package:provider/provider.dart';

// 搜索框
class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    required this.homeController,
  });

  final HomeController? homeController;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(children: [
      Expanded(
        child: Container(
          height: 80.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Material(
            color: colorScheme.primary.withOpacity(0.1),
            child: InkWell(
              splashColor: colorScheme.primary.withOpacity(0.05),
              onTap: () => {},
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  const Icon(Icons.search_outlined),
                  const SizedBox(width: 10),
                  Obx(
                    () => Expanded(
                      child: Text(
                        homeController!.defaultSearch.value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: colorScheme.outline),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 8),
      SizedBox(
        width: 85.w,
        height: 85.w,
        child: IconButton(
          style: ButtonStyle(
            alignment: Alignment.center,
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            backgroundColor: ButtonStyleButton.allOrNull(Theme.of(context).colorScheme.onInverseSurface),
          ),
          onPressed: () => {
            showModalBottomDetail(
              height: Get.height * 0.4,
              context: context,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: EdgeInsets.only(bottom: 28.h, left: 24.w, right: 24.w),
                children: [
                  // 设置
                  if (false)
                    Column(
                      children: [
                        AutoSizeText(
                          "快捷功能",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42.sp, color: colorScheme.secondary),
                        ),
                        Gap(16.h),
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          direction: Axis.horizontal,
                          children: [
                            ThemeCard(
                              selected: false,
                              width: 150.w,
                              height: 110.h,
                              borderCurvature: 24.5.r,
                              containerCurvature: 20.r,
                              showBorder: false,
                              iconOffset: EdgeInsets.only(right: 12.w, bottom: 10.h),
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                color: colorScheme.primary.withOpacity(0.1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image_outlined, size: 64.sp, color: colorScheme.secondary),
                                    Gap(6.h),
                                    Text("功能入口",
                                        style:
                                            TextStyle(fontSize: 24.sp, color: colorScheme.secondary.withOpacity(0.8))),
                                  ],
                                ),
                              ),
                            ),
                            ThemeCard(
                              selected: false,
                              width: 150.w,
                              height: 110.h,
                              borderCurvature: 24.5.r,
                              containerCurvature: 20.r,
                              showBorder: false,
                              iconOffset: EdgeInsets.only(right: 12.w, bottom: 10.h),
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                color: colorScheme.primary.withOpacity(0.1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image_outlined, size: 64.sp, color: colorScheme.secondary),
                                    Gap(6.h),
                                    Text("功能入口",
                                        style:
                                            TextStyle(fontSize: 24.sp, color: colorScheme.secondary.withOpacity(0.8))),
                                  ],
                                ),
                              ),
                            ),
                            ThemeCard(
                              selected: false,
                              width: 150.w,
                              height: 110.h,
                              borderCurvature: 24.5.r,
                              containerCurvature: 20.r,
                              showBorder: false,
                              iconOffset: EdgeInsets.only(right: 12.w, bottom: 10.h),
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                color: colorScheme.primary.withOpacity(0.1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image_outlined, size: 64.sp, color: colorScheme.secondary),
                                    Gap(6.h),
                                    Text("功能入口",
                                        style:
                                            TextStyle(fontSize: 24.sp, color: colorScheme.secondary.withOpacity(0.8))),
                                  ],
                                ),
                              ),
                            ),
                            ThemeCard(
                              selected: false,
                              width: 150.w,
                              height: 110.h,
                              borderCurvature: 24.5.r,
                              containerCurvature: 20.r,
                              showBorder: false,
                              iconOffset: EdgeInsets.only(right: 12.w, bottom: 10.h),
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                color: colorScheme.primary.withOpacity(0.1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image_outlined, size: 64.sp, color: colorScheme.secondary),
                                    Gap(6.h),
                                    Text("功能入口",
                                        style:
                                            TextStyle(fontSize: 24.sp, color: colorScheme.secondary.withOpacity(0.8))),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(24.h),
                      ],
                    ),

                  /// 主题外观设置
                  AutoSizeText(
                    "主题外观",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42.sp, color: colorScheme.secondary),
                  ),
                  Gap(16.h),
                  Consumer<ApplicationProvider>(
                    builder: (_, applicationProvider, child) {
                      final themeMode = applicationProvider.themeMode;
                      return Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        direction: Axis.horizontal,
                        // spacing: 50.w,
                        children: [
                          ThemeCard(
                            title: "跟随系统",
                            selected: themeMode == ThemeMode.system,
                            width: 210.w,
                            height: 110.h,
                            borderCurvature: 24.5.r,
                            containerCurvature: 20.r,
                            showBorder: true,
                            iconOffset: EdgeInsets.only(right: 12.w, bottom: 10.h),
                            isExplanationText: true,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: colorScheme.scrim,
                                    child: Text(
                                      'Aa',
                                      style: TextStyle(
                                        color: AppThemeColorScheme.lightDefaultScheme().onSecondary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: AppThemeColorScheme.lightDefaultScheme().onPrimary,
                                    child: Text(
                                      'Aa',
                                      style: TextStyle(
                                        color: AppThemeColorScheme.lightDefaultScheme().secondary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () => applicationProvider.themeMode = ThemeMode.system,
                          ),
                          ThemeCard(
                            title: "日间模式",
                            selected: themeMode == ThemeMode.light,
                            width: 210.w,
                            height: 110.h,
                            borderCurvature: 24.5.r,
                            containerCurvature: 20.r,
                            showBorder: true,
                            iconOffset: EdgeInsets.only(right: 12.w, bottom: 10.h),
                            isExplanationText: true,
                            child: Container(
                              alignment: Alignment.center,
                              color: AppThemeColorScheme.lightDefaultScheme().onPrimary,
                              child: Text(
                                'Aa',
                                style: TextStyle(
                                  color: AppThemeColorScheme.lightDefaultScheme().secondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36.sp,
                                ),
                              ),
                            ),
                            onTap: () => applicationProvider.themeMode = ThemeMode.light,
                          ),
                          ThemeCard(
                            title: "夜间模式",
                            selected: themeMode == ThemeMode.dark,
                            width: 210.w,
                            height: 110.h,
                            borderCurvature: 24.5.r,
                            containerCurvature: 20.r,
                            showBorder: true,
                            iconOffset: EdgeInsets.only(right: 12.w, bottom: 10.h),
                            isExplanationText: true,
                            child: Container(
                              alignment: Alignment.center,
                              color: colorScheme.scrim,
                              child: Text(
                                'Aa',
                                style: TextStyle(
                                  color: AppThemeColorScheme.lightDefaultScheme().onSecondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36.sp,
                                ),
                              ),
                            ),
                            onTap: () => applicationProvider.themeMode = ThemeMode.dark,
                          ),
                        ],
                      );
                    },
                  ),
                  Gap(24.h),

                  /// 多主题设置
                  AutoSizeText(
                    "种子颜色",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42.sp, color: colorScheme.secondary),
                  ),
                  Gap(16.h),
                  const MultipleThemesBody(),
                ],
              ),
            )
          },
          icon: Icon(
            Icons.color_lens,
            size: 58.sp,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      )
    ]);
  }
}

/// 多主题设置
class MultipleThemesBody extends StatefulWidget {
  const MultipleThemesBody({super.key});

  @override
  State<MultipleThemesBody> createState() => _MultipleThemesBodyState();
}

class _MultipleThemesBodyState extends State<MultipleThemesBody> {
  @override
  Widget build(BuildContext context) {
    /// 获取多主题Key
    final List appMultipleThemesModeKey = [];
    appMultipleThemesMode.forEach((key, value) => appMultipleThemesModeKey.add(key));

    return Consumer<ApplicationProvider>(
      builder: (_, applicationProvider, child) {
        final multipleThemesMode = applicationProvider.multipleThemesMode;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            direction: Axis.horizontal,
            // spacing: 38.w,
            children: List.generate(
              appMultipleThemesModeKey.length,
              (generator) {
                final String key = appMultipleThemesModeKey[generator];
                final Color primaryColor = appMultipleThemesMode[key]![AppMultipleThemesMode.light]!.primaryColor;
                return ThemeCard(
                  width: 110.w,
                  height: 110.w,
                  borderCurvature: 50,
                  containerCurvature: 50,
                  showBorder: true,
                  iconOffset: EdgeInsets.zero,
                  selected: multipleThemesMode == key,
                  child: Container(
                    alignment: Alignment.center,
                    color: primaryColor,
                  ),
                  onTap: () {
                    applicationProvider.multipleThemesMode = key;
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hele_app/pages/apply_data/model/info.dart';
import 'package:hele_app/pages/apply_data/widget/common_card.dart';

class ApplyData extends StatefulWidget {
  const ApplyData({super.key});

  @override
  State<ApplyData> createState() => _ApplyDataState();
}

class _ApplyDataState extends State<ApplyData> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Gap(50.h),
                AutoSizeText(
                  "云平台同步",
                  style: TextStyle(fontSize: 44.sp, fontWeight: FontWeight.bold, color: colorScheme.secondary),
                ),
                Gap(20.h),
                // todo WebDAV 登录
                // 优先度 : 极低
                CommonCard(
                  onPressed: () {},
                  info: const Info(
                    label: "同步 WebDAV 数据",
                    iconData: Icons.looks,
                  ),
                  child: Container(
                    height: 80.h,
                  ),
                ),
                Gap(25.h),
                AutoSizeText(
                  "备份与恢复",
                  style: TextStyle(fontSize: 44.sp, fontWeight: FontWeight.bold, color: colorScheme.secondary),
                ),
                Gap(25.h),
                CommonCard(
                  onPressed: () {},
                  info: const Info(
                    label: "导出应用数据",
                    iconData: Icons.looks,
                  ),
                  child: Container(
                    height: 50.h,
                  ),
                ),
                Gap(20.h),
                // todo 文件选择器插件
                CommonCard(
                  onPressed: () {},
                  info: const Info(
                    label: "导入应用数据",
                    iconData: Icons.looks,
                  ),
                  child: Container(
                    height: 50.h,
                  ),
                ),
                Gap(20.h),

                // todo Excel插件支持
                CommonCard(
                  onPressed: () {},
                  info: const Info(
                    label: "导出为 Excel 数据",
                    iconData: Icons.looks,
                  ),
                  child: Container(
                    height: 50.h,
                  ),
                ),
              ],
            )));
  }
}

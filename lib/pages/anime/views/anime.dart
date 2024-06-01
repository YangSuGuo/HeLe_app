import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
import 'package:hele_app/pages/anime/widget/filter_bottom.dart';

class Anime extends StatefulWidget {
  const Anime({super.key});

  @override
  State<Anime> createState() => _AnimeState();
}

class _AnimeState extends State<Anime> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(horizontal: 40.w),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          primary: false,
          shrinkWrap: false,
          slivers: [
            SliverToBoxAdapter(
              child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "今日推荐",
                      style: TextStyle(
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      semanticsLabel: S.of(context).tab_anime_calendar,
                    )
                  ]),
            ),
            SliverToBoxAdapter(
              child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      S.of(context).tab_anime_calendar,
                      style: TextStyle(
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      semanticsLabel: S.of(context).tab_anime_calendar,
                    ),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      FilterBottom(
                        "周一",
                        checked: true,
                        width: 80.w,
                        height: 80.h,
                        fontSize: 25.sp,
                        radius: 14.sp,
                        semanticsLabel: '今日追番',
                        onTap: () {},
                      ),
                      FilterBottom(
                        "周二",
                        checked: false,
                        width: 80.w,
                        height: 80.h,
                        fontSize: 25.sp,
                        radius: 14.sp,
                        semanticsLabel: '明日追番',
                        onTap: () {},
                      ),
                    ])
                  ]),
            ),
          ]),
    );
  }
}

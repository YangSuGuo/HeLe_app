import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hele_app/l10n/gen/app_g.dart';
import 'package:hele_app/pages/anime/controllers/anime_controller.dart';

class Anime extends StatefulWidget {
  const Anime({super.key});

  @override
  State<Anime> createState() => _AnimeState();
}

class _AnimeState extends State<Anime> {
  final AnimeController _animeController = Get.put(AnimeController());

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
                      "推荐",
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

                    ])
                  ]),
            ),
          ]),
    );
  }
}

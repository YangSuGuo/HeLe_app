import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hele_app/l10n/gen/app_g.dart';

class LightNovel extends StatefulWidget {
  const LightNovel({super.key});

  @override
  State<LightNovel> createState() => _LightNovelState();
}

class _LightNovelState extends State<LightNovel> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:
        Text(S.of(context).tabs_light_novel, style: TextStyle(fontSize: 50.sp)));
  }
}

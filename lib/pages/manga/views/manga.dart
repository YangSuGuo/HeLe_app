import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hele_app/l10n/gen/app_g.dart';

class Manga extends StatefulWidget {
  const Manga({super.key});

  @override
  State<Manga> createState() => _MangaState();
}

class _MangaState extends State<Manga> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:
        Text(S.of(context).tabs_manga, style: TextStyle(fontSize: 50.sp)));
  }
}

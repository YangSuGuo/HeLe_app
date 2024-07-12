import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hele_app/l10n/gen/app_g.dart';

class RankList extends StatefulWidget {
  const RankList({super.key});

  @override
  State<RankList> createState() => _RankListState();
}

class _RankListState extends State<RankList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text(S.of(context).navigationBar_title_rank_list, style: TextStyle(fontSize: 50.sp))));
  }
}

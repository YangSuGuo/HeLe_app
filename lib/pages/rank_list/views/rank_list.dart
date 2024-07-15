import 'package:flutter/material.dart';
import 'package:hele_app/common/Widget/gradient_background.dart';

class RankList extends StatefulWidget {
  const RankList({super.key});

  @override
  State<RankList> createState() => _RankListState();
}

class _RankListState extends State<RankList> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(
      children: [
        // 渐变背景
        GradientBackground(),

      ],
    ));
  }


}

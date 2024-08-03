import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hele_app/pages/browsing_history/controllers/browsing_history_controllers.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BrowsingHistory extends StatefulWidget {
  const BrowsingHistory({super.key});

  @override
  State<BrowsingHistory> createState() => _BrowsingHistoryState();
}

class _BrowsingHistoryState extends State<BrowsingHistory> {
  final BrowsingHistoryControllers _browsingHistoryControllers = Get.put(BrowsingHistoryControllers());
  Future? _history;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.08),
            width: 1,
          ),
        ),
        titleSpacing: 0,
        centerTitle: false,
        title: Text(
          "编辑分类",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: FutureBuilder(
          future: _history,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              log(snapshot.data.toString());
              return Text("ok");


            /*  return CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  slivers: [

                  ])*/
              ;
            } else {
              return Center(
                child: LoadingAnimationWidget.stretchedDots(
                  color: colorScheme.primary,
                  size: 140.sp,
                ),
              );
            }
          }),
    );
  }
}

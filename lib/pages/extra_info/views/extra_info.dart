import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hele_app/common/Widget/network_img.dart';
import 'package:hele_app/pages/extra_info/controllers/extra_info_controllers.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ExtraInfo extends StatefulWidget {
  const ExtraInfo({super.key});

  @override
  State<ExtraInfo> createState() => _ExtraInfoState();
}

class _ExtraInfoState extends State<ExtraInfo> {
  final ExtraInfoControllers _infoControllers = Get.put(ExtraInfoControllers());
  Future? _info;

  @override
  void initState() {
    super.initState();
    _info = _infoControllers.querySubjectInfo(_infoControllers.id, _infoControllers.type);
  }

  @override
  Widget build(BuildContext context) {
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
          _infoControllers.header,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: FutureBuilder(
          future: _info,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                children: [
                  if (_infoControllers.wikiDetail.images?.large != null)
                    NetworkImg(
                      src: _infoControllers.wikiDetail.images?.large,
                      width: 1.sw,
                      height: 1.2.sw,
                      fit: BoxFit.fitHeight,
                    )
                ],
              );
            } else {
              return Center(
                child: LoadingAnimationWidget.stretchedDots(
                  color: Theme.of(context).colorScheme.primary,
                  size: 140.sp,
                ),
              );
            }
          }),
    );
  }
}

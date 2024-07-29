import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hele_app/l10n/gen/app_g.dart';

class My extends StatefulWidget {
  const My({super.key});

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
  // final AppDatabase db = Get.find<AppDatabase>();
  // final SubjectsUserTags tag = SubjectsUserTags(
  //   tag: "测试",
  //   creationTime: DateTime.now().millisecondsSinceEpoch,
  // );

  @override
  void initState() {
    super.initState();
    // db.subjectsUserTagsDao.insertTag(tag);
    // Future<List<SubjectsUserTags>> tags = db.subjectsUserTagsDao.findAllTags();
    // print(tags.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(S.of(context).navigationBar_title_my, style: TextStyle(fontSize: 50.sp))));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hele_app/common/Widget/doubleCheckConfirmation.dart';
import 'package:hele_app/init.dart';
import 'package:hele_app/l10n/gen/app_g.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return DoubleCheckConfirmation(
        child: Init(
            child: Scaffold(
      body: Center(
          child: Text(
        S.of(context).hello_World,
        style: TextStyle(fontSize: 50.sp),
      )),
    )));
  }
}

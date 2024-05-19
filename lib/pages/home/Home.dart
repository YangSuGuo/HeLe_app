import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hele_app/common/Widget/doubleCheckConfirmation.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return DoubleCheckConfirmation(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "hello_World",
          style: TextStyle(fontSize: 100.w),
        ),
      ),
    ));
  }
}

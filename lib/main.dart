import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // 屏幕适配
        designSize: const Size(750.0, 1334.0),
        minTextAdapt: false,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
              title: 'Flutter',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
                useMaterial3: true,
              ),
              initialRoute: "/",
              defaultTransition: Transition.cupertino,
              transitionDuration: const Duration(milliseconds: 450),
              home: const Center(
                  child: Text('Hello World', style: TextStyle(fontSize: 20))),
              debugShowCheckedModeBanner: false
          );
        });
  }
}
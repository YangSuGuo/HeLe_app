import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hele_app/l10n/gen/app_g.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // 渐变背景
        gradientBackground(),
        Center(
            child: Text(S.of(context).hello_World,
                style: TextStyle(fontSize: 50.sp)))
      ],
    ));
  }

  /// 渐变背景
  Widget gradientBackground() => Align(
        alignment: Alignment.topLeft,
        child: Opacity(
          opacity: 0.6,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.9),
                    Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    Theme.of(context).colorScheme.surface
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, 0.0034, 0.34]),
            ),
          ),
        ),
      );
}

import 'package:flutter/material.dart';

class ApplyData extends StatefulWidget {
  const ApplyData({super.key});

  @override
  State<ApplyData> createState() => _ApplyDataState();
}

class _ApplyDataState extends State<ApplyData> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "应用数据",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}

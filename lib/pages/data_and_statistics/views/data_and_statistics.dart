import 'package:flutter/material.dart';

class DataAndStatistics extends StatefulWidget {
  const DataAndStatistics({super.key});

  @override
  State<DataAndStatistics> createState() => _DataAndStatisticsState();
}

class _DataAndStatisticsState extends State<DataAndStatistics> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "阅读与统计",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DataAndStatistics extends StatefulWidget {
  const DataAndStatistics({super.key});

  @override
  State<DataAndStatistics> createState() => _DataAndStatisticsState();
}

class _DataAndStatisticsState extends State<DataAndStatistics> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          '阅读与统计',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: const Center(
        child: Text(
          "阅读与统计",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

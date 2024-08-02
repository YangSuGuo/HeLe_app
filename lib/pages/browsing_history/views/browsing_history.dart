import 'package:flutter/material.dart';

class BrowsingHistory extends StatefulWidget {
  const BrowsingHistory({super.key});

  @override
  State<BrowsingHistory> createState() => _BrowsingHistoryState();
}

class _BrowsingHistoryState extends State<BrowsingHistory> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "浏览历史",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}

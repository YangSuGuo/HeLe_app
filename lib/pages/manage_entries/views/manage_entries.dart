import 'package:flutter/material.dart';

class ManageEntries extends StatefulWidget {
  const ManageEntries({super.key});

  @override
  State<ManageEntries> createState() => _ManageEntriesState();
}

class _ManageEntriesState extends State<ManageEntries> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "条目管理",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: AutoSizeText(
        "搜索页",
        style: TextStyle(fontSize: 50),
      ),
    ));
  }
}

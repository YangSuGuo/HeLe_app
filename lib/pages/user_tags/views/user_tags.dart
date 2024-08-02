import 'package:flutter/material.dart';

class UserTags extends StatefulWidget {
  const UserTags({super.key});

  @override
  State<UserTags> createState() => _UserTagsState();
}

class _UserTagsState extends State<UserTags> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "用户标签",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}

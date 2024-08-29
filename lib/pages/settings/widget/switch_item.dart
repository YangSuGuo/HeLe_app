import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hele_app/db/preference/preferences_db.dart';
import 'package:shared_preferences/src/shared_preferences_legacy.dart';

class SetSwitchItem extends StatefulWidget {
  final String? title;
  final String? subTitle;
  final String? setKey;
  final bool? defaultVal;
  final Function? callFn;
  final bool? needReboot;

  const SetSwitchItem({
    this.title,
    this.subTitle,
    this.setKey,
    this.defaultVal,
    this.callFn,
    this.needReboot,
    super.key,
  });

  @override
  State<SetSwitchItem> createState() => _SetSwitchItemState();
}

class _SetSwitchItemState extends State<SetSwitchItem> {
  final PreferencesDB db = PreferencesDB.db;
  bool val = false;

  @override
  void initState() {
    super.initState();
    _loadInitialValue();
  }

  Future<void> _loadInitialValue() async {
    final SharedPreferences key = await db.database;
    setState(() {
      val = key.getBool(widget.setKey!) ?? widget.defaultVal!;
    });
    log(val.toString());
  }

  void switchChange(value) async {
    final SharedPreferences key = await db.database;

    val = value ?? !val;
    key.setBool(widget.setKey!, val);
    log(val.toString());

    if (widget.callFn != null) {
      widget.callFn!.call(val);
    }
    if (widget.needReboot != null && widget.needReboot!) {
      SmartDialog.showToast('重启生效');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.titleMedium!;
    TextStyle subTitleStyle =
        Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.outline);
    return ListTile(
      enableFeedback: true,
      onTap: () => switchChange(null),
      title: Text(widget.title!, style: titleStyle),
      subtitle: widget.subTitle != null ? Text(widget.subTitle!, style: subTitleStyle) : null,
      trailing: Transform.scale(
        alignment: Alignment.centerRight, // 缩放Switch的大小后保持右侧对齐, 避免右侧空隙过大
        scale: 0.8,
        child: Switch(
          thumbIcon: WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
            if (states.isNotEmpty && states.first == WidgetState.selected) {
              return Icon(Icons.done, color: Theme.of(context).colorScheme.primary);
            }
            return null; // 所有其他状态将使用默认的 thumbIcon。
          }),
          value: val,
          onChanged: (val) => switchChange(val),
        ),
      ),
    );
  }
}

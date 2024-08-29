import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hele_app/pages/home/widget/theme_card.dart';
import 'package:hele_app/providers/application/application.dart';
import 'package:hele_app/themes/multiple_themes_mode/multiple_themes.dart';
import 'package:provider/provider.dart';

class SelectDialog<T> extends StatefulWidget {
  final T value;
  final String title;
  final List values;
  final bool isRadio;

  const SelectDialog({
    super.key,
    required this.value,
    required this.values,
    required this.title,
    this.isRadio = true,
  });

  @override
  _SelectDialogState<T> createState() => _SelectDialogState<T>();
}

class _SelectDialogState<T> extends State<SelectDialog<T>> {
  late T _tempValue;

  @override
  void initState() {
    super.initState();
    _tempValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.titleMedium!;

    return AlertDialog(
      title: Text(widget.title),
      contentPadding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      content: StatefulBuilder(builder: (context, StateSetter setState) {
        final List<Widget> children = <Widget>[];

        if (widget.isRadio) {
          for (var i in widget.values) {
            children.add(
              RadioListTile(
                value: i.toString(),
                title: Text(i.toString(), style: titleStyle),
                groupValue: _tempValue,
                onChanged: (value) {
                  setState(() {
                    _tempValue = value as T;
                  });
                  Navigator.pop(context, _tempValue);
                },
              ),
            );
          }
        }

        if (widget.isRadio == false) {
          for (var i in widget.values) {
            children.add(Padding(
                padding: EdgeInsets.only(
                  left: 50.w,
                  bottom: 15.h,
                ),
                child: Consumer<ApplicationProvider>(builder: (_, applicationProvider, child) {
                  ApplicationProvider applicationProvider = context.read<ApplicationProvider>();

                  return Theme(
                      data: ThemeData(
                        splashColor: Colors.transparent, // 点击时的水波纹颜色设置为透明
                        highlightColor: Colors.transparent, // 点击时的背景高亮颜色设置为透明
                      ),
                      child: InkWell(
                          onTap: () {
                            _tempValue = i;
                            applicationProvider.multipleThemesMode = i;
                            log(i.toString());
                          },
                          child: Row(
                            children: [
                              ThemeCard(
                                width: 100.w,
                                height: 100.w,
                                borderCurvature: 50,
                                containerCurvature: 50,
                                showBorder: true,
                                iconOffset: EdgeInsets.zero,
                                selected: i == _tempValue,
                                child: Container(
                                  alignment: Alignment.center,
                                  color: appMultipleThemesMode[i]![AppMultipleThemesMode.light]!.primaryColor,
                                )
                              ),
                              Gap(30.w),
                              Text(
                                i,
                                style: Theme.of(context).textTheme.titleMedium!,
                              )
                            ],
                          )));
                })));
          }
        }

        return SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        );
      }),
    );
  }
}

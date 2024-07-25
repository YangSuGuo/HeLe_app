import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:scroll_datetime_picker/scroll_datetime_picker.dart';

class ScrollYearPicker extends StatelessWidget {
  const ScrollYearPicker({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.startOnChange,
    required this.endOnChange,
  });

  final DateTime startTime;
  final DateTime endTime;
  final void Function(DateTime startTime) startOnChange;
  final void Function(DateTime endTime) endOnChange;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: constraints.maxWidth / 2 - 30.w,
                child: ScrollDateTimePicker(
                  itemExtent: 80.sp,
                  infiniteScroll: true,
                  dateOption: DateTimePickerOption(
                    dateFormat: DateFormat('yyyy'),
                    minDate: DateTime(1980),
                    maxDate: DateTime.now(),
                    initialDate: startTime,
                  ),
                  centerWidget: DateTimePickerCenterWidget(
                    builder: (context, constraints, child) => DecoratedBox(
                      decoration: ShapeDecoration(
                        shape: const StadiumBorder(side: BorderSide(width: 0)),
                        color: colorScheme.primary.withOpacity(0.3),
                      ),
                    ),
                  ),
                  style: DateTimePickerStyle(
                    activeStyle: TextStyle(
                      fontSize: 24,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.primary,
                    ),
                    inactiveStyle: TextStyle(
                      fontSize: 20,
                      color: colorScheme.primary.withOpacity(0.7),
                    ),
                    disabledStyle: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                  onChange: startOnChange
                )),
            AutoSizeText(
              "-",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 66.sp,
                  color: colorScheme.secondary),
            ),
            SizedBox(
                width: constraints.maxWidth / 2 - 30.w,
                child: ScrollDateTimePicker(
                  itemExtent: 80.sp,
                  infiniteScroll: true,
                  dateOption: DateTimePickerOption(
                    dateFormat: DateFormat('yyyy'),
                    minDate: DateTime(1980),
                    maxDate: DateTime.now(),
                    initialDate: endTime,
                  ),
                  centerWidget: DateTimePickerCenterWidget(
                    builder: (context, constraints, child) => DecoratedBox(
                      decoration: ShapeDecoration(
                        shape: const StadiumBorder(side: BorderSide(width: 0)),
                        color: colorScheme.primary.withOpacity(0.3),
                      ),
                    ),
                  ),
                  style: DateTimePickerStyle(
                    activeStyle: TextStyle(
                      fontSize: 24,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.primary,
                    ),
                    inactiveStyle: TextStyle(
                      fontSize: 20,
                      color: colorScheme.primary.withOpacity(0.7),
                    ),
                    disabledStyle: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                  onChange: endOnChange
                )),
          ]);
    });
  }
}

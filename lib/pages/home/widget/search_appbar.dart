import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hele_app/pages/home/controllers/home_controller.dart';

// 搜索框
class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  final HomeController? homeController;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(children: [
      Expanded(
        child: Container(
          height: 80.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Material(
            color: colorScheme.onSecondaryContainer.withOpacity(0.05),
            child: InkWell(
              splashColor: colorScheme.primaryContainer.withOpacity(0.3),
              onTap: () => {},
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  Icon(
                    Icons.search_outlined,
                    color: colorScheme.onSecondaryContainer,
                  ),
                  const SizedBox(width: 10),
                  Obx(
                    () => Expanded(
                      child: Text(
                        homeController!.defaultSearch.value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: colorScheme.outline),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 8),
      SizedBox(
        width: 80.sp,
        height: 80.sp,
        child: IconButton(
          style: ButtonStyle(
            backgroundColor: ButtonStyleButton.allOrNull(
                Theme.of(context).colorScheme.onInverseSurface),
          ),
          onPressed: () => {},
          icon: Icon(
            Icons.person_rounded,
            size: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      )
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hele_app/pages/home/controllers/home_controller.dart';

class CustomTabs extends StatefulWidget {
  const CustomTabs({super.key});

  @override
  State<CustomTabs> createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs> {
  final HomeController _homeController = Get.find<HomeController>();

  void onTap(int index) {
    if (_homeController.initialIndex.value == index) {
      _homeController.tabsCtrList[index]().animateToTop();
    }
    _homeController.initialIndex.value = index;
    _homeController.tabController.index = index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(top: 4),
      child: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          scrollDirection: Axis.horizontal,
          itemCount: _homeController.tabs.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 10);
          },
          itemBuilder: (BuildContext context, int index) {
            String label = _homeController.tabs[index]['label'];
            return Obx(
              () => CustomChip(
                onTap: () => onTap(index),
                label: label,
                selected: index == _homeController.initialIndex.value,
              ),
            );
          },
        ),
      ),
    );
  }
}

// todo 标签切换动画
class CustomChip extends StatelessWidget  {
  final Function onTap;
  final String label;
  final bool selected;

  const CustomChip({
    super.key,
    required this.onTap,
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color selectedColor = colorScheme.secondaryContainer;
    final TextStyle chipTextStyle = selected
        ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
        : const TextStyle(fontSize: 13);

    return InputChip(
          side: const BorderSide(
            color: Colors.transparent,
          ),
          shape: selected
              ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
              : RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // backgroundColor: secondaryContainer,
          selectedColor: selectedColor,
          // color: WidgetStateColor.transparent,
          padding: selected
              ? const EdgeInsets.fromLTRB(20, 1, 20, 1)
              : const EdgeInsets.fromLTRB(7, 1, 7, 1),
          label: Text(label),
          labelStyle: chipTextStyle,
          onPressed: () => onTap(),
          selected: selected,
          showCheckmark: false,
          visualDensity: const VisualDensity(horizontal: 0.0, vertical: -2.0),
        );
  }
}

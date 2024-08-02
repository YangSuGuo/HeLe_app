import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hele_app/routes/app_pages.dart';

List listTile = [
  {
    'icon': FontAwesomeIcons.linesLeaning,
    'title': '条目管理',
    'onTap': () {
      Get.toNamed(Routes.MANAGEENTRIES);
    },
  },
  {
    'icon': FontAwesomeIcons.star,
    'title': '我的收藏',
    'onTap': () {
      Get.toNamed(Routes.MYFAVORITES);
    },
  },
  {
    'icon': FontAwesomeIcons.hashtag,
    'title': '收藏标签',
    'onTap': () {
      Get.toNamed(Routes.USERTAGS);
    },
  },
  {
    'icon': FontAwesomeIcons.clockRotateLeft,
    'title': '浏览记录',
    'onTap': () {
      Get.toNamed(Routes.BROWSINGHISTORY);
    },
  }
];

List listTile2 = [
  {
    'icon': FontAwesomeIcons.ellipsis,
    'title': '偏好设置',
    'onTap': () {
      Get.toNamed(Routes.SETTING);
    },
  },
  {
    'icon': FontAwesomeIcons.copy,
    'title': '应用数据',
    'onTap': () {
      Get.toNamed(Routes.APPLYDATA);
    },
  },
  {
    'icon': FontAwesomeIcons.faceSmile,
    'title': '关于APP',
    'onTap': () {},
  }
];

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hele_app/pages/home/views/home.dart';

class MainController extends GetxController {
  List<Widget> pages = <Widget>[const Home()];

  late PageController pageController = PageController(initialPage: selectedIndex);
  int selectedIndex = 0;

}
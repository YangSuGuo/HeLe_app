import 'dart:async';

import 'package:get/get.dart';

class HomeController extends GetxController {
  late bool hideSearchBar;
  late final StreamController<bool> searchBarStream =
      StreamController<bool>.broadcast();
  RxString defaultSearch = '推荐搜索'.obs; // 默认搜索内容

  @override
  void onInit() {
    super.onInit();
    hideSearchBar = true;
  }
}

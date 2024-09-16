import 'package:get/get.dart';
import 'package:hele_app/pages/main/bindings/main_binding.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    MainBinding().dependencies();
  }
}

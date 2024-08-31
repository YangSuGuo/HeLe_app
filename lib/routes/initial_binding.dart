import 'package:get/get.dart';
import 'package:hele_app/pages/main/bindings/main_binding.dart';
import 'package:hele_app/pages/manage_entries/bindings/manage_entries_bindings.dart';
import 'package:hele_app/pages/my_favorites/bindings/my_favorites_bindings.dart';
import 'package:hele_app/pages/search/bindings/search_binding.dart';
import 'package:hele_app/pages/search_result/bindings/search_result_bindings.dart';
import 'package:hele_app/pages/wiki/bindings/wiki_bindings.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    MainBinding().dependencies();
    WikiBindings().dependencies();
    SearchBinding().dependencies();
    SearchResultBindings().dependencies();
    ManageEntriesBindings().dependencies();
    MyFavoritesBindings().dependencies();
  }
}

import 'package:get/get.dart';
import 'package:hele_app/pages/manage_entries/controllers/manage_entries_controllers.dart';

class ManageEntriesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageEntriesControllers>(
      () => ManageEntriesControllers(),
    );
  }
}

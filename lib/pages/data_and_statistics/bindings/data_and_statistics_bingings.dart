import 'package:get/get.dart';
import 'package:hele_app/pages/data_and_statistics/controllers/data_and_statistics_controllers.dart';

class DataAndStatisticsBinging extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataAndStatisticsControllers>(
      () => DataAndStatisticsControllers(),
    );
  }
}

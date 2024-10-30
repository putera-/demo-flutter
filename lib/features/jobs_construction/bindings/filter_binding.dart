import 'package:get/get.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/filter_controller.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterController());
  }
}

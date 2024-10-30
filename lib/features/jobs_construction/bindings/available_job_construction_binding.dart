import 'package:get/get.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/available_job_construction_controller.dart';

class AvailableJobConstructionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AvailableJobsConstructionController());
  }
}

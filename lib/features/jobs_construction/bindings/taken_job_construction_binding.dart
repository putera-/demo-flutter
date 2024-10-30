import 'package:get/get.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/taken_job_construction_controller.dart';

class TakenJobConstructionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TakenJobsConstructionController());
  }
}

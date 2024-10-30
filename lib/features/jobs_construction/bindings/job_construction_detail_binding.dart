import 'package:get/get.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/available_job_construction_controller.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/job_construction_detail_controller.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/sub_task_report_controller.dart';

class JobConstructionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JobConstructionDetailController());
    Get.lazyPut(() => AvailableJobsConstructionController());
    Get.lazyPut(() => SubTaskReportController());
  }
}

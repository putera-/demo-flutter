import 'package:get/get.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/history_job_construction_controller.dart';

class HistoryJobConstructionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryJobConstructionController());
  }
}

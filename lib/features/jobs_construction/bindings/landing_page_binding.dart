import 'package:get/get.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/landing_page_controller.dart';

class JobConstructionLandingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JobConstructionLandingPageController());
  }
}

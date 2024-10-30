import 'package:get/get.dart';
import 'package:pgnpartner_mobile/features/settings/controllers/create_settings_controller.dart';

class CreateSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateSettingsController());
  }
}
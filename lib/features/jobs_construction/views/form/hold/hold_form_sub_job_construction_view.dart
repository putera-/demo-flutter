import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pgnpartner_mobile/config/routes.dart';
import 'package:pgnpartner_mobile/core/widgets/app_bar_general.dart';
import 'package:pgnpartner_mobile/core/widgets/bottom_button_widget.dart';
import 'package:pgnpartner_mobile/core/widgets/date_input.dart';
import 'package:pgnpartner_mobile/core/widgets/text_area_input.dart';
// import 'package:pgnpartner_mobile/core/widgets/text_field_widget.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/sub_job_construction_model.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/job_construction_detail_controller.dart';

class HoldFormSubJobConstructionView extends GetView<JobConstructionDetailController> {
  const HoldFormSubJobConstructionView({super.key});

  @override
  Widget build(BuildContext context) {
    final SubJobConstructionModel subJob = Get.arguments;
    controller.holdDate.text = DateFormat('d MMMM yyyy').format(DateTime.now());
    controller.holdReason.text = "";
    controller.mandor.text = "";

    return Scaffold(
      appBar: const AppBarGeneral(
        title: "Form Tunda",
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFE0E3E8),
                    width: 1.0,
                  ),
                ),
              ),
              child: const Text(
                "Silakan lengkapi form Tunda di bawah ini terlebih dahulu",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextAreaInput(
                    title: 'Alasan Tunda',
                    placeholder: 'Alasan Tunda',
                    required: true,
                    controller: controller.holdReason,
                    onChange: (value) {
                      controller.update();
                    },
                  ),
                  const SizedBox(height: 32),
                  // TODO Disabled this button, autofill and can not be change
                  DateInput(
                    required: true,
                    title: 'Tanggal Hari Ini',
                    placeholder: 'Tanggal',
                    controller: controller.holdDate,
                    suffixIcon: SvgPicture.asset(
                      "assets/icons/ic_calendar.svg",
                    ),
                    minDate: DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                  ),
                  const SizedBox(height: 16),
                  // TODO apakah di hilangkan saja field nama mandor
                  // const TextFieldWidget(
                  //   title: 'Nama Mandor',
                  //   placeholder: 'Masukkan Nama Mandor',
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<JobConstructionDetailController>(
        builder: (controller) {
          return BottomButtonWidget(
            onTap: controller.holdReason.text.isNotEmpty
                ? () {
                    Get.offAndToNamed(Routes.submitHoldSubJobConstruction, arguments: subJob);
                  }
                : null,
            title: "Kirim",
            disabled: controller.holdReason.text.isEmpty,
          );
        },
      ),
    );
  }
}

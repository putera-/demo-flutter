import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/config/routes.dart';
import 'package:pgnpartner_mobile/core/dialogs/general_dialog.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/widgets/app_bar_general.dart';
import 'package:pgnpartner_mobile/core/widgets/button_widget.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/job_construction_model.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/job_construction_detail_controller.dart';
// import 'package:pgnpartner_mobile/features/pipa_instalasi/widgets/activity_table_widget.dart';

class JobDetailView extends GetView<JobConstructionDetailController> {
  const JobDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // final int jobId = Get.arguments;
    final JobConstructionModel job = Get.arguments;
    controller.jobConstrucitonId.value = job.id ?? 0;
    controller.fetchSubJobDetails();

    return Scaffold(
      appBar: const AppBarGeneral(
        title: 'Detail Pekerjaan sdsd',
      ),
      backgroundColor: const Color(0xFFF9FAFB),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFEAECF0),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: ButtonWidget(
                text: 'Revisi Pekerjaan',
                styleType: ButtonStyleType.outline,
                fillColor: Colors.white,
                outlineColor: const Color(0xFF0057B8),
                textColor: const Color(0xFF0057B8),
                padding: const EdgeInsets.symmetric(vertical: 10),
                onPressed: () {
                  Get.toNamed('/job-revision');
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ButtonWidget(
                text: 'Batalkan Pekerjaan',
                styleType: ButtonStyleType.fill,
                fillColor: AppTheme.red500,
                textColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                onPressed: () {
                  GeneralDialog.show(
                    image: SvgPicture.asset('assets/icons/ic_information3.svg'),
                    title: 'Apakah Anda yakin ingin membatalkan pekerjaan ini?',
                    description: 'Setelah Anda mengkonfirmasi, Anda diminta untuk mengisi form pembatalan.',
                    primaryButtonText: 'Ya, Batalkan',
                    primaryButtonColor: AppTheme.red500,
                    onTapPrimary: () {
                      Get.toNamed(Routes.jobsCancel);
                    },
                    secondaryButtonText: 'Kembali',
                    onTapSecondary: () {
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onDoubleTap: () {
          // controller.selectedSteps.value =
          //     controller.stepsCompletedCaseWithAttachment;
          // controller.selectedSteps.refresh();
        },
        child: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0),
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const Text(
                        "Atur Jadwal Aktivitas",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () async {
                          // var result =
                          //     await Get.toNamed(Routes.jobsDetailSettings);
                          // if (result != null) {
                          //   controller.selectedSteps.value = controller.steps;
                          //   controller.selectedSteps.refresh();
                          // }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFC1C7D1), width: 1),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Atur jadwal di sini"),
                              Icon(
                                Icons.chevron_right_sharp,
                                color: Color(0xFF7A828F),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: SvgPicture.asset('assets/icons/ic_information.svg'),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              "Sebelum mengerjakan pekerjaan di bawah ini, Anda diminta untuk mengatur jadwal kunjungan terlebih dahulu",
                              style: TextStyle(
                                fontSize: 12,
                                height: 18 / 12,
                                color: Color(0xFF475467),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                // ActivityTableWidget(
                //   steps: controller.selectedSteps,
                //   onKerjakanPressed: (value) {
                // value can be used for routing parameter (like id)
                // if (value == '/pipa-instalasi/view') {
                //   Get.toNamed(value,
                //       arguments: controller.selectedSteps[0]['form_data']);
                // }
                // if (value == '/pipa-service/view') {
                //   Get.toNamed(value,
                //       arguments: controller.selectedSteps[1]['form_data']);
                // }
                // if (value == '/gas-meter') {
                //   Get.toNamed(value,
                //       arguments: controller.selectedSteps[2]['form_data']);
                // }
                // if (value == '/gas-in') {
                //   Get.toNamed(value,
                //       arguments: controller.selectedSteps[3]['form_data']);
                // }
                //   },
                //   onTundaPressed: (value) {
                //     Get.toNamed(value);
                //   },
                // ),
                const SizedBox(height: 16),
              ],
            );
          }),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/config/routes.dart';
import 'package:pgnpartner_mobile/core/dialogs/general_dialog.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/widgets/app_bar_general.dart';
import 'package:pgnpartner_mobile/core/widgets/bottom_button_widget.dart';
import 'package:pgnpartner_mobile/core/widgets/info_card.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/job_construction_detail_controller.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/sub_job_construction_widget.dart';

class SubJobsCustomerDetailView extends GetView<JobConstructionDetailController> {
  const SubJobsCustomerDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarGeneral(
        title: "Detail Pekerjaan",
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.fetchSubJobDetails,
          child: Obx(
            () {
              return ListView(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(), // Ensures scrolling
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    child: InfoCard(
                      text: !controller.alreadyTakenByAuthUser.value
                          ? 'Anda belum dapat mengerjakan detail aktivitas di bawah ini, karena Anda belum mengambil pekerjaan ini.'
                          : 'Sebelum mengerjakan pekerjaan di bawah ini, Anda diminta untuk mengatur jadwal kunjungan terlebih dahulu di setiap aktivitas.',
                      borderColor: Colors.white.withOpacity(0),
                      backgroundColor: Colors.white.withOpacity(0),
                      icon: const Icon(
                        Icons.info,
                        color: Color(0XFF3AB3FF),
                        size: 18,
                      ),
                    ),
                  ),
                  if (controller.subJobConstructions.isNotEmpty)
                    Column(
                      children: controller.subJobConstructions
                          .map((subJob) => SubJobConstructionWidget(
                                subJob: subJob,
                                attachment: null,
                              ))
                          .toList(),
                    ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => !controller.showCancelButton.value
            ? const SizedBox.shrink()
            : BottomButtonWidget(
                title: "Batalkan Pekerjaan",
                fillColor: const Color(0xFFE6333C),
                onTap: () async {
                  // await controller.cancelSubJobConstruction();
                  // Get.offAndToNamed(Routes.jobConstructionLandingPage);

                  // final availableJobsController = Get.find<JobConstructionLandingPageController>();
                  // availableJobsController.reset();
                  GeneralDialog.show(
                    image: SvgPicture.asset('assets/icons/ic_information3.svg'),
                    title: 'Apakah Anda yakin ingin membatalkan pekerjaan ini?',
                    description: 'Setelah Anda mengkonfirmasi, Anda diminta untuk mengisi form pembatalan.',
                    primaryButtonText: 'Ya, Batalkan',
                    primaryButtonColor: AppTheme.red500,
                    onTapPrimary: () {
                      final subJob = controller.canCancelList.isNotEmpty ? controller.canCancelList.first : null;

                      if (subJob != null) {
                        dynamic arguments = SubJobRouteParameterModel(
                          jobId: subJob.id,
                          job: subJob,
                          jobs: controller.canCancelList,
                          listReportFileGroup: controller.listReportFileGroup,
                          formData: controller.formData,
                        );

// Pass arguments safely to the next page
                        Get.toNamed(Routes.jobsCancel, arguments: arguments);
                      }
                    },
                    secondaryButtonText: 'Kembali',
                    onTapSecondary: () {
                      Get.back();
                    },
                  );
                },
              ),
      ),
    );
  }
}

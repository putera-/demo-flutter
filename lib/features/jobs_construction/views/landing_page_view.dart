import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/config/routes.dart';
import 'package:pgnpartner_mobile/core/widgets/app_bar_general.dart';

import 'package:pgnpartner_mobile/features/jobs_construction/controllers/landing_page_controller.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/landing/job_construction_chart.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/landing/job_construction_history_cards.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/landing/today_sub_jobs_contruction.dart';

class JobConstructionLandingPage extends GetView<JobConstructionLandingPageController> {
  const JobConstructionLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.reset();

    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.home);
        return false;
      },
      child: Scaffold(
        appBar: AppBarGeneral(
          isBlue: true,
          title: '',
          withTabBar: true,
          onTapLeading: () {
            Get.offAllNamed(Routes.home);
          },
        ),
        body: SafeArea(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                if (!controller.isLoading.value) {
                  controller.getActiveSubConstructionJobs();
                }
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: controller.reset,
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          color: AppTheme.primary,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              'Pekerjaan Konstruksi',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // CHART
                          Obx(() => JobConstructionChart(
                              report: controller.subJobConstructionController.subJobConstructionReport.value)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Riwayat Pekerjaan',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.jobConstructionHistory, arguments: 'SEMUA'),
                          child: const Text(
                            'Lihat Semua',
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // HISTORY CARDS
                  Obx(() => JobConstructionHistoryCards(
                      report: controller.subJobConstructionController.subJobConstructionReport.value)),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pekerjaan Aktif',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.takenJobConstruction),
                          child: const Text(
                            'Lihat Semua',
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // SUB PEKERJAAN HARI INI
                  TodaySubJobsContruction(controller: controller),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

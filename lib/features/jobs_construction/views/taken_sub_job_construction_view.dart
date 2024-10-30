import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/config/routes.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/widgets/app_bar_general.dart';
import 'package:pgnpartner_mobile/core/widgets/empty_list_widget.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/taken_job_construction_controller.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/job_shimmer_card.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/search_and_filter.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/sub_job_construction_card.dart';

class TakenSubJobConstructionView extends GetView<TakenJobsConstructionController> {
  const TakenSubJobConstructionView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.reset();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: const AppBarGeneral(
          title: 'Daftar Pekerjaan Anda',
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(height: 8),
                SearchAndFilter(
                  onPressSearch: () => Get.toNamed(Routes.jobsSearch, arguments: controller),
                  onPressFilter: () => Get.toNamed(Routes.jobsFilter),
                  searchController: controller.searchController,
                  isfiltered: controller.isfiltered,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: NotificationListener(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                        controller.getAllTakenSubJobConstruction();
                      }
                      return true;
                    },
                    child: Obx(
                      () {
                        // if (controller.filteredJobs.isEmpty ||
                        //     controller.customerCache.isEmpty) {
                        if (controller.isLoading.value && controller.page.value == 1) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: 3, // Show placeholders while loading
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return const JobShimmerCard(
                                shimmer: true,
                              );
                            },
                          );
                        } else if (controller.takenSubJobs.isEmpty) {
                          final isSearch = controller.isSearching;
                          return EmptyListWidget(
                            image: isSearch ? 'assets/icons/ic_empty_search2.svg' : 'assets/icons/ic_empty_job.svg',
                            title: isSearch ? "Data pencarian tidak ditemukan" : "Tidak ada Daftar Pekerjaan Baru",
                            subtitle: isSearch
                                ? "ID atau nama pelanggan tidak ditemukan pada daftar pekerjaan yang tersedia"
                                : "Saat ini belum ada pekerjaan yang tersedia untuk Anda. Silakan hubungi Mandor Anda",
                          );
                        } else {
                          return RefreshIndicator(
                            onRefresh: controller.reset,
                            child: ListView.builder(
                              itemCount: controller.takenSubJobs.length + 1,
                              itemBuilder: (context, index) {
                                if (index < controller.takenSubJobs.length) {
                                  final subJob = controller.takenSubJobs[index];

                                  return Obx(
                                    () => SubJobConstructionCard(
                                      subJob: subJob,
                                      shimmer: controller.isLoading.value,
                                    ),
                                  );
                                } else if (controller.hasMore.value) {
                                  return const Center(child: CircularProgressIndicator());
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

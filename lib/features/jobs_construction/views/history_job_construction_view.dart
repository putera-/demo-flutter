import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/config/routes.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/widgets/app_bar_general.dart';
import 'package:pgnpartner_mobile/core/widgets/empty_list_widget.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/history_job_construction_controller.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/job_history_badge_list.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/job_shimmer_card.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/search_job.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/sub_job_construction_card.dart';

class HistoryJobConstructionView extends GetView<HistoryJobConstructionController> {
  const HistoryJobConstructionView({super.key});

  @override
  Widget build(BuildContext context) {
    final type = Get.arguments;

    controller.type.value = type;
    controller.reset();

    Map<String, String> appBarTitleMap = {
      'SEMUA': 'Riwayat Pekerjaan Anda',
      'DONE': 'Daftar Pekerjaan Selesai',
      'ON_PROGRESS': 'Daftar Pekerjaan Berjalan',
      'REVISION': 'Daftar Pekerjaan Revisi',
      'CANCELED': 'Daftar Pekerjaan Dibatalkan',
    };

    String appBarTitle = appBarTitleMap[type] ?? 'Daftar Pekerjaan Anda';

    switch (type) {
      case 'SEMUA':
        controller.selectedFilter.value = 0;
        break;
      case 'ON_PROGRESS':
        controller.selectedFilter.value = 1;
        break;
      case 'DONE':
        controller.selectedFilter.value = 2;
        break;
      case 'REVISION':
        controller.selectedFilter.value = 3;
        break;
      case 'CANCELED':
        controller.selectedFilter.value = 4;
        break;
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBarGeneral(
          title: appBarTitle,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(12),
                child: SearchJob(
                  onPressSearch: () => Get.toNamed(Routes.jobsSearch, arguments: controller),
                  searchController: controller.searchController,
                ),
              ),
              const SizedBox(height: 8),
              const JobHistoryBadgeList(),
              const SizedBox(height: 16),
              Expanded(
                child: NotificationListener(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                      controller.getHistorySubConstructionJobs();
                    }
                    return true;
                  },
                  child: Obx(
                    () {
                      if (controller.isLoading.value && controller.page.value == 1) {
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shrinkWrap: true,
                          itemCount: 3, // Show placeholders while loading
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const JobShimmerCard(
                              shimmer: true,
                            );
                          },
                        );
                      } else if (controller.historyJobs.isEmpty) {
                        final isSearch = controller.isSearching;
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: EmptyListWidget(
                            image: isSearch ? 'assets/icons/ic_empty_search2.svg' : 'assets/icons/ic_empty_job.svg',
                            title: isSearch ? "Data pencarian tidak ditemukan" : "Tidak ada Daftar Pekerjaan",
                            subtitle: isSearch
                                ? "ID atau nama pelanggan tidak ditemukan pada daftar pekerjaan yang tersedia"
                                : "Saat ini belum ada pekerjaan yang tersedia untuk Anda. Silakan hubungi Mandor Anda",
                          ),
                        );
                      } else {
                        return RefreshIndicator(
                          onRefresh: () => controller.reset(),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount: controller.historyJobs.length + 1,
                            itemBuilder: (context, index) {
                              if (index < controller.historyJobs.length) {
                                final subJob = controller.historyJobs[index];

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
    );
  }
}

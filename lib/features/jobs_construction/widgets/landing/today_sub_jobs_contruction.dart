import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/core/widgets/empty_list_widget.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/sub_job_construction_model.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/landing_page_controller.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/job_shimmer_card.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/sub_job_construction_card.dart';

class TodaySubJobsContruction extends StatelessWidget {
  const TodaySubJobsContruction({
    super.key,
    required this.controller,
  });

  final JobConstructionLandingPageController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.page.value == 1) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: 1, // Show placeholders while loading
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: JobShimmerCard(
                shimmer: true,
              ),
            );
          },
        );
      } else if (controller.activeSubJobs.isEmpty) {
        return const Column(
          children: [
            SizedBox(height: 32),
            EmptyListWidget(
              image: 'assets/icons/ic_empty_job.svg',
              title: "Tidak ada pekerjaan",
              subtitle: "Saat ini belum ada pekerjaan yang tersedia untuk Anda. Silakan hubungi Mandor Anda",
            ),
          ],
        );
      } else {
        // Show the list of jobs
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.activeSubJobs.length + 1,
          itemBuilder: (context, index) {
            if (index < controller.activeSubJobs.length) {
              final SubJobConstructionModel subJob = controller.activeSubJobs[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SubJobConstructionCard(
                  subJob: subJob,
                  shimmer: controller.isLoading.value,
                ),
              );
            } else if (controller.hasMore.value && controller.activeSubJobs.isNotEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      }
    });
  }
}

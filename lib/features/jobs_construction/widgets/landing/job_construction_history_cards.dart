import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/config/routes.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/sub_job_construction_report.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/construction_history_card.dart';

class JobConstructionHistoryCards extends StatelessWidget {
  const JobConstructionHistoryCards({
    super.key,
    this.report,
  });

  final SubJobConstructionReport? report;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        children: [
          ConstructionHistoryCard(
            icon: 'assets/icons/ic_check_square_offset.svg',
            iconBackgroundColor: AppTheme.green100,
            // total: controller.jobsReport.value.totaJobsDone ?? 0,
            total: report?.totalSubTaskDone ?? 0,
            title: 'Pekerjaan Selesai',
            onTap: () => Get.toNamed(Routes.jobConstructionHistory, arguments: 'DONE'),
          ),
          const SizedBox(width: 16),
          ConstructionHistoryCard(
            icon: 'assets/icons/ic_hammer.svg',
            iconBackgroundColor: AppTheme.blue100,
            // total: controller.jobsReport.value.totaJobsOnProgress ?? 0,
            total: report?.totalSubTaskOnprogress ?? 0,
            title: 'Pekerjaan Berjalan',
            onTap: () => Get.toNamed(Routes.jobConstructionHistory, arguments: 'ON_PROGRESS'),
          ),
          const SizedBox(width: 16),
          ConstructionHistoryCard(
            icon: 'assets/icons/ic_pencil_simple_line.svg',
            iconBackgroundColor: AppTheme.orange100,
            // total: controller.jobsReport.value.totaJobRevision ?? 0,
            total: report?.totalSubTaskRevision ?? 0,
            title: 'Pekerjaan Dalam Revisi',
            onTap: () => Get.toNamed(Routes.jobConstructionHistory, arguments: 'REVISION'),
          ),
          const SizedBox(width: 16),
          ConstructionHistoryCard(
            icon: 'assets/icons/ic_warning_octagon.svg',
            iconBackgroundColor: AppTheme.red100,
            // total: controller.jobsReport.value.totaJobCanceled ?? 0,
            total: report?.totalSubTaskCanceled ?? 0,
            title: 'Pekerjaan Dibatalkan',
            onTap: () => Get.toNamed(Routes.jobConstructionHistory, arguments: 'CANCELED'),
          ),
        ],
      ),
    );
  }
}

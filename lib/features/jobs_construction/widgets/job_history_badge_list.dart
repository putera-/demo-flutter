import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/history_job_construction_controller.dart';

class JobHistoryBadgeList extends StatelessWidget {
  const JobHistoryBadgeList({super.key});

  @override
  Widget build(BuildContext context) {
    HistoryJobConstructionController controller = Get.find<HistoryJobConstructionController>();

    final List<String> filters = [
      "Semua",
      "Sedang Berjalan",
      "Selesai",
      "Dalam Revisi",
      "Dibatalkan",
    ];

    return SizedBox(
      height: 34,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16 : 4.0,
              right: index == 4 ? 16 : 4.0,
            ),
            child: Obx(() => FilterBadge(
                  label: filters[index],
                  isSelected: index == controller.selectedFilter.value,
                  onTap: () {
                    controller.updateFilter(index);
                  },
                )),
          );
        },
      ),
    );
  }
}

class FilterBadge extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterBadge({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : AppTheme.border300,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

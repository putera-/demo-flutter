import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/app/controllers/sub_job_construction_controller.dart';
import 'package:pgnpartner_mobile/core/snackbar/general_snackbar.dart';
import 'package:pgnpartner_mobile/data/models/auth/auth_user.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/sub_job_construction_model.dart';
import 'package:pgnpartner_mobile/data/models/request_model.dart';
import 'package:pgnpartner_mobile/data/repositories/sub_job_construction_repository.dart';
import 'package:pgnpartner_mobile/services/auth_service.dart';

class JobConstructionLandingPageController extends GetxController {
  final SubJobConstructionRepository _subJobConstructionRepository = SubJobConstructionRepository();

  // Global Controller
  final subJobConstructionController = Get.find<SubJobConstructionController>();

  // AUTH DATA
  final authService = AuthService();

  // Filter
  final RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();
  final Rx<bool> isfiltered = false.obs;

  // Getter to check if a search is being performed
  bool get isSearching => searchQuery.value.isNotEmpty;

  final activeSubJobs = <SubJobConstructionModel>[].obs;
  final isLoading = false.obs;
  final hasMore = true.obs;

  // pagination
  final page = 1.obs;
  final int limit = 10;
  final totalData = 0.obs;

  Future<void> reset() async {
    page.value = 1;
    activeSubJobs.clear();
    hasMore.value = true;
    isLoading.value = false;
    getStatisticReport();
    getActiveSubConstructionJobs();
  }

  getStatisticReport() {
    subJobConstructionController.getStatisticReport();
  }

  Future<void> getActiveSubConstructionJobs() async {
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;
    try {
      AuthUser? authUser = await authService.getUser();
      if (authUser == null) return;

      final request = RequestModel(
        // filterWhere:
        //     "last_field_executor_user_id = ${authUser.id} AND scheduled_start_date >= CURRENT_DATE AND (status = 'ASSIGNED' OR status = 'SCHEDULED' OR status = 'WORKING' OR status = 'PAUSED')",
        filterWhere:
            "last_field_executor_user_id = ${authUser.id} AND (status = 'ASSIGNED' OR status = 'SCHEDULED' OR status = 'WORKING' OR status = 'PAUSED' OR status = 'FIXING' OR status = 'VERIFICATION_FAIL')",
        filterOrderBy: "scheduled_start_date ASC",
        filterKeyValues: {},
        rowPerPage: limit,
        pageIndex: page.value - 1,
        isDeleted: false,
      );

      final dynamic data = await _subJobConstructionRepository.getSubJobConstruction(request);

      final List<dynamic> rawSubJobs = data['rows'];
      final List<SubJobConstructionModel> subJobs = rawSubJobs.map((j) {
        return SubJobConstructionModel.fromJson(j as Map<String, dynamic>);
      }).toList();

      activeSubJobs.addAll(subJobs);

      // calculate pagination
      totalData.value = data['total_rows'];
      hasMore.value = activeSubJobs.length < totalData.value;

      if (hasMore.value) {
        page.value++;
      }
    } catch (e) {
      GeneralSnackbar.show(
        message: "1 Data list Sub Job Construction tidak ditemukan",
        closeIcon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 20,
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
}

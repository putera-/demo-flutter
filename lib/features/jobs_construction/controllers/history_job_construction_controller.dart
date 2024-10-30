import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/core/snackbar/general_snackbar.dart';
import 'package:pgnpartner_mobile/data/models/auth/auth_user.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/sub_job_construction_model.dart';
import 'package:pgnpartner_mobile/data/repositories/sub_job_construction_repository.dart';
import 'package:pgnpartner_mobile/services/auth_service.dart';

class HistoryJobConstructionController extends GetxController {
  final SubJobConstructionRepository _subJobConstructionRepository = SubJobConstructionRepository();

  // AUTH DATA
  final authService = AuthService();

  // Filter
  final RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();
  final Rx<bool> isFiltered = false.obs;

  // Getter to check if a search is being performed
  bool get isSearching => searchQuery.value.isNotEmpty;

  final historyJobs = <SubJobConstructionModel>[].obs;
  final isLoading = false.obs;
  final hasMore = true.obs;

  final Rx<int> selectedFilter = 0.obs;

  void updateFilter(int filterIndex) {
    selectedFilter.value = filterIndex;

    switch (filterIndex) {
      case 0:
        type.value = 'SEMUA';
        break;
      case 1:
        type.value = 'ON_PROGRESS';
        break;
      case 2:
        type.value = 'DONE';
        break;
      case 3:
        type.value = 'REVISION';
        break;
      case 4:
        type.value = 'CANCELED';
        break;
    }

    reset();
  }

  // pagination
  final page = 1.obs;
  final int limit = 10;
  // final totalData = 0.obs;

  final RxString type = ''.obs;

  Future<void> reset() async {
    page.value = 1;
    historyJobs.clear();
    hasMore.value = true;
    isLoading.value = false;
    getHistorySubConstructionJobs();
  }

  Future<void> getHistorySubConstructionJobs() async {
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;

    try {
      AuthUser? authUser = await authService.getUser();
      if (authUser == null) return;

      Map<String, dynamic> request = {
        "search": searchQuery.value,
        "row_per_page": limit,
        "page_index": page.value - 1,
        "location_code": "",
        "types": [1, 2, 3, 4]
      };

      List<SubJobConstructionModel> data;
      if (type.value == 'SEMUA') {
        data = await _subJobConstructionRepository.getSearchSubJobConstruction(request);
      } else {
        data = await _subJobConstructionRepository.getGroupSubJobConstruction(type.value);
      }

      // final List<dynamic> rawSubJobs = data['rows'];
      // final List<SubJobConstructionModel> subJobs = rawSubJobs.map((j) {
      //   return SubJobConstructionModel.fromJson(j as Map<String, dynamic>);
      // }).toList();

      historyJobs.addAll(data);

      // calculate pagination
      // totalData.value = data['total_rows'];
      hasMore.value = data.length == limit;

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

  @override
  void onClose() {
    hasMore.value = true;
    page.value = 1;
    historyJobs.clear();
    super.onClose();
  }

  void search() {
    reset();
  }
}

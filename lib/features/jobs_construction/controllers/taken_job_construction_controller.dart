import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/core/snackbar/general_snackbar.dart';
import 'package:pgnpartner_mobile/data/models/auth/auth_user.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/sub_job_construction_model.dart';
import 'package:pgnpartner_mobile/data/models/request_model.dart';
import 'package:pgnpartner_mobile/data/repositories/sub_job_construction_repository.dart';
import 'package:pgnpartner_mobile/services/auth_service.dart';

class TakenJobsConstructionController extends GetxController {
  final SubJobConstructionRepository _subJobConstructionRepository = SubJobConstructionRepository();

  // AUTH DATA
  final authService = AuthService();

  // Filter
  final RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();
  final Rx<bool> isfiltered = false.obs;

  // Getter to check if a search is being performed
  bool get isSearching => searchQuery.value.isNotEmpty;

  final takenSubJobs = <SubJobConstructionModel>[].obs;
  final isLoading = false.obs;
  final hasMore = true.obs;

  // pagination
  final page = 1.obs;
  final int limit = 10;
  final totalData = 0.obs;

  Future<void> reset() async {
    page.value = 1;
    takenSubJobs.clear();
    hasMore.value = true;
    isLoading.value = false;
    getAllTakenSubJobConstruction();
  }

  /*
    - /sub_task/list
    - semua sub task, apapun status-nya berdasarkan user yang login
    - dapat di filter by customer_fullname & customer_number (LOWERCASE)
    - filter by area (kota, kecamatan, keluharahn, kabupaten)
    - multiple filter by type (pipa instalasi, pipa service, pasang gas meter, gas in)
  */
  Future<void> getAllTakenSubJobConstruction() async {
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;
    try {
      AuthUser? authUser = await authService.getUser();
      if (authUser == null) return;

      String filterWhere =
          "last_field_executor_user_id = ${authUser.id} AND (status != 'CANCELED_BY_FIELD_EXECUTOR' OR status != 'CANCELED_BY_CUSTOMER')";

      if (searchController.text != "") {
        // filterWhere +=
        //     " AND (LOWER(customer_fullname) LIKE '%${searchController.text}%' OR LOWER(customer_number) LIKE '%${searchController.text}%')";
        filterWhere +=
            " AND (LOWER(customer_fullname) LIKE '%${searchController.text.toLowerCase()}%' OR LOWER(customer_number) LIKE '%${searchController.text.toLowerCase()}%')";
      }

      final request = RequestModel(
        filterWhere: filterWhere,
        filterOrderBy: "",
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

      takenSubJobs.addAll(subJobs);

      // calculate pagination
      totalData.value = data['total_rows'];
      hasMore.value = takenSubJobs.length < totalData.value;
      if (hasMore.value) {
        page.value++;
      }
    } catch (e) {
      GeneralSnackbar.show(
        message: "Data list pekerjaan tidak ditemukan",
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

  void search() {
    reset();
  }
}

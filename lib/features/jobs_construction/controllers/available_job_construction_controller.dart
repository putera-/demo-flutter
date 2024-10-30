import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/core/snackbar/general_snackbar.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/job_construction_model.dart';
import 'package:pgnpartner_mobile/data/repositories/job_construction_repository.dart';

class AvailableJobsConstructionController extends GetxController {
  final JobConstructionRepository _jobsConstructionRepository = JobConstructionRepository();

  // Filter
  final RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();
  final Rx<bool> isfiltered = false.obs;

  // Getter to check if a search is being performed
  bool get isSearching => searchQuery.value.isNotEmpty;

  final availableJobs = <JobConstructionModel>[].obs;
  final isLoading = false.obs;
  final hasMore = true.obs;

  // pagination
  final page = 1.obs;
  final int limit = 10;
  final totalData = 0.obs;

  Future<void> reset() async {
    page.value = 1;
    availableJobs.clear();
    hasMore.value = true;
    isLoading.value = false;

    getAvailableJob();
  }

  /*
    - /task/list
    - semua task, yang masih ada available subtak (waiting assignment)
    - dapat di filter by customer_fullname & customer_number (LOWERCASE)
    - filter by area (kota, kecamatan, keluharahn, kabupaten)
    - sort:
      - terbaru
      - terdekat dr tanggal hari ini
      - terdekat dr lokasi (lokasi user by device. lat-long)
  */
  Future<void> getAvailableJob() async {
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;
    try {
      // String filterWhere = "task_type_id = 1";

      // if (searchController.text != "") {
      //   filterWhere +=
      //       " AND (LOWER(customer_fullname) LIKE '%${searchController.text.toLowerCase()}%' OR LOWER(customer_number) LIKE '%${searchController.text.toLowerCase()}%')";
      // }

      // final request = RequestModel(
      //   filterWhere: filterWhere,
      //   filterOrderBy: "",
      //   filterKeyValues: {},
      //   rowPerPage: limit,
      //   pageIndex: page.value - 1,
      //   isDeleted: false,
      // );

      Map<String, dynamic> request = {
        "task_type_id": "1",
        "search": searchController.text.toLowerCase(),
        "row_per_page": limit, // Mandatory
        "page_index": page.value - 1, // Mandatory
        "location_code": "",
        "sort": "LATEST", //LATEST, CLOSEST_TO_TODAY, CLOSEST_TO_THE_LOCATION
        "types": [1, 2, 3, 4]
      };

      // final dynamic data = await _jobsConstructionRepository.getJobConstruction(request);
      final dynamic data = await _jobsConstructionRepository.getAvailableJobConstruction(request);

      final List<dynamic> newJobs = data['rows'];

      final List<JobConstructionModel> jobModels = newJobs.map((j) {
        return JobConstructionModel.fromJson(j as Map<String, dynamic>);
      }).toList();

      availableJobs.addAll(jobModels);

      // calculate pagination
      totalData.value = data['total_rows'];
      hasMore.value = availableJobs.length < totalData.value;
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

  // Future<JobConstructionModel> getJobConstruction(int id) async {
  //   try {
  //     return availableJobs.firstWhere((job) => job.id == id);
  //   } catch (e) {
  //     return await _jobsConstructionRepository.getJobConstructionById(id);
  //   }
  // }

  void search() {
    reset();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pgnpartner_mobile/config/routes.dart';
import 'package:pgnpartner_mobile/core/dialogs/general_dialog.dart';
import 'package:pgnpartner_mobile/core/snackbar/general_snackbar.dart';
import 'package:pgnpartner_mobile/core/utils/helpers/database_helper.dart';
import 'package:pgnpartner_mobile/data/models/auth/auth_user.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/job_construction_model.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/sub_job_construction_model.dart';
import 'package:pgnpartner_mobile/data/models/request_model.dart';
import 'package:pgnpartner_mobile/data/repositories/job_construction_repository.dart';
import 'package:pgnpartner_mobile/data/repositories/sub_job_construction_repository.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/available_job_construction_controller.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/sub_job_construction_widget.dart';
import 'package:pgnpartner_mobile/services/auth_service.dart';

class TemporaryFormData {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String npwp;
  final String address;
  final String group;
  final String buildingType;
  final String areaPgn;

  TemporaryFormData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.npwp,
    required this.address,
    required this.group,
    required this.buildingType,
    required this.areaPgn,
  });
}

class JobConstructionDetailController extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  // TODO SHIMER

  final JobConstructionRepository _jobsConstructionRepository = JobConstructionRepository();
  final SubJobConstructionRepository _subJobConstructionRepository = SubJobConstructionRepository();

  // AUTH DATA
  final authService = AuthService();
  final RxInt authLoginId = 0.obs;
  final authUser = Rx<AuthUser?>(null);

  Future<void> getAuthUser() async {
    authUser.value = await authService.getUser();
    authLoginId.value = authUser.value!.id;
  }

  // JOB CONSTRUCTION DATA
  AvailableJobsConstructionController jobController = Get.find<AvailableJobsConstructionController>();
  final RxInt jobConstrucitonId = 0.obs;
  final jobConstruciton = Rx<JobConstructionModel?>(null);

  final subJobConstructions = <SubJobConstructionModel>[].obs;

  // get nearest available sub job construction can be take
  final nearestAvailableSubJobConstruction = Rx<SubJobConstructionModel?>(null);

  // status for auth user already taken some of the sub job construction
  final alreadyTakenByAuthUser = false.obs;
  final showCancelButton = false.obs;
  final canCancelList = <SubJobConstructionModel>[].obs;

  // taken Sub Job Construction
  final takenSubJobConstruction = Rx<SubJobConstructionModel?>(null);

  final isLoading = false.obs;

  // data to pass to subtask
  TemporaryFormData? formData;

  RxList<ReportFileGroupModel> listReportFileGroup = RxList.empty(growable: true);

  Future<void> getSubJobReportFileGroupList() async {
    final request = RequestModel(
      filterWhere: "",
      filterOrderBy: "",
      filterKeyValues: {},
      rowPerPage: 0,
      pageIndex: 0,
      isDeleted: false,
    );
    try {
      listReportFileGroup.value = await _subJobConstructionRepository.getSubJobReportFileGroupList(request);
    } catch (e) {
      GeneralSnackbar.show(
        message: "File Group List tidak ditemukan",
        closeIcon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 20,
        ),
      );
    }
  }

  // get job construction detail
  Future<void> getJobConstruction() async {
    if (jobConstrucitonId.value == 0) {
      // prevent get data if job construction id is not set
      return;
    }

    try {
      // add minimal await 1 second to show shimmer
      final results = await Future.wait([
        _jobsConstructionRepository.getJobConstructionById(jobConstrucitonId.value),
        Future.delayed(const Duration(seconds: 1)),
      ]);

      jobConstruciton.value = results[0];

      formData = TemporaryFormData(
        id: jobConstruciton.value?.customer?.id.toString() ?? "",
        name: jobConstruciton.value?.customer?.fullname ?? "",
        email: jobConstruciton.value?.customer?.email ?? "",
        phone: jobConstruciton.value?.customer?.phonenumber ?? "",
        npwp: jobConstruciton.value?.customer?.npwp ?? "",
        address: jobConstruciton.value?.customer?.address ?? "",
        group: jobConstruciton.value?.customer?.jenisAnggaran ?? "",
        buildingType: jobConstruciton.value?.customer?.jenisBangunan ?? "",
        areaPgn: jobConstruciton.value?.customer?.salesAreaName ?? "",
      );
    } catch (e) {
      GeneralSnackbar.show(
        message: "Pekerjaan tidak ditemukan",
        closeIcon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 20,
        ),
      );
    }
  }

  Future<void> fetchSubJobDetails() async {
    if (jobConstrucitonId.value == 0 || isLoading.value) {
      // prevent get data if job construction id is not set
      return;
    }

    isLoading.value = true;

    try {
      final request = RequestModel(
        filterWhere: "task_id = ${jobConstrucitonId.value}",
        filterOrderBy: "",
        filterKeyValues: {},
        rowPerPage: 10,
        pageIndex: 0,
        isDeleted: false,
      );

      final dynamic data = await _subJobConstructionRepository.getSubJobConstruction(request);

      final List<dynamic> rows = data['rows'];
      final List<SubJobConstructionModel> subJobs = rows.map((j) {
        return SubJobConstructionModel.fromJson(j as Map<String, dynamic>);
      }).toList();

      final List<String> order = [
        'Pipa Instalasi (SK)',
        'Pipa Service (SR)',
        'Pasang Meter Gas',
        'Gas In',
      ];

      // SORT
      subJobs.sort((a, b) => order.indexOf(a.subTaskTypeName).compareTo(order.indexOf(b.subTaskTypeName)));

      // GET NEAREST AVAILABLE SUB JOB CONSTRUCTION
      nearestAvailableSubJobConstruction.value =
          subJobs.firstWhereOrNull((subJob) => subJob.status == SubJobConstructionStatus.WAITING_ASSIGNMENT);

      // CHECK IS AUTH USER ALREADY TAKEN SOME OF THE SUB JOB CONSTRUCTION
      // FIXME Temporary Fix
      // alreadyTakenByAuthUser.value = subJobs
      //     .any((subJob) => subJob.lastFieldExecutorUserId == authLoginId.value);
      alreadyTakenByAuthUser.value = subJobs.any((subJob) =>
          subJob.lastFieldExecutorUserId == authLoginId.value &&
          subJob.status != SubJobConstructionStatus.CANCELED_BY_CUSTOMER &&
          subJob.status != SubJobConstructionStatus.CANCELED_BY_FIELD_EXECUTOR);

      showCancelButton.value = subJobs.any((subJob) =>
          subJob.lastFieldExecutorUserId == authLoginId.value &&
          (subJob.status == SubJobConstructionStatus.ASSIGNED ||
              subJob.status == SubJobConstructionStatus.SCHEDULED ||
              subJob.status == SubJobConstructionStatus.WORKING ||
              subJob.status == SubJobConstructionStatus.PAUSED));

      canCancelList.addAll(subJobs.where((subJob) =>
          subJob.lastFieldExecutorUserId == authLoginId.value &&
          (subJob.status == SubJobConstructionStatus.ASSIGNED ||
              subJob.status == SubJobConstructionStatus.SCHEDULED ||
              subJob.status == SubJobConstructionStatus.WORKING ||
              subJob.status == SubJobConstructionStatus.PAUSED)));

      takenSubJobConstruction.value = subJobs.firstWhereOrNull(
        (subJob) =>
            subJob.lastFieldExecutorUserId == authLoginId.value &&
            (subJob.status == SubJobConstructionStatus.ASSIGNED ||
                subJob.status == SubJobConstructionStatus.SCHEDULED ||
                subJob.status == SubJobConstructionStatus.WORKING ||
                subJob.status == SubJobConstructionStatus.PAUSED),
      );

      subJobConstructions.clear();
      subJobConstructions.addAll(subJobs);
    } catch (e) {
      GeneralSnackbar.show(
        message: "Sub-Pekerjaan tidak ditemukan",
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

  final isPicking = false.obs;
  Future<bool> pickSubJobConstruction(SubJobConstructionModel subJob) async {
    if (isPicking.value) return true;

    try {
      isPicking.value = true;

      bool success = await _subJobConstructionRepository.pickSubJobConstruction(subJob.id);
      await fetchSubJobDetails();
      isPicking.value = false;
      Get.back();
      GeneralSnackbar.show(
        message: "Anda berhasil mengambil Aktivitas ${subJob.subTaskTypeName}",
        backgroundColor: const Color(0xFF29A11E),
        closeIcon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 20,
        ),
      );
      return success;
    } catch (e) {
      isPicking.value = false;
      GeneralSnackbar.show(
        message: "Gagal mengambil pekerjaan",
        closeIcon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 20,
        ),
      );
      return false;
    }
  }

  // SET SCHEDULE
  final TextEditingController scheduleStartDate = TextEditingController();
  final TextEditingController scheduleEndDate = TextEditingController();

  final TextEditingController formatScheduleStartDate = TextEditingController();
  final TextEditingController formatScheduleEndDate = TextEditingController();

  Future<void> setSubJobConstructionSchedule(int subJobId) async {
    // prevent if schedule not set
    if (scheduleStartDate.text == "" || scheduleEndDate.text == "") return;

    DateTime startParsedDate = DateFormat('d MMMM yyyy').parse(scheduleStartDate.text);
    DateTime endParsedDate = DateFormat('d MMMM yyyy').parse(scheduleEndDate.text);

    // Memformat tanggal ke "yyyy-MM-dd"
    String formattedDate = DateFormat('yyyy-MM-dd').format(startParsedDate);
    String formattedEndDate = DateFormat('yyyy-MM-dd').format(endParsedDate);

    try {
      await _subJobConstructionRepository.setSchedule(subJobId, formattedDate, formattedEndDate);
      await fetchSubJobDetails();
    } catch (e) {
      GeneralSnackbar.show(
        message: "Gagal mengambil pekerjaan",
        closeIcon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 20,
        ),
      );
    }
  }

  Future startWorking(SubJobConstructionModel subJob) async {
    try {
      String subTaskTypeName = subJob.subTaskTypeName;
      int subJobId = subJob.id;
      SubJobConstructionStatus status = subJob.status;

      // Jika status belum working,
      // set schedule dulu
      if (status == SubJobConstructionStatus.ASSIGNED &&
          (subJob.scheduledStartDate == null && subJob.scheduledEndDate == null)) {
        // set schedule dulu
        await _subJobConstructionRepository.setSchedule(
          subJobId,
          DateFormat('yyyy-MM-dd').format(DateTime.now()),
          DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 7))),
        );

        // manually set to scheduled
        status = SubJobConstructionStatus.SCHEDULED;
      }

      // Jika status belum working,
      if (status != SubJobConstructionStatus.WORKING) {
        // set working start
        await _subJobConstructionRepository.workingStart(subJobId, DateTime.now());
      }

      // refresh list, need await
      await fetchSubJobDetails();

      // get newest data of subJob
      subJob = subJobConstructions.firstWhere((s) => s.id == subJobId);

      dynamic arguments = SubJobRouteParameterModel(
        jobId: subJobId,
        job: subJob,
        listReportFileGroup: listReportFileGroup,
        formData: formData,
      );

      if (subTaskTypeName == 'Pipa Instalasi (SK)') {
        Get.toNamed(
          Routes.pipaInstalasiView,
          arguments: arguments,
        );
      } else if (subTaskTypeName == 'Pipa Service (SR)') {
        Get.toNamed(
          Routes.pipaServiceView,
          arguments: arguments,
        );
      } else if (subTaskTypeName == 'Pasang Meter Gas') {
        Get.toNamed(
          Routes.gasMeter,
          arguments: arguments,
        );
      } else if (subTaskTypeName == 'Gas In') {
        Get.toNamed(
          Routes.gasIn,
          arguments: arguments,
        );
      }
    } catch (e) {
      GeneralSnackbar.show(message: "Gagal Memulai Pekerjaan");
    }
  }

  // HOLD Sub TASK
  // hold date is not use, force use today date on submit hold sub job construction
  final TextEditingController holdDate = TextEditingController();
  final TextEditingController holdReason = TextEditingController();
  final TextEditingController mandor = TextEditingController();

  final processingHold = true.obs;
  final processingHoldSuccess = true.obs;

  final RxInt responseTunda = 0.obs;

  Future<void> submitHoldSubJobConstruction(int subJobId, SubJobConstructionStatus status) async {
    // prevent if schedule not set
    try {
      processingHold.value = true;
      processingHoldSuccess.value = true;
      simulateSubmit();

      // Jika status belum working,
      // set schedule dulu
      if (status == SubJobConstructionStatus.ASSIGNED) {
        // set schedule dulu
        await _subJobConstructionRepository.setSchedule(
          subJobId,
          DateFormat('yyyy-MM-dd').format(DateTime.now()),
          DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 7))),
        );

        // manually set to scheduled
        status = SubJobConstructionStatus.SCHEDULED;
      }
      if (status == SubJobConstructionStatus.SCHEDULED) {
        await _subJobConstructionRepository.workingStart(
          subJobId,
          DateTime.now(),
        );
        // set working
        status = SubJobConstructionStatus.WORKING;
      }

      if (status != SubJobConstructionStatus.WORKING) {
        // set working end
        throw Exception('Status tidak valid');
      }

      DateTime parsedHoldDate = DateTime.now();

      final results = await Future.wait([
        Future.delayed(const Duration(seconds: 3)), // show loading min 3 seconds
        _subJobConstructionRepository.holdSubJobConstruction(subJobId, parsedHoldDate, holdReason.text, mandor.text),
      ]);

      responseTunda.value = results[1] as int;

      // update data subjob
      await fetchSubJobDetails();
    } catch (e) {
      processingHoldSuccess.value = false;
      GeneralSnackbar.show(
        message: e.toString(),
        closeIcon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 20,
        ),
      );
    } finally {
      processingHold.value = false;
    }
  }

  final submitProgress = 0.obs;

  Future<void> simulateSubmit() async {
    const int totalSteps = 100;
    const Duration stepDuration = Duration(milliseconds: 10);

    for (int i = 1; i <= totalSteps; i++) {
      if (!processingHold.value) break;
      await Future.delayed(stepDuration);
      submitProgress.value = i;
    }
    submitProgress.value = 0;

    if (processingHold.value) simulateSubmit();
  }

  // cancelRESUME SUB JOB CONSTRUCTION
  final processingResume = false.obs;

  Future<void> resumeSubJobConstruction(int subJobId) async {
    if (processingResume.value) return;

    processingResume.value = true;

    try {
      await _subJobConstructionRepository.resumeSubJobConstruction(subJobId);
      // update data subjob
      await fetchSubJobDetails();
    } catch (e) {
      GeneralSnackbar.show(
        message: e.toString(),
        closeIcon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 20,
        ),
      );
    } finally {
      processingResume.value = false;
    }
  }

  // CANCEL SUB JOB CONSTRUCTION
  final processingCancel = false.obs;

  final RxInt responseCancel = 0.obs;

  Future<void> cancelSubJobConstruction(String reason, String type) async {
    if (processingCancel.value) return;

    processingCancel.value = true;
    GeneralDialog.showLoadingDialog();

    try {
      // Find the sub-job where the executor is logged in and status is relevant
      SubJobConstructionModel find = subJobConstructions.firstWhere((subJob) =>
          subJob.lastFieldExecutorUserId == authLoginId.value &&
          (subJob.status == SubJobConstructionStatus.ASSIGNED ||
              subJob.status == SubJobConstructionStatus.SCHEDULED ||
              subJob.status == SubJobConstructionStatus.WORKING ||
              subJob.status == SubJobConstructionStatus.PAUSED));

      int subJobId = find.id;

      if (find.status == SubJobConstructionStatus.ASSIGNED) {
        // Perform the cancellation and wait for at least 3 seconds
        final results = await Future.wait([
          Future.delayed(const Duration(seconds: 3)), // Show loading for a minimum of 3 seconds
          (type == 'Petugas')
              ? _subJobConstructionRepository.cancelByExecutorSubJobConstruction(subJobId, reason)
              : _subJobConstructionRepository.cancelByCustomerSubJobConstruction(subJobId, reason),
        ]);

        responseCancel.value = results[1] as int;

        (type == 'Petugas')
            ? find.status = SubJobConstructionStatus.CANCELED_BY_FIELD_EXECUTOR
            : find.status = SubJobConstructionStatus.CANCELED_BY_CUSTOMER;
      }

      // Delete Local DB
      await _dbHelper.deleteFormDataByIdSubTask(subJobId);

      // Update data subjob after cancellation
      await fetchSubJobDetails();
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      GeneralSnackbar.show(
        message: e.toString(),
        closeIcon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 20,
        ),
      );
    } finally {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      processingCancel.value = false;

      // Redirect after successful cancellation
      if (type == 'Petugas') {
        Get.offAndToNamed('/cancel-job/success', arguments: 'Petugas');
      } else {
        Get.offAndToNamed('/cancel-job/success', arguments: 'Pelanggan');
      }
    }
  }
}

import 'dart:developer';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/core/snackbar/general_snackbar.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/sub_job_construction_detail_model.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/sub_job_report_detail_model.dart';
import 'package:pgnpartner_mobile/data/models/request_model.dart';
import 'package:pgnpartner_mobile/data/providers/gas_appliance_provider.dart';
import 'package:pgnpartner_mobile/data/providers/meter_appliance_provider.dart';
import 'package:pgnpartner_mobile/data/providers/tapping_saddle_provider.dart';
import 'package:pgnpartner_mobile/data/repositories/gas_applicance_repository.dart';
import 'package:pgnpartner_mobile/data/repositories/meter_appliance_repository.dart';
import 'package:pgnpartner_mobile/data/repositories/sub_job_construction_repository.dart';
import 'package:pgnpartner_mobile/data/repositories/tapping_saddle_repository.dart';

class SubTaskReportController extends GetxController {
  // Repository
  final SubJobConstructionRepository _subJobConstructionRepository = SubJobConstructionRepository();
  final GasApplicanceRepository _gasApplianceRepository = GasApplicanceRepository();
  final TappingSaddleRepository _tappingSaddleRepository = TappingSaddleRepository();
  final MeterApplianceRepository _meterApplianceRepository = MeterApplianceRepository();

  // Observables
  final isLoading = false.obs;
  final subJobConstruction = Rxn<SubJobConstructionDetailModel>();
  final subJobConstructionReport = Rxn<SubJobReportDetailModel>();
  RxList<GasApplianceModel> equipmentList = RxList.empty(growable: true);
  RxList<TappingSaddleModel> saddleList = RxList.empty(growable: true);
  final gSize = Rxn<GSizeApplianceModel>();
  final meter = Rxn<MeterApplianceModel>();

  @override
  void onInit() {
    super.onInit();
    final int? id = Get.arguments?['id'];
    if (id != null) {
      fetchSubJobConstructionById(id);
      fetchSubJobReport(id);
    } else {
      log('No ID provided in arguments');
    }
  }

  // Function to fetch the sub-job construction by ID
  Future<void> fetchSubJobConstructionById(int id) async {
    isLoading.value = true;
    try {
      final result = await _subJobConstructionRepository.getSubJobConstructionById(id);
      subJobConstruction.value = result;
      log('Subjob construction fetched successfully ${subJobConstruction.value?.subTaskTypeFullName}');
    } catch (e) {
      log('Error fetching subjob construction: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSubJobReport(int id) async {
    isLoading.value = true;
    final request = RequestModel(
      filterWhere: "sub_task_id = $id",
      filterOrderBy: "id desc",
      filterKeyValues: {},
      rowPerPage: 10,
      pageIndex: 0,
      isDeleted: false,
    );

    try {
      final result = await _subJobConstructionRepository.subJobReport(request);
      subJobConstructionReport.value = result;

      await loadEquipmentList();
      await loadSaddleList();
      await loadGSize();
      await loadMeter();
    } catch (e) {
      log('Error fetching subjob report: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadEquipmentList() async {
    if (subJobConstructionReport.value?.report?.gasAppliance == null) {
      return;
    }

    final List<GasAppliance> gasApplianceData = subJobConstructionReport.value?.report?.gasAppliance ?? [];

    final List<int> gasApplianceIds = gasApplianceData.map((item) => item.gasApplianceId).whereType<int>().toList();

    final String filterWhere = "id in (${gasApplianceIds.join(',')})";

    final request = RequestModel(
      filterWhere: filterWhere,
      filterOrderBy: "",
      filterKeyValues: {},
      rowPerPage: 0,
      pageIndex: 0,
      isDeleted: false,
    );

    try {
      final result = await _gasApplianceRepository.getGasApplianceList(request);
      equipmentList.value = result;
    } catch (e) {
      GeneralSnackbar.show(message: "Gagal Mendapatkan List Gas Appliance");
    }
  }

  Future<void> loadSaddleList() async {
    if (subJobConstructionReport.value?.report?.tappingSaddleId == null) {
      return;
    }

    final String filterWhere = "id in (${subJobConstructionReport.value?.report?.tappingSaddleId ?? ''})";

    final request = RequestModel(
      filterWhere: filterWhere,
      filterOrderBy: "",
      filterKeyValues: {},
      rowPerPage: 0,
      pageIndex: 0,
      isDeleted: false,
    );

    try {
      final result = await _tappingSaddleRepository.getTappingSaddleList(request);
      saddleList.value = result;
    } catch (e) {
      GeneralSnackbar.show(message: "Gagal Mendapatkan List Tapping Saddle");
    }
  }

  Future<void> loadGSize() async {
    if (subJobConstructionReport.value?.report?.gSizeId == null) {
      return;
    }

    final int id = subJobConstructionReport.value?.report?.gSizeId ?? 0;

    try {
      final result = await _meterApplianceRepository.getGSize(id);
      gSize.value = result;
    } catch (e) {
      GeneralSnackbar.show(message: "Gagal Mendapatkan  GSize");
    }
  }

  Future<void> loadMeter() async {
    if (subJobConstructionReport.value?.report?.meterId == null) {
      return;
    }

    final int id = subJobConstructionReport.value?.report?.meterId ?? 0;

    try {
      final result = await _meterApplianceRepository.getMeterAppliance(id);
      meter.value = result;
    } catch (e) {
      GeneralSnackbar.show(message: "Gagal Mendapatkan  Meter");
    }
  }
}

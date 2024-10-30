import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pgnpartner_mobile/data/models/customer_model.dart';

enum SubJobConstructionStatus {
  BLOCKING_DEPENDENCY,
  WAITING_ASSIGNMENT,
  ASSIGNED,
  SCHEDULED,
  WORKING,
  WAITING_VERIFICATION,
  VERIFYING,
  VERIFICATION_SUCCESS,
  VERIFICATION_FAIL,
  FIXING,
  PAUSED,
  REMOVED,
  CANCELED_BY_FIELD_EXECUTOR,
  CANCELED_BY_CUSTOMER,
}

class SubJobConstructionModel {
  int id;
  String? code;
  int subTaskTypeId;
  String subTaskTypeName;
  String taskTypeName;
  String subTaskTypeFullCode;
  String subTaskTypeFullName;
  DateTime? completeAt;
  String completeCode;
  DateTime? expiredAt;
  int? lastFieldExecutorUserId;
  String? lastFieldExecutorUserFullname;
  DateTime? firstFixingStartAt;
  DateTime? firstVerificationStartAt;
  bool isDeleted;
  DateTime? lastFixingEndAt;
  DateTime? lastVerificationEndAt;
  String? scheduledEndDate;
  String? scheduledStartDate;
  SubJobConstructionStatus status;
  String readAbleStatus;
  Color colorStatus;
  int? taskId;
  DateTime? workingEndAt;
  DateTime? workingStartAt;
  DateTime? lastStartPauseAt;
  DateTime? lastModifiedAt;
  final CustomerModel? customer;

  static final Map<SubJobConstructionStatus, String> statuses = {
    SubJobConstructionStatus.BLOCKING_DEPENDENCY: "Diblokir",
    SubJobConstructionStatus.WAITING_ASSIGNMENT: 'Dapat diambil',
    SubJobConstructionStatus.ASSIGNED: 'Baru',
    SubJobConstructionStatus.SCHEDULED: "Terjadwal",
    SubJobConstructionStatus.WORKING: "Sedang Dikerjakan",
    SubJobConstructionStatus.WAITING_VERIFICATION: "Selesai",
    SubJobConstructionStatus.VERIFYING: "Sedang Diverifikasi",
    SubJobConstructionStatus.VERIFICATION_FAIL: "Verifikasi Gagal",
    SubJobConstructionStatus.VERIFICATION_SUCCESS: "Terverifikasi",
    SubJobConstructionStatus.FIXING: "Sedang Diperbaiki",
    SubJobConstructionStatus.PAUSED: "Ditunda",
    SubJobConstructionStatus.REMOVED: "Dihapus",
    SubJobConstructionStatus.CANCELED_BY_FIELD_EXECUTOR: "Dibatalkan Petugas",
    SubJobConstructionStatus.CANCELED_BY_CUSTOMER: "Dibatalkan Pelanggan",
  };
  static final Map<SubJobConstructionStatus, Color> statuseColors = {
    SubJobConstructionStatus.BLOCKING_DEPENDENCY: const Color(0xFFE6333C),
    SubJobConstructionStatus.WAITING_ASSIGNMENT: const Color(0xFF1D2939),
    SubJobConstructionStatus.ASSIGNED: const Color(0xFFEA9800),
    SubJobConstructionStatus.SCHEDULED: const Color(0xFFEA9800),
    SubJobConstructionStatus.WORKING: const Color(0xFFEA9800),
    SubJobConstructionStatus.WAITING_VERIFICATION: const Color(0xFF29A11E),
    SubJobConstructionStatus.VERIFYING: const Color(0xFF0C5190),
    SubJobConstructionStatus.VERIFICATION_FAIL: const Color(0xFFE6333C),
    SubJobConstructionStatus.VERIFICATION_SUCCESS: const Color(0xFF1174CD),
    SubJobConstructionStatus.FIXING: const Color(0xFFEA9800),
    SubJobConstructionStatus.PAUSED: const Color(0xFF0C5190),
    SubJobConstructionStatus.REMOVED: const Color(0xFFE6333C),
    SubJobConstructionStatus.CANCELED_BY_FIELD_EXECUTOR: const Color(0xFFE6333C),
    SubJobConstructionStatus.CANCELED_BY_CUSTOMER: const Color(0xFFE6333C),
  };

  SubJobConstructionModel({
    required this.id,
    this.code,
    required this.subTaskTypeFullCode,
    required this.subTaskTypeFullName,
    required this.subTaskTypeId,
    required this.subTaskTypeName,
    required this.taskTypeName,
    required this.completeCode,
    required this.status,
    required this.readAbleStatus,
    required this.colorStatus,
    required this.isDeleted,
    this.taskId,
    this.completeAt,
    this.expiredAt,
    this.lastFieldExecutorUserId,
    this.lastFieldExecutorUserFullname,
    this.firstFixingStartAt,
    this.firstVerificationStartAt,
    this.lastFixingEndAt,
    this.lastVerificationEndAt,
    this.scheduledEndDate,
    this.scheduledStartDate,
    this.workingEndAt,
    this.workingStartAt,
    this.lastStartPauseAt,
    this.lastModifiedAt,
    this.customer,
  });

  factory SubJobConstructionModel.fromJson(Map<String, dynamic> json) {
    return SubJobConstructionModel(
      id: json['id'],
      code: json['code'],
      subTaskTypeFullCode: json['sub_task_type_full_code'],
      subTaskTypeFullName: json['sub_task_type_full_name'],
      subTaskTypeId: json['sub_task_type_id'],
      subTaskTypeName: json['sub_task_type_name'],
      taskId: json['task_id'],
      taskTypeName: json['task_type_name'],
      completeAt: json['complete_at'] != null ? DateTime.parse(json['complete_at']) : null,
      completeCode: json['complete_code'],
      expiredAt: json['expired_at'] != null ? DateTime.parse(json['expired_at']) : null,
      lastFieldExecutorUserId: json['last_field_executor_user_id'],
      lastFieldExecutorUserFullname: json['last_field_executor_user_fullname'],
      firstFixingStartAt: json['first_fixing_start_at'] != null ? DateTime.parse(json['first_fixing_start_at']) : null,
      firstVerificationStartAt:
          json['first_verification_start_at'] != null ? DateTime.parse(json['first_verification_start_at']) : null,
      isDeleted: json['is_deleted'],
      lastFixingEndAt: json['last_fixing_end_at'] != null ? DateTime.parse(json['last_fixing_end_at']) : null,
      lastVerificationEndAt:
          json['last_verification_end_at'] != null ? DateTime.parse(json['last_verification_end_at']) : null,
      scheduledEndDate: json['scheduled_end_date'] != null
          ? DateTime.parse(json['scheduled_end_date']).toLocal().toString().split(' ')[0]
          : null,
      scheduledStartDate: json['scheduled_start_date'] != null
          ? DateTime.parse(json['scheduled_start_date']).toLocal().toString().split(' ')[0]
          : null,
      status: SubJobConstructionStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => SubJobConstructionStatus.WAITING_ASSIGNMENT,
      ),
      readAbleStatus: statuses[SubJobConstructionStatus.values.firstWhere(
            (e) => e.toString().split('.').last == json['status'],
            orElse: () => SubJobConstructionStatus.WAITING_ASSIGNMENT,
          )] ??
          json['status'],
      colorStatus: statuseColors[SubJobConstructionStatus.values.firstWhere(
            (e) => e.toString().split('.').last == json['status'],
            orElse: () => SubJobConstructionStatus.WAITING_ASSIGNMENT,
          )] ??
          const Color(0xFFEA9800),
      workingEndAt: json['working_end_at'] != null ? DateTime.parse(json['working_end_at']) : null,
      workingStartAt: json['working_start_at'] != null ? DateTime.parse(json['working_start_at']) : null,
      lastStartPauseAt: json['last_start_pause_at'] != null ? DateTime.parse(json['last_start_pause_at']) : null,
      lastModifiedAt: json['last_modified_at'] != null ? DateTime.parse(json['last_modified_at']) : null,
      customer: json['customer'] != null ? CustomerModel.fromJson(json['customer']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'complete_at': completeAt?.toIso8601String(),
      'complete_code': completeCode,
      'expired_at': expiredAt?.toIso8601String(),
      'last_field_executor_user_id': lastFieldExecutorUserId,
      'last_field_executor_user_fullname': lastFieldExecutorUserFullname,
      'first_fixing_start_at': firstFixingStartAt?.toIso8601String(),
      'first_verification_start_at': firstVerificationStartAt?.toIso8601String(),
      'is_deleted': isDeleted,
      'last_fixing_end_at': lastFixingEndAt?.toIso8601String(),
      'last_verification_end_at': lastVerificationEndAt?.toIso8601String(),
      'scheduled_end_date': scheduledEndDate,
      'scheduled_start_date': scheduledStartDate,
      'status': status.toString().split('.').last,
      'sub_task_type_full_code': subTaskTypeFullCode,
      'sub_task_type_full_name': subTaskTypeFullName,
      'sub_task_type_id': subTaskTypeId,
      'sub_task_type_name': subTaskTypeName,
      'task_id': taskId,
      'task_type_name': taskTypeName,
      'working_end_at': workingEndAt?.toIso8601String(),
      'working_start_at': workingStartAt?.toIso8601String(),
      'last_start_pause_at': lastStartPauseAt?.toIso8601String(),
      'last_modified_at': lastModifiedAt?.toIso8601String(),
      'customer': customer?.toJson() ?? {},
    };
  }
}

abstract class SubTaskReportPictureModel {
  final int subTaskReportId;
  final int subTaskReportFileGroupId;
  final dynamic picture;

  SubTaskReportPictureModel({
    required this.subTaskReportId,
    required this.subTaskReportFileGroupId,
    required this.picture,
  });

  Map<String, dynamic> toJson();
}

class SubTaskReportPictureDataModel extends SubTaskReportPictureModel {
  SubTaskReportPictureDataModel({
    required super.subTaskReportId,
    required super.subTaskReportFileGroupId,
    required String super.picture,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'sub_task_report_id': subTaskReportId,
      'sub_task_report_file_group_id': subTaskReportFileGroupId,
      'image_url': picture,
    };
  }
}

class SubTaskReportSignatureDataModel extends SubTaskReportPictureModel {
  SubTaskReportSignatureDataModel({
    required super.subTaskReportId,
    required super.subTaskReportFileGroupId,
    required Uint8List super.picture,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'sub_task_report_id': subTaskReportId,
      'sub_task_report_file_group_id': subTaskReportFileGroupId,
      'signature': picture,
    };
  }
}

class ReportFileGroupModel {
  int id;
  String nameid;
  int subTaskTypeId;

  ReportFileGroupModel({
    required this.id,
    required this.nameid,
    required this.subTaskTypeId,
  });

  factory ReportFileGroupModel.fromJson(Map<String, dynamic> json) => ReportFileGroupModel(
        id: json["id"],
        nameid: json["nameid"],
        subTaskTypeId: json["sub_task_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameid": nameid,
        "sub_task_type_id": subTaskTypeId,
      };
}

class WorkingStartRequestModel {
  final int subTaskId;
  final String at;

  WorkingStartRequestModel({
    required this.subTaskId,
    required this.at,
  });

  Map<String, dynamic> toJson() {
    return {
      'sub_task_id': subTaskId,
      'at': at,
    };
  }
}

abstract class WorkingFinishRequestModel {
  final int? subTaskId;
  final DateTime? at;
  final dynamic report;

  WorkingFinishRequestModel({
    required this.subTaskId,
    required this.at,
    required this.report,
  });

  Map<String, dynamic> toJson();
}

class WorkingFinishRequestModelSK extends WorkingFinishRequestModel {
  WorkingFinishRequestModelSK({
    required super.subTaskId,
    required super.at,
    required ReportSK? super.report,
  });

  @override
  Map<String, dynamic> toJson() => {
        'sub_task_id': subTaskId,
        'at': at?.toIso8601String(),
        'report': {
          'sk': report?.toJson(),
        },
      };
}

class WorkingFinishRequestModelSR extends WorkingFinishRequestModel {
  WorkingFinishRequestModelSR({
    required super.subTaskId,
    required super.at,
    required ReportSR? super.report,
  });

  @override
  Map<String, dynamic> toJson() => {
        'sub_task_id': subTaskId,
        'at': at?.toIso8601String(),
        'report': {
          'sr': report?.toJson(),
        },
      };
}

class WorkingFinishRequestModelGasMeter extends WorkingFinishRequestModel {
  WorkingFinishRequestModelGasMeter({
    required super.subTaskId,
    required super.at,
    required ReportGasMeter? super.report,
  });

  @override
  Map<String, dynamic> toJson() => {
        'sub_task_id': subTaskId,
        'at': at?.toIso8601String(),
        'report': {
          'meter_installation': report?.toJson(),
        },
      };
}

class WorkingFinishRequestModelGasIn extends WorkingFinishRequestModel {
  WorkingFinishRequestModelGasIn({
    required super.subTaskId,
    required super.at,
    required ReportGasIn? super.report,
  });

  @override
  Map<String, dynamic> toJson() => {
        'sub_task_id': subTaskId,
        'at': at?.toIso8601String(),
        'report': {
          'gas_in': report?.toJson(),
        },
      };
}

abstract class Report {
  Map<String, dynamic> toJson();
}

class ReportSK implements Report {
  String? customerSectorSelected;
  String? customerEmail;
  String? customerPhone;
  String? customerNpwp;
  String? customerAddress;
  double? pipeLength;
  double? calculatedExtraPipeLength;
  String? testStartTime;
  String? testEndTime;
  double? calculatedTestDurationMinute;
  String? finishedDate;
  double? testPressure;
  bool? branchPipeAvailability;
  List<dynamic>? gasAppliance;

  String? pathPneumatikAkhir;
  String? pathIsometrik;
  String? pathValve;
  String? pathPneumatikAwal;
  String? pathBubbleTest;
  String? pathOther;

  ReportSK({
    this.customerSectorSelected,
    this.customerEmail,
    this.customerPhone,
    this.customerNpwp,
    this.customerAddress,
    this.pipeLength,
    this.calculatedExtraPipeLength,
    this.testStartTime,
    this.testEndTime,
    this.calculatedTestDurationMinute,
    this.finishedDate,
    this.testPressure,
    this.branchPipeAvailability,
    this.gasAppliance,
    this.pathPneumatikAkhir,
    this.pathIsometrik,
    this.pathValve,
    this.pathPneumatikAwal,
    this.pathBubbleTest,
    this.pathOther,
  });

  @override
  Map<String, dynamic> toJson() => {
        'pipe_length': pipeLength,
        'calculated_extra_pipe_length': calculatedExtraPipeLength,
        'test_start_time': testStartTime,
        'test_end_time': testEndTime,
        'calculated_test_duration_minute': calculatedTestDurationMinute,
        'test_pressure': testPressure,
        'branch_pipe_availability': branchPipeAvailability,
        'gas_appliance': gasAppliance,
        'finished_date': finishedDate,
      };

  Map<String, dynamic> toJsonLocal() => {
        'customer_sector_selected': customerSectorSelected,
        'customer_email': customerEmail,
        'customer_phone': customerPhone,
        'customer_npwp': customerNpwp,
        'customer_address': customerAddress,
        'pipe_length': pipeLength,
        'calculated_extra_pipe_length': calculatedExtraPipeLength,
        'test_start_time': testStartTime,
        'test_end_time': testEndTime,
        'calculated_test_duration_minute': calculatedTestDurationMinute,
        'test_pressure': testPressure,
        'branch_pipe_availability': branchPipeAvailability,
        'gas_appliance': gasAppliance,
        'finished_date': finishedDate,
        'path_pneumatik_akhir': pathPneumatikAkhir,
        'path_isometrik': pathIsometrik,
        'path_valve': pathValve,
        'path_pneumatik_awal': pathPneumatikAwal,
        'path_bubble_test': pathBubbleTest,
        'path_other': pathOther,
      };
}

class ReportSR implements Report {
  int? tappingSaddleId;
  String? tappingSaddleCustom;
  String? testStartTime;
  String? testEndTime;
  double? calculatedTestDurationMinute;
  double? testPressure;
  bool? branchPipeAvailability;
  String? finishedDate;

  String? pathPneumatikAkhir;
  String? pathIsometrik;
  String? pathTappingSaddle;
  String? pathPneumatikAwal;
  String? pathCrossingJalan;
  String? pathCrossingSaluran;
  String? pathPondasiSambunganRumah;
  String? pathOther;

  ReportSR({
    this.tappingSaddleId,
    this.tappingSaddleCustom,
    this.testStartTime,
    this.testEndTime,
    this.calculatedTestDurationMinute,
    this.testPressure,
    this.branchPipeAvailability,
    this.finishedDate,
    this.pathPneumatikAkhir,
    this.pathIsometrik,
    this.pathTappingSaddle,
    this.pathPneumatikAwal,
    this.pathCrossingJalan,
    this.pathCrossingSaluran,
    this.pathPondasiSambunganRumah,
    this.pathOther,
  });

  @override
  Map<String, dynamic> toJson() => {
        'tapping_saddle_id': tappingSaddleId,
        'tapping_saddle_custom': tappingSaddleCustom,
        'test_start_time': testStartTime,
        'test_end_time': testEndTime,
        'calculated_test_duration_minute': calculatedTestDurationMinute,
        'test_pressure': testPressure,
        'branch_pipe_availability': branchPipeAvailability,
        'finished_date': finishedDate,
      };

  Map<String, dynamic> toJsonLocal() => {
        'tapping_saddle_id': tappingSaddleId,
        'tapping_saddle_custom': tappingSaddleCustom,
        'test_start_time': testStartTime,
        'test_end_time': testEndTime,
        'calculated_test_duration_minute': calculatedTestDurationMinute,
        'test_pressure': testPressure,
        'branch_pipe_availability': branchPipeAvailability,
        'finished_date': finishedDate,
        'path_pneumatik_akhir': pathPneumatikAkhir,
        'path_isometrik': pathIsometrik,
        'path_tapping_saddle': pathTappingSaddle,
        'path_pneumatik_awal': pathPneumatikAwal,
        'path_crossing_jalan': pathCrossingJalan,
        'path_crossing_saluran': pathCrossingSaluran,
        'path_pondasi_sambungan_rumah': pathPondasiSambunganRumah,
        'path_other': pathOther,
      };
}

class ReportGasMeter {
  final int? meterId;
  final String? selectedMeter;
  final String meterBrand;
  final String snMeter;
  final int gSizeId;
  final double qmin;
  final double qmax;
  final double pmax;
  final int startCalibrationMonth;
  final int startCalibrationYear;

  String? pathMeter;
  String? pathMeterAndPole;
  String? pathOther;

  ReportGasMeter({
    this.meterId, // Optional
    this.selectedMeter,
    required this.meterBrand,
    required this.snMeter,
    required this.gSizeId,
    required this.qmin,
    required this.qmax,
    required this.pmax,
    required this.startCalibrationMonth,
    required this.startCalibrationYear,
    this.pathMeter,
    this.pathMeterAndPole,
    this.pathOther,
  });

  Map<String, dynamic> toJson() {
    return {
      'meter_id': meterId,
      'meter_brand': meterBrand,
      'sn_meter': snMeter,
      'g_size_id': gSizeId,
      'qmin': qmin,
      'qmax': qmax,
      'pmax': pmax,
      'start_calibration_month': startCalibrationMonth,
      'start_calibration_year': startCalibrationYear,
    };
  }

  Map<String, dynamic> toJsonLocal() {
    return {
      'meter_id': meterId,
      'selected_meter': selectedMeter,
      'meter_brand': meterBrand,
      'sn_meter': snMeter,
      'g_size_id': gSizeId,
      'qmin': qmin,
      'qmax': qmax,
      'pmax': pmax,
      'start_calibration_month': startCalibrationMonth,
      'start_calibration_year': startCalibrationYear,
      'path_meter': pathMeter,
      'path_meter_and_pole': pathMeterAndPole,
      'path_other': pathOther,
    };
  }
}

class ReportGasIn implements Report {
  int? meterId;
  String? meterBrand;
  String? snMeter;
  int? gSizeId;
  double? pMax;
  String? dateGasIn;
  double? standMeterStartNumber;
  double? pressureStart;
  double? temperatureStart;
  String? regulatorBrand;
  double? regulatorSizeInc;
  double? meterLocationLat;
  double? meterLocationLong;
  List<dynamic>? gasAppliance;

  String? pathValve;
  String? pathStandMeter;
  String? pathOtherTools;
  String? pathHose;
  String? pathHouseFront;
  String? pathSticker;
  String? pathOtherMeter;
  String? pathRegulator;
  String? pathOtherRegulator;

  ReportGasIn({
    this.meterId,
    this.meterBrand,
    this.snMeter,
    this.gSizeId,
    this.pMax,
    this.dateGasIn,
    this.standMeterStartNumber,
    this.pressureStart,
    this.temperatureStart,
    this.regulatorBrand,
    this.regulatorSizeInc,
    this.meterLocationLat,
    this.meterLocationLong,
    this.gasAppliance,
    this.pathValve,
    this.pathStandMeter,
    this.pathOtherTools,
    this.pathHose,
    this.pathHouseFront,
    this.pathRegulator,
    this.pathSticker,
    this.pathOtherMeter,
    this.pathOtherRegulator,
  });

  @override
  Map<String, dynamic> toJson() => {
        'meter_id': meterId,
        'meter_brand': meterBrand,
        'sn_meter': snMeter,
        'g_size_id': gSizeId,
        'pmax': pMax,
        'gas_in_date': dateGasIn,
        'stand_meter_start_number': standMeterStartNumber,
        'pressure_start': pressureStart,
        'temperature_start': temperatureStart,
        'regulator_brand': regulatorBrand,
        'regulator_size_inch': regulatorSizeInc,
        'meter_location_latitude': meterLocationLat,
        'meter_location_longitude': meterLocationLong,
        'gas_appliance': gasAppliance,
      };

  Map<String, dynamic> toJsonLocal() => {
        'meter_id': meterId,
        'meter_brand': meterBrand,
        'sn_meter': snMeter,
        'g_size_id': gSizeId,
        'pmax': pMax,
        'gas_in_date': dateGasIn,
        'stand_meter_start_number': standMeterStartNumber,
        'pressure_start': pressureStart,
        'temperature_start': temperatureStart,
        'regulator_brand': regulatorBrand,
        'regulator_size_inch': regulatorSizeInc,
        'meter_location_latitude': meterLocationLat,
        'meter_location_longitude': meterLocationLong,
        'gas_appliance': gasAppliance,
        'path_valve': pathValve,
        'path_stand_meter': pathStandMeter,
        'path_other_tools': pathOtherTools,
        'path_hose': pathHose,
        'path_house_front': pathHouseFront,
        'path_sticker': pathSticker,
        'path_regulator': pathRegulator,
        'path_other_meter': pathOtherMeter,
        'path_other_regulator': pathOtherRegulator,
      };
}

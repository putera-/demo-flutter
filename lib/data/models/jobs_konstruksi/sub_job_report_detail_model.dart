class SubJobReportDetailModel {
  final String? code;
  final DateTime? createdAt;
  final String? createdByUserId;
  final String? createdByUserNameId;
  final String? customerFullName;
  final int? customerId;
  final String? data1;
  final String? data2;
  final int? id;
  final bool? isDeleted;
  final DateTime? lastModifiedAt;
  final String? lastModifiedByUserId;
  final String? lastModifiedByUserNameId;
  final Report? report;
  final String? subTaskCode;
  final int? subTaskId;
  final String? subTaskStatus;
  final String? subTaskTypeFullCode;
  final String? subTaskTypeFullName;
  final String? subTaskTypeName;
  final String? taskCode;
  final DateTime? taskCreatedAt;
  final String? taskCreatedByUserId;
  final String? taskCreatedByUserNameId;
  final DateTime? taskLastModifiedAt;
  final String? taskLastModifiedByUserId;
  final String? taskLastModifiedByUserNameId;
  final String? taskStatus;
  final int? taskTypeId;
  final DateTime? timestamp;
  final int? userId;

  SubJobReportDetailModel({
    this.code,
    this.createdAt,
    this.createdByUserId,
    this.createdByUserNameId,
    this.customerFullName,
    this.customerId,
    this.data1,
    this.data2,
    this.id,
    this.isDeleted,
    this.lastModifiedAt,
    this.lastModifiedByUserId,
    this.lastModifiedByUserNameId,
    this.report,
    this.subTaskCode,
    this.subTaskId,
    this.subTaskStatus,
    this.subTaskTypeFullCode,
    this.subTaskTypeFullName,
    this.subTaskTypeName,
    this.taskCode,
    this.taskCreatedAt,
    this.taskCreatedByUserId,
    this.taskCreatedByUserNameId,
    this.taskLastModifiedAt,
    this.taskLastModifiedByUserId,
    this.taskLastModifiedByUserNameId,
    this.taskStatus,
    this.taskTypeId,
    this.timestamp,
    this.userId,
  });

  factory SubJobReportDetailModel.fromJson(Map<String, dynamic> json) {
    return SubJobReportDetailModel(
      code: json['code'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      createdByUserId: json['created_by_user_id'],
      createdByUserNameId: json['created_by_user_nameid'],
      customerFullName: json['customer_fullname'],
      customerId: json['customer_id'],
      data1: json['data1'],
      data2: json['data2'],
      id: json['id'],
      isDeleted: json['is_deleted'],
      lastModifiedAt: json['last_modified_at'] != null ? DateTime.parse(json['last_modified_at']) : null,
      lastModifiedByUserId: json['last_modified_by_user_id'],
      lastModifiedByUserNameId: json['last_modified_by_user_nameid'],
      report: json['report'] != null ? Report.fromJson(json['report']) : null,
      subTaskCode: json['sub_task_code'],
      subTaskId: json['sub_task_id'],
      subTaskStatus: json['sub_task_status'],
      subTaskTypeFullCode: json['sub_task_type_full_code'],
      subTaskTypeFullName: json['sub_task_type_full_name'],
      subTaskTypeName: json['sub_task_type_name'],
      taskCode: json['task_code'],
      taskCreatedAt: json['task_created_at'] != null ? DateTime.parse(json['task_created_at']) : null,
      taskCreatedByUserId: json['task_created_by_user_id'],
      taskCreatedByUserNameId: json['task_created_by_user_nameid'],
      taskLastModifiedAt: json['task_last_modified_at'] != null ? DateTime.parse(json['task_last_modified_at']) : null,
      taskLastModifiedByUserId: json['task_last_modified_by_user_id'],
      taskLastModifiedByUserNameId: json['task_last_modified_by_user_nameid'],
      taskStatus: json['task_status'],
      taskTypeId: json['task_type_id'],
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'created_at': createdAt?.toIso8601String(),
      'created_by_user_id': createdByUserId,
      'created_by_user_nameid': createdByUserNameId,
      'customer_fullname': customerFullName,
      'customer_id': customerId,
      'data1': data1,
      'data2': data2,
      'id': id,
      'is_deleted': isDeleted,
      'last_modified_at': lastModifiedAt?.toIso8601String(),
      'last_modified_by_user_id': lastModifiedByUserId,
      'last_modified_by_user_nameid': lastModifiedByUserNameId,
      'report': report?.toJson(),
      'sub_task_code': subTaskCode,
      'sub_task_id': subTaskId,
      'sub_task_status': subTaskStatus,
      'sub_task_type_full_code': subTaskTypeFullCode,
      'sub_task_type_full_name': subTaskTypeFullName,
      'sub_task_type_name': subTaskTypeName,
      'task_code': taskCode,
      'task_created_at': taskCreatedAt?.toIso8601String(),
      'task_created_by_user_id': taskCreatedByUserId,
      'task_created_by_user_nameid': taskCreatedByUserNameId,
      'task_last_modified_at': taskLastModifiedAt?.toIso8601String(),
      'task_last_modified_by_user_id': taskLastModifiedByUserId,
      'task_last_modified_by_user_nameid': taskLastModifiedByUserNameId,
      'task_status': taskStatus,
      'task_type_id': taskTypeId,
      'timestamp': timestamp?.toIso8601String(),
      'user_id': userId,
    };
  }
}

class Report {
  final bool? branchPipeAvailability;
  final int? calculatedExtraPipeLength;
  final int? calculatedTestDurationMinute;
  final DateTime? finishedDate;
  final List<GasAppliance>? gasAppliance;
  final int? pipeLength;
  final String? tappingSaddleCustom;
  final int? tappingSaddleId;
  final String? testEndTime;
  final int? testPressure;
  final String? testStartTime;
  final int? gSizeId;
  final String? meterBrand;
  final int? meterId;
  final int? pmax;
  final int? qmax;
  final int? qmin;
  final String? snMeter;
  final int? startCalibrationMonth;
  final int? startCalibrationYear;
  final DateTime? gasInDate;
  final double? meterLocationLatitude;
  final double? meterLocationLongitude;
  final int? pressureStart;
  final String? regulatorBrand;
  final int? regulatorSizeInch;
  final int? standMeterStartNumber;
  final int? temperatureStart;

  Report({
    this.branchPipeAvailability,
    this.calculatedExtraPipeLength,
    this.calculatedTestDurationMinute,
    this.finishedDate,
    this.gasAppliance,
    this.pipeLength,
    this.tappingSaddleCustom,
    this.tappingSaddleId,
    this.testEndTime,
    this.testPressure,
    this.testStartTime,
    this.gSizeId,
    this.meterBrand,
    this.meterId,
    this.pmax,
    this.qmax,
    this.qmin,
    this.snMeter,
    this.startCalibrationMonth,
    this.startCalibrationYear,
    this.gasInDate,
    this.meterLocationLatitude,
    this.meterLocationLongitude,
    this.pressureStart,
    this.regulatorBrand,
    this.regulatorSizeInch,
    this.standMeterStartNumber,
    this.temperatureStart,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      branchPipeAvailability: json['branch_pipe_availability'],
      calculatedExtraPipeLength: json['calculated_extra_pipe_length'],
      calculatedTestDurationMinute: json['calculated_test_duration_minute'],
      finishedDate: json['finished_date'] != null ? DateTime.parse(json['finished_date']) : null,
      gasAppliance: (json['gas_appliance'] as List?)?.map((item) => GasAppliance.fromJson(item)).toList(),
      pipeLength: json['pipe_length'],
      tappingSaddleCustom: json['tapping_saddle_custom'],
      tappingSaddleId: json['tapping_saddle_id'],
      testEndTime: json['test_end_time'],
      testPressure: json['test_pressure'],
      testStartTime: json['test_start_time'],
      gSizeId: json['g_size_id'],
      meterBrand: json['meter_brand'],
      meterId: json['meter_id'],
      pmax: json['pmax'],
      qmax: json['qmax'],
      qmin: json['qmin'],
      snMeter: json['sn_meter'],
      startCalibrationMonth: json['start_calibration_month'],
      startCalibrationYear: json['start_calibration_year'],
      gasInDate: json['gas_in_date'] != null ? DateTime.parse(json['gas_in_date']) : null,
      meterLocationLatitude: (json['meter_location_latitude'] as num?)?.toDouble(),
      meterLocationLongitude: (json['meter_location_longitude'] as num?)?.toDouble(),
      pressureStart: json['pressure_start'],
      regulatorBrand: json['regulator_brand'],
      regulatorSizeInch: json['regulator_size_inch'],
      standMeterStartNumber: json['stand_meter_start_number'],
      temperatureStart: json['temperature_start'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'branch_pipe_availability': branchPipeAvailability,
      'calculated_extra_pipe_length': calculatedExtraPipeLength,
      'calculated_test_duration_minute': calculatedTestDurationMinute,
      'finished_date': finishedDate?.toIso8601String(),
      'gas_appliance': gasAppliance?.map((item) => item.toJson()).toList(),
      'pipe_length': pipeLength,
      'tapping_saddle_custom': tappingSaddleCustom,
      'tapping_saddle_id': tappingSaddleId,
      'test_end_time': testEndTime,
      'test_pressure': testPressure,
      'test_start_time': testStartTime,
      'g_size_id': gSizeId,
      'meter_brand': meterBrand,
      'meter_id': meterId,
      'pmax': pmax,
      'qmax': qmax,
      'qmin': qmin,
      'sn_meter': snMeter,
      'start_calibration_month': startCalibrationMonth,
      'start_calibration_year': startCalibrationYear,
      'gas_in_date': gasInDate?.toIso8601String(),
      'meter_location_latitude': meterLocationLatitude,
      'meter_location_longitude': meterLocationLongitude,
      'pressure_start': pressureStart,
      'regulator_brand': regulatorBrand,
      'regulator_size_inch': regulatorSizeInch,
      'stand_meter_start_number': standMeterStartNumber,
      'temperature_start': temperatureStart,
    };
  }
}

class GasAppliance {
  final int? gasApplianceId;
  final int? quantity;

  GasAppliance({
    this.gasApplianceId,
    this.quantity,
  });

  factory GasAppliance.fromJson(Map<String, dynamic> json) {
    return GasAppliance(
      gasApplianceId: json['gas_appliance_id'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gas_appliance_id': gasApplianceId,
      'quantity': quantity,
    };
  }
}

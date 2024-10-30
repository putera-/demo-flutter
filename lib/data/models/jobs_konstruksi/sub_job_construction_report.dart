import 'package:faker/faker.dart';

Faker faker = Faker();

class SubJobConstructionReport {
  int totalSubTaskCanceled;
  int totalSubTaskDone;
  int totalSubTaskGasIn;
  int totalSubTaskMeterInstallation;
  int totalSubTaskOnprogress;
  int totalSubTaskRevision;
  int totalSubTaskSk;
  int totalSubTaskSr;

  SubJobConstructionReport({
    required this.totalSubTaskCanceled,
    required this.totalSubTaskDone,
    required this.totalSubTaskGasIn,
    required this.totalSubTaskMeterInstallation,
    required this.totalSubTaskOnprogress,
    required this.totalSubTaskRevision,
    required this.totalSubTaskSk,
    required this.totalSubTaskSr,
  });

  factory SubJobConstructionReport.fromJson(Map<String, dynamic>? json) {
    return SubJobConstructionReport(
      totalSubTaskCanceled: json != null ? json['total_sub_task_canceled'] as int : 0,
      totalSubTaskDone: json != null ? json['total_sub_task_done'] as int : 0,
      totalSubTaskGasIn: json != null ? json['total_sub_task_gas_in'] as int : 0,
      totalSubTaskMeterInstallation: json != null ? json['total_sub_task_meter_installation'] as int : 0,
      totalSubTaskOnprogress: json != null ? json['total_sub_task_onprogress'] as int : 0,
      totalSubTaskRevision: json != null ? json['total_sub_task_revision'] as int : 0,
      totalSubTaskSk: json != null ? json['total_sub_task_sk'] as int : 0,
      totalSubTaskSr: json != null ? json['total_sub_task_sr'] as int : 0,
    );
  }
}

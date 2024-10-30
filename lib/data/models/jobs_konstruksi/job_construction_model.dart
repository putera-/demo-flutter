import 'package:pgnpartner_mobile/data/models/customer_model.dart';

class JobConstructionModel {
  final String? code;
  final String? createdAt;
  final String? taskTypeName;
  final String? createdByUserId;
  final String? createdByUserNameid;
  final int? customerId;
  final String? customerNumber;
  final String? data1;
  final String? data2;
  final int? id;
  final bool? isDeleted;
  final CustomerModel? customer;

  JobConstructionModel({
    this.code,
    this.createdAt,
    this.taskTypeName,
    this.createdByUserId,
    this.createdByUserNameid,
    this.customerId,
    this.customerNumber,
    this.data1,
    this.data2,
    this.id,
    this.isDeleted,
    this.customer,
  });

  factory JobConstructionModel.fromJson(Map<String, dynamic> json) {
    return JobConstructionModel(
      code: json['code'],
      createdAt: json['created_at'],
      taskTypeName: json['task_type_name'],
      createdByUserId: json['created_by_user_id'],
      createdByUserNameid: json['created_by_user_nameid'],
      customerId: json['customer_id'],
      customerNumber: json['customer_number'],
      data1: json['data1'],
      data2: json['data2'],
      id: json['id'],
      isDeleted: json['is_deleted'],
      customer: json['customer'] != null ? CustomerModel.fromJson(json['customer']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'created_at': createdAt,
      'task_type_name': taskTypeName,
      'created_by_user_id': createdByUserId,
      'created_by_user_nameid': createdByUserNameid,
      'customer_id': customerId,
      'customer_number': customerNumber,
      'data1': data1,
      'data2': data2,
      'id': id,
      'is_deleted': isDeleted,
      'customer': customer?.toJson() ?? {},
    };
  }
}

class SubJobConstructionDetailModel {
  String? assignedAt;
  String? code;
  String? completeCode;
  String? completedAt;
  String? createdAt;
  String? createdByUserId;
  String? createdByUserNameId;
  String? customerAddressKabupatenLocationCode;
  String? customerAddressKecamatanLocationCode;
  String? customerAddressKelurahanLocationCode;
  String? customerAddressPostalCode;
  String? customerAddressProvinceLocationCode;
  String? customerAddressRt;
  String? customerAddressRw;
  String? customerAddressStreet;
  String? customerEmail;
  String? customerFullName;
  int? customerId;
  String? customerIdentityNumber;
  String? customerIdentityType;
  bool? customerIsDeleted;
  String? customerJenisAnggaran;
  String? customerJenisBangunan;
  String? customerKategoryPelanggan;
  String? customerKategoryWilayah;
  String? customerKorespondensiMedia;
  double? customerLatitude;
  double? customerLongitude;
  String? customerNpwp;
  String? customerNumber;
  String? customerPhoneNumber;
  String? customerProgramPelanggan;
  String? customerRegisterAt;
  String? customerRegistrationNumber;
  String? customerRsCustomerSectorCode;
  String? customerRsCustomerSectorName;
  String? customerSalesAreaCode;
  String? customerSalesAreaName;
  String? customerSegmentCode;
  String? customerSkemaPembayaran;
  String? customerTypeCode;
  String? expiredAt;
  String? firstFixingStartAt;
  String? firstVerificationStartAt;
  int? fixCount;
  int? id;
  bool? isDeleted;
  bool? isVerificationSuccess;
  bool? isWorkingFinish;
  String? lastCanceledByCustomerAt;
  String? lastCanceledByCustomerSubTaskReportId;
  String? lastCanceledByFieldExecutorAt;
  String? lastCanceledByFieldExecutorSubTaskReportId;
  String? lastEndPauseAt;
  String? lastFieldExecutorUserFullName;
  int? lastFieldExecutorUserId;
  String? lastFieldExecutorUserIdentityNumber;
  String? lastFieldExecutorUserIdentityType;
  String? lastFieldExecutorUserOrganizationUserMembershipNumber;
  String? lastFieldExecutorUserPhoneNumber;
  String? lastFieldSupervisorUserFullName;
  String? lastFieldSupervisorUserId;
  String? lastFixingEndAt;
  String? lastFixingSubTaskReportId;
  String? lastModifiedAt;
  String? lastModifiedByUserId;
  String? lastModifiedByUserNameId;
  int? lastPauseSubTaskReportId;
  String? lastStartPauseAt;
  int? lastSubTaskReportId;
  String? lastVerificationEndAt;
  String? lastVerificationSubTaskReportId;
  int? lastWorkingSubTaskReportId;
  String? scheduledEndDate;
  String? scheduledStartDate;
  String? status;
  String? subTaskTypeFullCode;
  String? subTaskTypeFullName;
  int? subTaskTypeId;
  String? subTaskTypeName;
  int? taskId;
  String? taskTypeName;
  String? workingEndAt;
  String? workingStartAt;

  SubJobConstructionDetailModel({
    this.assignedAt,
    this.code,
    this.completeCode,
    this.completedAt,
    this.createdAt,
    this.createdByUserId,
    this.createdByUserNameId,
    this.customerAddressKabupatenLocationCode,
    this.customerAddressKecamatanLocationCode,
    this.customerAddressKelurahanLocationCode,
    this.customerAddressPostalCode,
    this.customerAddressProvinceLocationCode,
    this.customerAddressRt,
    this.customerAddressRw,
    this.customerAddressStreet,
    this.customerEmail,
    this.customerFullName,
    this.customerId,
    this.customerIdentityNumber,
    this.customerIdentityType,
    this.customerIsDeleted,
    this.customerJenisAnggaran,
    this.customerJenisBangunan,
    this.customerKategoryPelanggan,
    this.customerKategoryWilayah,
    this.customerKorespondensiMedia,
    this.customerLatitude,
    this.customerLongitude,
    this.customerNpwp,
    this.customerNumber,
    this.customerPhoneNumber,
    this.customerProgramPelanggan,
    this.customerRegisterAt,
    this.customerRegistrationNumber,
    this.customerRsCustomerSectorCode,
    this.customerRsCustomerSectorName,
    this.customerSalesAreaCode,
    this.customerSalesAreaName,
    this.customerSegmentCode,
    this.customerSkemaPembayaran,
    this.customerTypeCode,
    this.expiredAt,
    this.firstFixingStartAt,
    this.firstVerificationStartAt,
    this.fixCount,
    this.id,
    this.isDeleted,
    this.isVerificationSuccess,
    this.isWorkingFinish,
    this.lastCanceledByCustomerAt,
    this.lastCanceledByCustomerSubTaskReportId,
    this.lastCanceledByFieldExecutorAt,
    this.lastCanceledByFieldExecutorSubTaskReportId,
    this.lastEndPauseAt,
    this.lastFieldExecutorUserFullName,
    this.lastFieldExecutorUserId,
    this.lastFieldExecutorUserIdentityNumber,
    this.lastFieldExecutorUserIdentityType,
    this.lastFieldExecutorUserOrganizationUserMembershipNumber,
    this.lastFieldExecutorUserPhoneNumber,
    this.lastFieldSupervisorUserFullName,
    this.lastFieldSupervisorUserId,
    this.lastFixingEndAt,
    this.lastFixingSubTaskReportId,
    this.lastModifiedAt,
    this.lastModifiedByUserId,
    this.lastModifiedByUserNameId,
    this.lastPauseSubTaskReportId,
    this.lastStartPauseAt,
    this.lastSubTaskReportId,
    this.lastVerificationEndAt,
    this.lastVerificationSubTaskReportId,
    this.lastWorkingSubTaskReportId,
    this.scheduledEndDate,
    this.scheduledStartDate,
    this.status,
    this.subTaskTypeFullCode,
    this.subTaskTypeFullName,
    this.subTaskTypeId,
    this.subTaskTypeName,
    this.taskId,
    this.taskTypeName,
    this.workingEndAt,
    this.workingStartAt,
  });

  factory SubJobConstructionDetailModel.fromJson(Map<String, dynamic> json) {
    return SubJobConstructionDetailModel(
      assignedAt: json['assigned_at'] as String?,
      code: json['code'] as String?,
      completeCode: json['complete_code'] as String?,
      completedAt: json['completed_at'] as String?,
      createdAt: json['created_at'] as String?,
      createdByUserId: json['created_by_user_id'] as String?,
      createdByUserNameId: json['created_by_user_nameid'] as String?,
      customerAddressKabupatenLocationCode: json['customer_address_kabupaten_location_code'] as String?,
      customerAddressKecamatanLocationCode: json['customer_address_kecamatan_location_code'] as String?,
      customerAddressKelurahanLocationCode: json['customer_address_kelurahan_location_code'] as String?,
      customerAddressPostalCode: json['customer_address_postal_code'] as String?,
      customerAddressProvinceLocationCode: json['customer_address_province_location_code'] as String?,
      customerAddressRt: json['customer_address_rt'] as String?,
      customerAddressRw: json['customer_address_rw'] as String?,
      customerAddressStreet: json['customer_address_street'] as String?,
      customerEmail: json['customer_email'] as String?,
      customerFullName: json['customer_fullname'] as String?,
      customerId: json['customer_id'] as int?,
      customerIdentityNumber: json['customer_identity_number'] as String?,
      customerIdentityType: json['customer_identity_type'] as String?,
      customerIsDeleted: json['customer_is_deleted'] as bool?,
      customerJenisAnggaran: json['customer_jenis_anggaran'] as String?,
      customerJenisBangunan: json['customer_jenis_bangunan'] as String?,
      customerKategoryPelanggan: json['customer_kategory_pelanggan'] as String?,
      customerKategoryWilayah: json['customer_kategory_wilayah'] as String?,
      customerKorespondensiMedia: json['customer_korespondensi_media'] as String?,
      customerLatitude: (json['customer_latitude'] as num?)?.toDouble(),
      customerLongitude: (json['customer_longitude'] as num?)?.toDouble(),
      customerNpwp: json['customer_npwp'] as String?,
      customerNumber: json['customer_number'] as String?,
      customerPhoneNumber: json['customer_phone_number'] as String?,
      customerProgramPelanggan: json['customer_program_pelanggan'] as String?,
      customerRegisterAt: json['customer_register_at'] as String?,
      customerRegistrationNumber: json['customer_registration_number'] as String?,
      customerRsCustomerSectorCode: json['customer_rs_customer_sector_code'] as String?,
      customerRsCustomerSectorName: json['customer_rs_customer_sector_name'] as String?,
      customerSalesAreaCode: json['customer_sales_area_code'] as String?,
      customerSalesAreaName: json['customer_sales_area_name'] as String?,
      customerSegmentCode: json['customer_segment_code'] as String?,
      customerSkemaPembayaran: json['customer_skema_pembayaran'] as String?,
      customerTypeCode: json['customer_type_code'] as String?,
      expiredAt: json['expired_at'] as String?,
      firstFixingStartAt: json['first_fixing_start_at'] as String?,
      firstVerificationStartAt: json['first_verification_start_at'] as String?,
      fixCount: json['fix_count'] as int?,
      id: json['id'] as int?,
      isDeleted: json['is_deleted'] as bool?,
      isVerificationSuccess: json['is_verification_success'] as bool?,
      isWorkingFinish: json['is_working_finish'] as bool?,
      lastCanceledByCustomerAt: json['last_canceled_by_customer_at'] as String?,
      lastCanceledByCustomerSubTaskReportId: json['last_canceled_by_customer_sub_task_report_id'] as String?,
      lastCanceledByFieldExecutorAt: json['last_canceled_by_field_executor_at'] as String?,
      lastCanceledByFieldExecutorSubTaskReportId: json['last_canceled_by_field_executor_sub_task_report_id'] as String?,
      lastEndPauseAt: json['last_end_pause_at'] as String?,
      lastFieldExecutorUserFullName: json['last_field_executor_user_fullname'] as String?,
      lastFieldExecutorUserId: json['last_field_executor_user_id'] as int?,
      lastFieldExecutorUserIdentityNumber: json['last_field_executor_user_identity_number'] as String?,
      lastFieldExecutorUserIdentityType: json['last_field_executor_user_identity_type'] as String?,
      lastFieldExecutorUserOrganizationUserMembershipNumber:
          json['last_field_executor_user_organization_user_membership_number'] as String?,
      lastFieldExecutorUserPhoneNumber: json['last_field_executor_user_phone_number'] as String?,
      lastFieldSupervisorUserFullName: json['last_field_supervisor_user_fullname'] as String?,
      lastFieldSupervisorUserId: json['last_field_supervisor_user_id'] as String?,
      lastFixingEndAt: json['last_fixing_end_at'] as String?,
      lastFixingSubTaskReportId: json['last_fixing_sub_task_report_id'] as String?,
      lastModifiedAt: json['last_modified_at'] as String?,
      lastModifiedByUserId: json['last_modified_by_user_id'] as String?,
      lastModifiedByUserNameId: json['last_modified_by_user_nameid'] as String?,
      lastPauseSubTaskReportId: json['last_pause_sub_task_report_id'] as int?,
      lastStartPauseAt: json['last_start_pause_at'] as String?,
      lastSubTaskReportId: json['last_sub_task_report_id'] as int?,
      lastVerificationEndAt: json['last_verification_end_at'] as String?,
      lastVerificationSubTaskReportId: json['last_verification_sub_task_report_id'] as String?,
      lastWorkingSubTaskReportId: json['last_working_sub_task_report_id'] as int?,
      scheduledEndDate: json['scheduled_end_date'] as String?,
      scheduledStartDate: json['scheduled_start_date'] as String?,
      status: json['status'] as String?,
      subTaskTypeFullCode: json['sub_task_type_full_code'] as String?,
      subTaskTypeFullName: json['sub_task_type_full_name'] as String?,
      subTaskTypeId: json['sub_task_type_id'] as int?,
      subTaskTypeName: json['sub_task_type_name'] as String?,
      taskId: json['task_id'] as int?,
      taskTypeName: json['task_type_name'] as String?,
      workingEndAt: json['working_end_at'] as String?,
      workingStartAt: json['working_start_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assigned_at': assignedAt,
      'code': code,
      'complete_code': completeCode,
      'completed_at': completedAt,
      'created_at': createdAt,
      'created_by_user_id': createdByUserId,
      'created_by_user_nameid': createdByUserNameId,
      'customer_address_kabupaten_location_code': customerAddressKabupatenLocationCode,
      'customer_address_kecamatan_location_code': customerAddressKecamatanLocationCode,
      'customer_address_kelurahan_location_code': customerAddressKelurahanLocationCode,
      'customer_address_postal_code': customerAddressPostalCode,
      'customer_address_province_location_code': customerAddressProvinceLocationCode,
      'customer_address_rt': customerAddressRt,
      'customer_address_rw': customerAddressRw,
      'customer_address_street': customerAddressStreet,
      'customer_email': customerEmail,
      'customer_fullname': customerFullName,
      'customer_id': customerId,
      'customer_identity_number': customerIdentityNumber,
      'customer_identity_type': customerIdentityType,
      'customer_is_deleted': customerIsDeleted,
      'customer_jenis_anggaran': customerJenisAnggaran,
      'customer_jenis_bangunan': customerJenisBangunan,
      'customer_kategory_pelanggan': customerKategoryPelanggan,
      'customer_kategory_wilayah': customerKategoryWilayah,
      'customer_korespondensi_media': customerKorespondensiMedia,
      'customer_latitude': customerLatitude,
      'customer_longitude': customerLongitude,
      'customer_npwp': customerNpwp,
      'customer_number': customerNumber,
      'customer_phone_number': customerPhoneNumber,
      'customer_program_pelanggan': customerProgramPelanggan,
      'customer_register_at': customerRegisterAt,
      'customer_registration_number': customerRegistrationNumber,
      'customer_rs_customer_sector_code': customerRsCustomerSectorCode,
      'customer_rs_customer_sector_name': customerRsCustomerSectorName,
      'customer_sales_area_code': customerSalesAreaCode,
      'customer_sales_area_name': customerSalesAreaName,
      'customer_segment_code': customerSegmentCode,
      'customer_skema_pembayaran': customerSkemaPembayaran,
      'customer_type_code': customerTypeCode,
      'expired_at': expiredAt,
      'first_fixing_start_at': firstFixingStartAt,
      'first_verification_start_at': firstVerificationStartAt,
      'fix_count': fixCount,
      'id': id,
      'is_deleted': isDeleted,
      'is_verification_success': isVerificationSuccess,
      'is_working_finish': isWorkingFinish,
      'last_canceled_by_customer_at': lastCanceledByCustomerAt,
      'last_canceled_by_customer_sub_task_report_id': lastCanceledByCustomerSubTaskReportId,
      'last_canceled_by_field_executor_at': lastCanceledByFieldExecutorAt,
      'last_canceled_by_field_executor_sub_task_report_id': lastCanceledByFieldExecutorSubTaskReportId,
      'last_end_pause_at': lastEndPauseAt,
      'last_field_executor_user_fullname': lastFieldExecutorUserFullName,
      'last_field_executor_user_id': lastFieldExecutorUserId,
      'last_field_executor_user_identity_number': lastFieldExecutorUserIdentityNumber,
      'last_field_executor_user_identity_type': lastFieldExecutorUserIdentityType,
      'last_field_executor_user_organization_user_membership_number':
          lastFieldExecutorUserOrganizationUserMembershipNumber,
      'last_field_executor_user_phone_number': lastFieldExecutorUserPhoneNumber,
      'last_field_supervisor_user_fullname': lastFieldSupervisorUserFullName,
      'last_field_supervisor_user_id': lastFieldSupervisorUserId,
      'last_fixing_end_at': lastFixingEndAt,
      'last_fixing_sub_task_report_id': lastFixingSubTaskReportId,
      'last_modified_at': lastModifiedAt,
      'last_modified_by_user_id': lastModifiedByUserId,
      'last_modified_by_user_nameid': lastModifiedByUserNameId,
      'last_pause_sub_task_report_id': lastPauseSubTaskReportId,
      'last_start_pause_at': lastStartPauseAt,
      'last_sub_task_report_id': lastSubTaskReportId,
      'last_verification_end_at': lastVerificationEndAt,
      'last_verification_sub_task_report_id': lastVerificationSubTaskReportId,
      'last_working_sub_task_report_id': lastWorkingSubTaskReportId,
      'scheduled_end_date': scheduledEndDate,
      'scheduled_start_date': scheduledStartDate,
      'status': status,
      'sub_task_type_full_code': subTaskTypeFullCode,
      'sub_task_type_full_name': subTaskTypeFullName,
      'sub_task_type_id': subTaskTypeId,
      'sub_task_type_name': subTaskTypeName,
      'task_id': taskId,
      'task_type_name': taskTypeName,
      'working_end_at': workingEndAt,
      'working_start_at': workingStartAt,
    };
  }
}

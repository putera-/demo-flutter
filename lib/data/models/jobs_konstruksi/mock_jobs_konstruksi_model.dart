import 'package:pgnpartner_mobile/data/models/form_data/gas_in_form_data.dart';
import 'package:pgnpartner_mobile/data/models/form_data/gas_meter_form_data.dart';
import 'package:pgnpartner_mobile/data/models/form_data/pipa_instalasi_form_data.dart';
import 'package:pgnpartner_mobile/data/models/form_data/pipa_service_form_data.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/job_schedule.dart';
import 'package:pgnpartner_mobile/data/models/pelanggan/pelanggan.dart';
import 'package:pgnpartner_mobile/data/models/teknisi/mock_teknisi.dart';

class MockJobKonstruksi {
  final String id;
  final String type;
  final String typeName;
  final int pelangganId;
  final Pelanggan pelanggan;
  final String createdAt;
  final JobDetailPipaInstalasi pipaInstallasi;
  final JobDetailPipaService pipaService;
  final JobDetailGasMeter pasangMeterGas;
  final JobDetailGasIn gasIn;

  MockJobKonstruksi({
    required this.id,
    required this.type,
    required this.typeName,
    required this.pelangganId,
    required this.pelanggan,
    required this.createdAt,
    required this.pipaInstallasi,
    required this.pipaService,
    required this.pasangMeterGas,
    required this.gasIn,
  });

  factory MockJobKonstruksi.fromJson(dynamic json) {
    return MockJobKonstruksi(
      id: json['id'].toString(),
      type: json['type'],
      typeName: json['type_name'],
      pelangganId: json['pelanggan_id'],
      pelanggan: Pelanggan.fromJson(json['pelanggan']),
      createdAt: json['created_at'],
      pipaInstallasi: JobDetailPipaInstalasi.fromJson(json['pipa_installasi']),
      pipaService: JobDetailPipaService.fromJson(json['pipa_service']),
      pasangMeterGas: JobDetailGasMeter.fromJson(json['pasang_meter_gas']),
      gasIn: JobDetailGasIn.fromJson(json['gas_in']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'type_name': typeName,
      'pelanggan_id': pelangganId,
      "pelanggan": pelanggan.toJson(),
      'created_at': createdAt,
      'pipa_installasi': pipaInstallasi.toJson(),
      'pipa_service': pipaService.toJson(),
      'pasang_meter_gas': pasangMeterGas.toJson(),
      'gas_in': gasIn.toJson(),
    };
  }
}

class JobDetail {
  final bool done;
  final String? doneDatetime;
  final String? beritaAcara;
  final String? teknisiId;
  final MockTeknisi? teknisi;
  final JobSchedule? schedule;

  JobDetail({
    required this.done,
    this.doneDatetime,
    this.beritaAcara,
    this.teknisiId,
    this.teknisi,
    this.schedule,
  });

  factory JobDetail.fromJson(Map<String, dynamic> json) {
    return JobDetail(
      done: json['done'],
      doneDatetime: json['done_datetime'],
      beritaAcara: json['berita_acara'],
      teknisiId: json['teknisi_id'],
      teknisi: json['teknisi'] != null
          ? MockTeknisi.fromJson(json['teknisi'])
          : null,
      schedule: json['schedule'] != null
          ? JobSchedule.fromJson(json['schedule'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'done': done,
      'done_datetime': doneDatetime,
      'berita_acara': beritaAcara,
      'teknisi_id': teknisiId,
      'teknisi': teknisi?.toJson(),
      'schedule': schedule?.toJson(),
    };
  }
}

class JobDetailPipaInstalasi extends JobDetail {
  final PipaInstalasiFormData? formData;
  JobDetailPipaInstalasi({
    required super.done,
    super.doneDatetime,
    super.beritaAcara,
    super.teknisiId,
    super.teknisi,
    super.schedule,
    this.formData,
  });

  factory JobDetailPipaInstalasi.fromJson(Map<String, dynamic> json) {
    return JobDetailPipaInstalasi(
        done: json['done'],
        doneDatetime: json['done_datetime'],
        beritaAcara: json['berita_acara'],
        teknisiId: json['teknisi_id'],
        teknisi: json['teknisi'] != null
            ? MockTeknisi.fromJson(json['teknisi'])
            : null,
        schedule: json['schedule'] != null
            ? JobSchedule.fromJson(json['schedule'])
            : null,
        formData: json['form_data'] != null
            ? PipaInstalasiFormData.fromJson(json['form_data'])
            : null);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'form_data': formData?.toJson(),
    };
  }
}

class JobDetailPipaService extends JobDetail {
  final PipaServiceFormData? formData;
  JobDetailPipaService({
    required super.done,
    super.doneDatetime,
    super.beritaAcara,
    super.teknisiId,
    super.teknisi,
    super.schedule,
    this.formData,
  });

  factory JobDetailPipaService.fromJson(Map<String, dynamic> json) {
    return JobDetailPipaService(
      done: json['done'],
      doneDatetime: json['done_datetime'],
      beritaAcara: json['berita_acara'],
      teknisiId: json['teknisi_id'],
      teknisi: json['teknisi'] != null
          ? MockTeknisi.fromJson(json['teknisi'])
          : null,
      schedule: json['schedule'] != null
          ? JobSchedule.fromJson(json['schedule'])
          : null,
      formData: json['form_data'] != null
          ? PipaServiceFormData.fromJson(json['form_data'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'form_data': formData?.toJson(),
    };
  }
}

class JobDetailGasMeter extends JobDetail {
  final GasMeterFormData? formData;
  JobDetailGasMeter({
    required super.done,
    super.doneDatetime,
    super.beritaAcara,
    super.teknisiId,
    super.teknisi,
    super.schedule,
    this.formData,
  });

  factory JobDetailGasMeter.fromJson(Map<String, dynamic> json) {
    return JobDetailGasMeter(
      done: json['done'],
      doneDatetime: json['done_datetime'],
      beritaAcara: json['berita_acara'],
      teknisiId: json['teknisi_id'],
      teknisi: json['teknisi'] != null
          ? MockTeknisi.fromJson(json['teknisi'])
          : null,
      schedule: json['schedule'] != null
          ? JobSchedule.fromJson(json['schedule'])
          : null,
      formData: json['form_data'] != null
          ? GasMeterFormData.fromJson(json['form_data'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'form_data': formData?.toJson(),
    };
  }
}

class JobDetailGasIn extends JobDetail {
  final GasInFormData? formData;
  JobDetailGasIn({
    required super.done,
    super.doneDatetime,
    super.beritaAcara,
    super.teknisiId,
    super.teknisi,
    super.schedule,
    this.formData,
  });

  factory JobDetailGasIn.fromJson(Map<String, dynamic> json) {
    return JobDetailGasIn(
      done: json['done'],
      doneDatetime: json['done_datetime'],
      beritaAcara: json['berita_acara'],
      teknisiId: json['teknisi_id'],
      teknisi: json['teknisi'] != null
          ? MockTeknisi.fromJson(json['teknisi'])
          : null,
      schedule: json['schedule'] != null
          ? JobSchedule.fromJson(json['schedule'])
          : null,
      formData: json['form_data'] != null
          ? GasInFormData.fromJson(json['form_data'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'form_data': formData?.toJson(),
    };
  }
}

// // class Teknisi {
// //   final int id;
// //   final String name;
// //   final int organizationId;
// //   final Organization organization;

// //   Teknisi({
// //     required this.id,
// //     required this.name,
// //     required this.organizationId,
// //     required this.organization,
// //   });

// //   factory Teknisi.fromJson(Map<String, dynamic> json) {
// //     return Teknisi(
// //       id: json['id'],
// //       name: json['name'],
// //       organizationId: json['organizationId'],
// //       organization: Organization.fromJson(json['organization']),
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'id': id,
// //       'name': name,
// //       'organizationId': organizationId,
// //       'organization': organization.toJson(),
// //     };
// //   }
// // }

// // class Organization {
// //   final int id;
// //   final String name;

// //   Organization({
// //     required this.id,
// //     required this.name,
// //   });

// //   factory Organization.fromJson(Map<String, dynamic> json) {
// //     return Organization(
// //       id: json['id'],
// //       name: json['name'],
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'id': id,
// //       'name': name,
// //     };
// //   }
// // }



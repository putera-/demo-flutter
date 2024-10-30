import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/widgets/app_bar_general.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/sub_task_report_controller.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/widgets/report/sub_task_report_card.dart';

class SubTaskReportView extends GetView<SubTaskReportController> {
  const SubTaskReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final type = Get.arguments['type'];
    final finishedDate = Get.arguments['finishDate'];

    String headerIcon;

    switch (type) {
      case 'Pipa Instalasi (SK)':
        headerIcon = 'assets/icons/ic_pipa_instalasi.svg';
        break;
      case 'Pipa Service (SR)':
        headerIcon = 'assets/icons/ic_pipa_service.svg';
        break;
      case 'Pasang Meter Gas':
        headerIcon = 'assets/icons/ic_pasang_meter_gas.svg';
        break;
      case 'Gas In':
        headerIcon = 'assets/icons/ic_gas_in.svg';
        break;
      default:
        headerIcon = 'assets/icons/ic_pipa_instalasi.svg';
        break;
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBarGeneral(title: 'Detail $type'),
      body: ListView(children: [
        Stack(
          children: [
            _buildInfo(),
            Obx(() {
              final subJobReport = controller.subJobConstructionReport.value;
              final gSize = controller.gSize.value;
              final meter = controller.meter.value;

              String formattedFinishedDate = 'Data tidak tersedia';
              String formattedGasInDate = 'Data tidak tersedia';
              final finishedDateString = finishedDate;
              final gasInDateString = subJobReport?.report?.gasInDate;

              if (finishedDateString != null) {
                DateTime finishedDate = DateTime.parse(finishedDateString.toIso8601String());
                formattedFinishedDate = DateFormat('dd/MM/yyyy').format(finishedDate);
              }

              if (gasInDateString != null) {
                DateTime gasInDate = DateTime.parse(gasInDateString.toIso8601String());
                formattedGasInDate = DateFormat('dd/MM/yyyy').format(gasInDate);
              }

              return Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Column(
                  children: [
                    SubTaskReportCard(
                      title: subJobReport?.subTaskTypeName ?? '-',
                      isHeader: true,
                      headerIcon: headerIcon,
                      body: Column(
                        children: [
                          _buildInfoRow('Tanggal Selesai', formattedFinishedDate),
                          if (type == 'Pipa Instalasi (SK)' || type == 'Gas In') ...[
                            const SizedBox(height: 8),
                            Container(
                              height: 44,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppTheme.blue200,
                                border: Border.all(
                                  width: 1,
                                  color: AppTheme.border200,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/ic_lampiran.svg'),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Lampiran_BA_028917',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.primary,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                      color: AppTheme.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SubTaskReportCard(
                      title: 'Data Pelanggan',
                      body: Obx(() {
                        final subJob = controller.subJobConstruction.value;

                        if (subJob == null) {
                          return const Center(child: Text('No data available'));
                        }

                        return Column(
                          children: [
                            _buildInfoRow('RS Sektor Pelanggan', subJob.customerRsCustomerSectorName ?? '-'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Email', subJob.customerEmail ?? '-'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Nomor Ponsel', subJob.customerPhoneNumber ?? '-'),
                            const SizedBox(height: 12),
                            _buildInfoRow('NPWP', subJob.customerNpwp ?? '-'),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    if (type == 'Pipa Instalasi (SK)') ...[
                      SubTaskReportCard(
                        title: 'Data Peralatan Gas',
                        body: Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Peralatan dan Jumlah Unit',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.secondary250,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.equipmentList.length,
                                  itemBuilder: (context, index) {
                                    final equipment = controller.equipmentList[index];
                                    return Column(
                                      children: [
                                        _buildInfoRow(
                                          equipment.name,
                                          '${equipment.quantity.toString()} unit',
                                          isTools: true,
                                        ),
                                        if (index != controller.equipmentList.length - 1)
                                          const Divider(
                                            color: Colors.grey,
                                            height: 16.0,
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      SubTaskReportCard(
                        title: 'Data Penggunaan Pipa',
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow('Panjang Pipa', '${subJobReport?.report?.pipeLength ?? '-'} meter'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Kelebihan Panjang Pipa',
                                '${subJobReport?.report?.calculatedExtraPipeLength ?? '-'} meter',
                                isPipa: true),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SubTaskReportCard(
                        title: 'Data Pipa Instalaasi',
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow('Panjang Pipa', '${subJobReport?.report?.pipeLength ?? '-'} meter'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Mulai', subJobReport?.report?.testStartTime ?? '-'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Selesai', subJobReport?.report?.testEndTime ?? '-'),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                                'Lama Pengujian', '${subJobReport?.report?.calculatedTestDurationMinute ?? '-'} Menit'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Tekanan Uji', '${subJobReport?.report?.testPressure ?? '-'} Bar'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Status Pipa Cabang\nDepan Rumah',
                                (subJobReport?.report?.testStartTime != null) ? 'Tersedia' : 'Tidak Tersedia'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Tanggal Selesai Pekerjaan', formattedFinishedDate),
                            const SizedBox(height: 12),
                            _buildDashedDivider(),
                            const SizedBox(height: 16),
                            const Text(
                              'Foto Alat',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.secondary800,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildImageCard('Foto Pneumatik Akhir', 'assets/images/img_isometrik.png',
                                'IMG_u843921102.png', '657 kb')
                          ],
                        ),
                      ),
                    ],
                    if (type == 'Pipa Service (SR)') ...[
                      SubTaskReportCard(
                        title: 'Data Pipa Service',
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subJobReport?.report?.tappingSaddleCustom != ""
                                ? _buildInfoRow(
                                    'Tapping Saddle',
                                    subJobReport?.report?.tappingSaddleCustom ?? '-',
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: controller.saddleList.length,
                                    itemBuilder: (context, index) {
                                      final saddle = controller.saddleList[index];
                                      return _buildInfoRow(
                                        'Tapping Saddle',
                                        saddle.name,
                                      );
                                    },
                                  ),
                            const SizedBox(height: 12),
                            _buildInfoRow('Mulai', subJobReport?.report?.testStartTime ?? '-'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Selesai', subJobReport?.report?.testEndTime ?? '-'),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                                'Lama Pengujian', '${subJobReport?.report?.calculatedTestDurationMinute ?? '-'} Menit'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Tekanan Uji', '${subJobReport?.report?.testPressure ?? '-'} Bar'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Tanggal Selesai Pekerjaan', formattedFinishedDate),
                            const SizedBox(height: 12),
                            _buildDashedDivider(),
                            const SizedBox(height: 16),
                            const Text(
                              'Foto Alat',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.secondary800,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildImageCard('Foto Pneumatik Akhir', 'assets/images/img_isometrik.png',
                                'IMG_u843921102.png', '657 kb')
                          ],
                        ),
                      ),
                    ],
                    if (type == 'Pasang Meter Gas') ...[
                      SubTaskReportCard(
                        title: 'Data Pasang Meter Gas',
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow('Jenis Meter', meter?.name ?? '-'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Merek (Meter)', subJobReport?.report?.meterBrand ?? '-'),
                            const SizedBox(height: 12),
                            _buildInfoRow('SN Meter', subJobReport?.report?.snMeter ?? '-'),
                            const SizedBox(height: 12),
                            _buildInfoRow('GSize', gSize?.name ?? '-'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Qmin', '${subJobReport?.report?.qmin ?? '-'} m³/jam'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Qmax', '${subJobReport?.report?.qmax ?? '-'} m³/jam'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Pmax', '${subJobReport?.report?.pmax ?? '-'} bar'),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                                'Mulai Kalibrasi Bulan', 'Bulan ${subJobReport?.report?.startCalibrationMonth ?? '-'}'),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                                'Mulai Kalibrasi Tahun', '${subJobReport?.report?.startCalibrationYear ?? '-'}'),
                            const SizedBox(height: 12),
                            _buildDashedDivider(),
                            const SizedBox(height: 16),
                            const Text(
                              'Foto Alat',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.secondary800,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildImageCard('Foto Pneumatik Akhir', 'assets/images/img_isometrik.png',
                                'IMG_u843921102.png', '657 kb')
                          ],
                        ),
                      ),
                    ],
                    if (type == 'Gas In') ...[
                      SubTaskReportCard(
                        title: 'Data Peralatan Gas',
                        body: Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Peralatan dan Jumlah Unit',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.secondary250,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.equipmentList.length,
                                  itemBuilder: (context, index) {
                                    final equipment = controller.equipmentList[index];
                                    return Column(
                                      children: [
                                        _buildInfoRow(
                                          equipment.name,
                                          '${equipment.quantity.toString()} unit',
                                          isTools: true,
                                        ),
                                        if (index != controller.equipmentList.length - 1)
                                          const Divider(
                                            color: Colors.grey,
                                            height: 16.0,
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      SubTaskReportCard(
                        title: 'Data PGN Meter',
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow('Merek (Meter)', subJobReport?.report?.meterBrand ?? '-'),
                            const SizedBox(height: 12),
                            _buildInfoRow('SN Meter', subJobReport?.report?.snMeter ?? '-'),
                            const SizedBox(height: 12),
                            _buildInfoRow('GSize', gSize?.name ?? '-'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Pmax', '${subJobReport?.report?.pmax ?? '-'} bar'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Tanggal Gas In', formattedGasInDate),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                                'Angka Awal Stand Meter', '${subJobReport?.report?.standMeterStartNumber ?? '-'}'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Tekanan', '${subJobReport?.report?.pressureStart ?? '-'} bar'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Suhu', '${subJobReport?.report?.temperatureStart ?? '-'} °C'),
                            const SizedBox(height: 12),
                            _buildDashedDivider(),
                            const SizedBox(height: 16),
                            const Text(
                              'Foto Alat',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.secondary800,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildImageCard('Foto Pneumatik Akhir', 'assets/images/img_isometrik.png',
                                'IMG_u843921102.png', '657 kb')
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                  ],
                ),
              );
            }),
          ],
        ),
      ]),
    );
  }

  Widget _buildInfo() {
    return Container(
      height: 172,
      width: double.infinity,
      color: AppTheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(alignment: Alignment.topLeft, child: SvgPicture.asset('assets/icons/ic_info2.svg')),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data pekerjaan sudah dikirim',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Data pekerjaan akan segera diperiksa oleh\nWaspang',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, {bool isTools = false, bool isPipa = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isTools ? AppTheme.secondary800 : AppTheme.secondary250,
            ),
          ),
          Row(
            children: [
              if (isPipa)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: SvgPicture.asset('assets/icons/ic_ruler.svg'),
                ),
              LimitedBox(
                maxWidth: Get.width * 0.4,
                child: Text(
                  value,
                  maxLines: 2,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isPipa ? FontWeight.w700 : FontWeight.w500,
                    color: isTools ? AppTheme.secondary250 : AppTheme.secondary800,
                    fontStyle: isTools ? FontStyle.italic : FontStyle.normal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(String title, String imagePath, String imageName, String imageSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.secondary800,
          ),
        ),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.border450,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 154,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LimitedBox(
                          maxWidth: 110,
                          child: Text(
                            imageName,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.secondary800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          imageSize,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.secondary250,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }

  Widget _buildDashedDivider() {
    return Row(
      children: List.generate(
        150 ~/ 5,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? AppTheme.secondary100 : Colors.transparent,
            height: 1,
          ),
        ),
      ),
    );
  }
}

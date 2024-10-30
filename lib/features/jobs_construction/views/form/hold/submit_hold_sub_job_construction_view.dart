import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/utils/color_extensions.dart';
import 'package:pgnpartner_mobile/core/widgets/bottom_button_widget.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/sub_job_construction_model.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/job_construction_detail_controller.dart';

class SubmitHoldSubJobConstructionView extends GetView<JobConstructionDetailController> {
  const SubmitHoldSubJobConstructionView({super.key});

  @override
  Widget build(BuildContext context) {
    SubJobConstructionModel subJob = Get.arguments;
    controller.holdDate.text = DateTime.now().toString().substring(0, 10);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.submitHoldSubJobConstruction(subJob.id, subJob.status);
    });

    return PopScope(
      canPop: false,
      // onPopInvokedWithResult: (didPop, result) {
      //   if (didPop) return;
      //   // bisa back jika sudah selesai
      //   if (!controller.processingHold.value) Get.back();
      // },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Obx(() => Column(
                children: [
                  const Spacer(),
                  if (controller.processingHold.value) ...[
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircularProgressIndicator(
                              value: controller.submitProgress.value / 100,
                              strokeWidth: 7,
                              backgroundColor: AppTheme.border300,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppTheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Proses Tunda Pekerjaan ...',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: HexColor('#1D2939'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Harap tunggu beberapa detik',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: HexColor('#475467'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                  // FAILED
                  if (!controller.processingHold.value && !controller.processingHoldSuccess.value)
                    Center(
                        child: Text(
                      'Proses Tunda Pekerjaan Gagal.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: HexColor('#1D2939'),
                      ),
                    )),
                  if (!controller.processingHold.value && controller.processingHoldSuccess.value) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.cardShadow.withOpacity(0.08),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ],
                          border: Border.all(
                            width: 1,
                            color: AppTheme.border300,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Image.asset(
                                    'assets/images/ic_success_new.png',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Informasi Penundaan Berhasil Dikirim',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.secondary800,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Anda dapat mengerjakan pekerjaan ini lagi dengan mengatur ulang jadwal',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.secondary250,
                                ),
                              ),
                              const SizedBox(height: 24),
                              _buildDashedDivider(),
                              const SizedBox(height: 24),
                              // TODO replace No Ref Tunda
                              _buildInfoRow(
                                  'No Ref Tunda', controller.responseTunda.value.toString(), AppTheme.secondary800),
                              _buildInfoRow('Tanggal Hari Ini', DateFormat('dd MMMM yyyy').format(DateTime.now()),
                                  AppTheme.secondary800),
                              _buildInfoRow('ID Pelanggan', controller.jobConstruciton.value!.customer!.customerNumber,
                                  AppTheme.blue400),
                              _buildInfoRow('Nama Pelanggan', controller.jobConstruciton.value!.customer!.fullname,
                                  AppTheme.secondary800),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                ],
              )),
        ),
        // TODO color button jika form belum terisi
        bottomNavigationBar: Obx(
          () => BottomButtonWidget(
            onTap: () {
              if (!controller.processingHold.value) Get.back();
            },
            title: controller.processingHold.value
                ? "Loading.."
                : (controller.processingHoldSuccess.value ? "Selesai" : "Kembali"),
            disabled: controller.processingHold.value,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppTheme.secondary250,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashedDivider() {
    return Row(
      children: List.generate(
        150 ~/ 5,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.grey : Colors.transparent,
            height: 1,
          ),
        ),
      ),
    );
  }
}

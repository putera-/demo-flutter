import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pgnpartner_mobile/config/routes.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/widgets/app_bar_general.dart';
import 'package:pgnpartner_mobile/core/widgets/bottom_button_widget.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/job_construction_detail_controller.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/views/customer/job_customer_detail_shimmer.dart';

class JobCustomerDetailView extends GetView<JobConstructionDetailController> {
  const JobCustomerDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> gMapcontroller =
        Completer<GoogleMapController>();

    int jobId = Get.arguments ?? controller.jobConstrucitonId.value;

    controller.getAuthUser();
    controller.jobConstrucitonId.value = jobId;
    controller.getJobConstruction();
    controller.fetchSubJobDetails();
    controller.getSubJobReportFileGroupList();

    // Kantor PGN
    double defaultLatitude = -6.159840433976632;
    double defaultLongitude = 106.81610709418855;

// TODO shimmer, karena job detail belum tentu ada, jadi harus di fetch dulu
    return Scaffold(
      appBar: AppBarGeneral(
        title: "Detail Pelanggan",
        onTapLeading: () {
          Get.back();
        },
      ),
      body: Obx(
        () => SafeArea(
            child: ListView(
          shrinkWrap: true,
          children: [
            if (controller.jobConstruciton.value == null) ...[
              const JobCustomerDetailShimmer(),
            ],
            if (controller.jobConstruciton.value != null) ...[
              SizedBox(
                height: 185,
                child: GoogleMap(
                  mapType: MapType.terrain,
                  initialCameraPosition: CameraPosition(
                    target: controller.jobConstruciton.value != null
                        ? LatLng(
                            controller.jobConstruciton.value!.customer
                                    ?.latitude ??
                                defaultLatitude,
                            controller.jobConstruciton.value!.customer
                                    ?.longitude ??
                                defaultLongitude)
                        : LatLng(defaultLatitude, defaultLongitude),
                    zoom: 14.5,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    gMapcontroller.complete(controller);
                  },
                  markers: <Marker>{
                    Marker(
                      markerId: const MarkerId('marker'),
                      position: controller.jobConstruciton.value != null
                          ? LatLng(
                              controller.jobConstruciton.value!.customer
                                      ?.latitude ??
                                  defaultLatitude,
                              controller.jobConstruciton.value!.customer
                                      ?.longitude ??
                                  defaultLongitude)
                          : LatLng(defaultLatitude, defaultLongitude),
                      infoWindow: const InfoWindow(),
                    )
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/icons/ic_location3.svg"),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller
                                    .jobConstruciton.value!.customer?.address ??
                                "",
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Distance not available",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customerInfo(
                        'No Ref Pelanggan',
                        controller.jobConstruciton.value!.customer
                                ?.customerSegmentCode ??
                            "",
                        isHighlighted: true),
                    customerInfo(
                        'Kelompok Pelanggan',
                        controller.jobConstruciton.value!.customer
                                ?.jenisAnggaran ??
                            ""),
                    customerInfo(
                        'Nama',
                        controller.jobConstruciton.value!.customer?.fullname ??
                            ""),
                    customerInfo(
                        'Nomor Handphone',
                        controller
                                .jobConstruciton.value!.customer?.phonenumber ??
                            ""),
                    customerInfo(
                        'Nomor Identitas',
                        controller.jobConstruciton.value!.customer
                                ?.identityNumber ??
                            ""),
                    customerInfo(
                        'Tipe Identitas',
                        controller.jobConstruciton.value!.customer
                                ?.identityType ??
                            ""),
                    customerInfo(
                        'Jenis Anggaran',
                        controller.jobConstruciton.value!.customer
                                ?.jenisAnggaran ??
                            ""),
                  ],
                ),
              ),
            ],
          ],
        )),
      ),
      bottomNavigationBar: Obx(() =>
        (controller.jobConstruciton.value == null)
            ? const SizedBox()
            : BottomButtonWidget(
                title: "Lihat Detail Pekerjaan",
                onTap: () => Get.toNamed(Routes.jobsDetailCustomerStep),
              ),
      ),
    );
  }

  Widget customerInfo(String title, String value,
      {bool isHighlighted = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppTheme.secondary250,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: isHighlighted ? AppTheme.primary : AppTheme.secondary800,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

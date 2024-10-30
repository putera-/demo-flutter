import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/widgets/bottom_button_widget.dart';
import 'package:pgnpartner_mobile/core/widgets/date_input.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/sub_job_construction_model.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/job_construction_detail_controller.dart';

class ScheduleFormSubJobConstructionView
    extends GetView<JobConstructionDetailController> {
  const ScheduleFormSubJobConstructionView({super.key});

  @override
  Widget build(BuildContext context) {
    SubJobConstructionModel subJob = Get.arguments;

    DateTime? startParsedDate = subJob.scheduledStartDate != null
        ? DateFormat('yyyy-MM-dd').parse(subJob.scheduledStartDate!)
        : null;
    DateTime? endParsedDate = subJob.scheduledEndDate != null
        ? DateFormat('yyyy-MM-dd').parse(subJob.scheduledEndDate!)
        : null;

    String formattedDate = startParsedDate != null
        ? DateFormat('d MMMM yyyy').format(startParsedDate)
        : '';

    String formattedEndDate = endParsedDate != null
        ? DateFormat('d MMMM yyyy').format(endParsedDate)
        : '';

    controller.scheduleStartDate.text = formattedDate;
    controller.scheduleEndDate.text = formattedEndDate;


    bool scheduleIsSet =
        subJob.scheduledStartDate != null && subJob.scheduledEndDate != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: false,
        elevation: 0,
        title: Text(
          "${scheduleIsSet ? 'Ubah' : 'Atur'} Jadwal",
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppTheme.secondary800,
          ),
        ),
        leadingWidth: 0,
        leading: const SizedBox(),
        shape: const Border(
          bottom: BorderSide(
            color: AppTheme.border300,
            width: 1,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            // BottomSheetListCheckBoxTriggerWidget<String>(
            //   title: "Jenis Aktivitas",
            //   required: true,
            //   sheetTitle: "Pilih Aktivitas yang akan diatur",
            //   items: const [
            //     'Pipa Instalasi (SK)',
            //     'Pipa Service (SR)',
            //     'Pasang Meter Gas',
            //     'Gas In'
            //   ],
            //   itemToString: (item) => item,
            //   controller: bottomSheetController,
            //   placeholder: "Pilih aktivitas yang diatur",
            // ),
            // const SizedBox(height: 24),
            DateInput(
              required: true,
              title: 'Pilih Estimasi Pengerjaan',
              placeholder: 'Dari',
              controller: controller.scheduleStartDate,
              suffixIcon: SvgPicture.asset(
                "assets/icons/ic_calendar.svg",
              ),
              minDate: DateTime.now(),
              initialSelectedDate: subJob.scheduledStartDate != null
                  ? DateTime.parse(subJob.scheduledStartDate!)
                  : null,
            ),
            // Obx(() => Text(controller.scheduleStartDate.value.text)),
            const SizedBox(height: 8),
            DateInput(
              placeholder: 'Sampai',
              controller: controller.scheduleEndDate,
              suffixIcon: SvgPicture.asset(
                "assets/icons/ic_calendar.svg",
              ),
              minDate: DateTime.now(),
              initialSelectedDate: subJob.scheduledEndDate != null
                  ? DateTime.parse(subJob.scheduledEndDate!)
                  : null,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButtonWidget(
        onTap: () async {
          await controller.setSubJobConstructionSchedule(subJob.id);
          Get.back();
        },
        title: "Simpan",
      ),
    );
  }
}

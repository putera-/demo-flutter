import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pgnpartner_mobile/config/routes.dart';
import 'package:pgnpartner_mobile/core/dialogs/general_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/utils/datetime_extensions.dart';
import 'package:pgnpartner_mobile/core/widgets/badge_widget.dart';
import 'package:pgnpartner_mobile/core/widgets/button_widget.dart';
import 'package:pgnpartner_mobile/data/models/auth/auth_user.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/sub_job_construction_model.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/job_construction_detail_controller.dart';

class SubJobConstructionWidget extends StatelessWidget {
  final SubJobConstructionModel subJob;

  final String? attachment;
  final String? route;
  final void Function(String value)? onKerjakanPressed; // Nullable
  final void Function(String value)? onTundaPressed; // Nullable

  const SubJobConstructionWidget({
    super.key,
    required this.subJob,
    this.attachment,
    this.route,
    this.onKerjakanPressed,
    this.onTundaPressed,
  });

  JobConstructionDetailController get controller => Get.find<JobConstructionDetailController>();

  @override
  Widget build(BuildContext context) {
    // final int? teknisiId =  subJob.lastFieldExecutorUserId;
    final int? teknisiId = subJob.status != SubJobConstructionStatus.CANCELED_BY_CUSTOMER ||
            subJob.status != SubJobConstructionStatus.CANCELED_BY_FIELD_EXECUTOR
        ? subJob.lastFieldExecutorUserId
        : null;

    // final bool haveAction = false;
    final AuthUser? teknisi = controller.authUser.value;
    final int teknisiIdLogin = controller.authLoginId.value;
    final bool taken = teknisiId != null && teknisiId == teknisiIdLogin;
    final bool takenByOther = teknisiId != null && teknisiId != teknisiIdLogin;

    final bool canTake = (subJob.subTaskTypeFullCode == '01-01' && (teknisi?.jobConstructionExpertises?.sk ?? false)) ||
        (subJob.subTaskTypeFullCode == '01-02' && (teknisi?.jobConstructionExpertises?.sr ?? false)) ||
        (subJob.subTaskTypeFullCode == '01-03' && (teknisi?.jobConstructionExpertises?.gasMeter ?? false)) ||
        (subJob.subTaskTypeFullCode == '01-04' && (teknisi?.jobConstructionExpertises?.gasIn ?? false));

    SubJobConstructionStatus status = subJob.status;
    final bool done = status == SubJobConstructionStatus.VERIFICATION_SUCCESS ||
        status == SubJobConstructionStatus.WAITING_VERIFICATION ||
        status == SubJobConstructionStatus.VERIFYING;

    final String readAbleSchedule = subJob.scheduledStartDate != null && subJob.scheduledEndDate != null
        ? "${DateTime.now().formatReadAbleDate(subJob.scheduledStartDate!)} - ${DateTime.now().formatReadAbleDate(subJob.scheduledEndDate!)}"
        : "";

    bool scheduled = subJob.workingStartAt == null || subJob.workingEndAt == null;

    final Widget description = () {
      if (status == SubJobConstructionStatus.WAITING_ASSIGNMENT || status == SubJobConstructionStatus.BLOCKING_DEPENDENCY) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pipa Instalasi (SK)
            if (subJob.subTaskTypeFullCode == '01-01') ...[
              Text(
                canTake ? 'Aktivitas ini dapat dikerjakan segera' : 'Aktivitas ini tidak dapat anda ambil',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF1D2939),
                ),
              )
            ],
            // Pipa Service (SR)
            if (subJob.subTaskTypeFullCode == '01-02') ...[
              Text(
                canTake ? 'Aktivitas ini dapat dikerjakan segera' : 'Aktivitas ini tidak dapat anda ambil',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF1D2939),
                ),
              )
            ],
            // Pasang Meter Gas
            if (subJob.subTaskTypeFullCode == '01-03') ...[
              Text(
                // TODO make sure this condition is correct
                // controller.subJobConstructions[0].status == SubJobConstructionStatus.VERIFICATION_SUCCESS ||
                //         controller.subJobConstructions[1].status == SubJobConstructionStatus.VERIFICATION_SUCCESS
                status != SubJobConstructionStatus.BLOCKING_DEPENDENCY
                    ? (canTake ? 'Aktivitas ini dapat dikerjakan segera' : 'Aktivitas ini tidak dapat anda ambil')
                    : 'Aktivitas ini dapat dikerjakan ketika pekerjaan Pipa Instalasi (SK) atau Pipa Servis (SR) selesai dikerjakan.',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF1D2939),
                ),
              )
            ],
            // Gas In
            if (subJob.subTaskTypeFullCode == '01-04') ...[
              Text(
                status != SubJobConstructionStatus.BLOCKING_DEPENDENCY
                    ? (canTake ? 'Aktivitas ini dapat dikerjakan segera' : 'Aktivitas ini tidak dapat anda ambil')
                    : 'Aktivitas ini dapat dikerjakan ketika pekerjaan Pipa Instalasi (SK), Pipa Servis (SR), dan Pasang Meter Gas selesai dikerjakan.',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF1D2939),
                ),
              )
            ],
            if (status == SubJobConstructionStatus.WAITING_ASSIGNMENT) ...[
              ButtonWidget(
                  text: 'Ambil Pekerjaan',
                  styleType: canTake ? ButtonStyleType.fill : ButtonStyleType.disable,
                  fillColor: const Color(0xFF0057B8),
                  textColor: Colors.white,
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  onPressed: () async {
                    GeneralDialog.show(
                      image: SizedBox(
                        width: 40,
                        height: 40,
                        child: SvgPicture.asset('assets/icons/ic_warning.svg'),
                      ),
                      title: "Apakah Anda yakin ingin mengambil pekerjaan ${subJob.subTaskTypeName}?",
                      description: 'Setelah pengambilan Pekerjaan, Anda langsung bisa mengerjakannya.',
                      primaryButtonText: "Ya, Ambil",
                      trailingIconPrimary: Obx(
                        () => controller.isPicking.value
                            ? const SpinKitFadingCircle(
                                color: Colors.white,
                                size: 16,
                                duration: Duration(milliseconds: 1000),
                              )
                            : const SizedBox(),
                      ),
                      onTapPrimary: () async {
                        if (!controller.isPicking.value) {
                          await controller.pickSubJobConstruction(subJob);
                        }
                      },
                      secondaryButtonText: "Kembali",
                      onTapSecondary: () {
                        if (!controller.isPicking.value) {
                          Get.back();
                        }
                      },
                    );
                  }),
            ],
          ],
        );
      }

      if (takenByOther) {
        if (done) {
          // SELESAI
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pengerjaan akan dilakukan oleh petugas lain",
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.secondary250,
                ),
              ),
              const SizedBox(height: 4),
              // TODO fix nama teknisi
              Text(
                'TEKNISI ID: $teknisiId',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.secondary800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        } else if (scheduled) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pengerjaan akan dilakukan oleh petugas lain",
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.secondary250,
                ),
              ),
              const SizedBox(height: 4),
              // TODO fix nama teknisi
              Text(
                'TEKNISI ID: $teknisiId',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.secondary800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        } else {
          // BELUM SELESAI
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pengerjaan akan dilakukan oleh petugas lain",
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.secondary250,
                ),
              ),
              const SizedBox(height: 4),
              // TODO fix nama teknisi
              Text(
                'TEKNISI ID: $teknisiId',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.secondary800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        }
      }

      // TAKEN
      // DITUNDA
      if (status == SubJobConstructionStatus.PAUSED) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // STATUS TERTUNDA

            const BadgeWidget(
              text: "Pekerjaan Ditunda",
              backgroundColor: Color(0xFFEAECF0),
              borderColor: Colors.black,
              textColor: Colors.black,
            ),
            const SizedBox(height: 4),
            Text(
                "sudah ${subJob.lastStartPauseAt != null ? '${DateTime.now().difference(subJob.lastStartPauseAt!).inDays}' : 'N/A'} hari ditunda"),
            const SizedBox(height: 4),
            GestureDetector(
              // go to date setting
              onTap: () => controller.resumeSubJobConstruction(subJob.id),
              child: const Row(
                children: [
                  Text(
                    'Lanjutkan Pengerjaan',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.blue600,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.blue600),
                ],
              ),
            ),
            if (status != SubJobConstructionStatus.PAUSED)
              Row(
                children: [
                  if (subJob.scheduledStartDate == null && subJob.scheduledEndDate == null) ...[
                    SvgPicture.asset('assets/icons/ic_calendar.svg'),
                    const SizedBox(width: 8),
                    const Text(
                      'Jadwal pengerjaan\nbelum diatur',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.secondary250,
                      ),
                    ),
                  ],
                  if (subJob.scheduledStartDate != null && subJob.scheduledEndDate != null)
                    Text(
                      readAbleSchedule,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.secondary250,
                      ),
                    ),
                  const Spacer(),
                  if (status == SubJobConstructionStatus.ASSIGNED || status == SubJobConstructionStatus.SCHEDULED)
                    GestureDetector(
                      // go to date setting
                      onTap: () => Get.toNamed(Routes.scheduleFormSubJobConstruction, arguments: subJob),
                      child: SizedBox(
                        child: Row(
                          children: [
                            Text(
                              (subJob.scheduledStartDate == null && subJob.scheduledEndDate == null)
                                  ? 'Atur Jadwal'
                                  : 'Ubah Jadwal',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.blue600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.blue600),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
          ],
        );
      }

      // BELUM ATUR JADWAL
      if (status == SubJobConstructionStatus.ASSIGNED ||
          status == SubJobConstructionStatus.SCHEDULED ||
          status == SubJobConstructionStatus.WORKING) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (subJob.scheduledStartDate == null && subJob.scheduledEndDate == null) ...[
                  SvgPicture.asset('assets/icons/ic_calendar.svg'),
                  const SizedBox(width: 8),
                  const Text(
                    'Jadwal pengerjaan\nbelum diatur',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.secondary250,
                    ),
                  ),
                ],
                if (subJob.scheduledStartDate != null && subJob.scheduledEndDate != null) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECF9EB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF29A11E),
                          ),
                        ),
                        child: const Text(
                          'Jadwal sudah diatur',
                          style: TextStyle(
                            color: Color(0xFF2D8625),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        readAbleSchedule,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.secondary250,
                        ),
                      ),
                    ],
                  )
                ],
                const Spacer(),
                if (status == SubJobConstructionStatus.ASSIGNED || status == SubJobConstructionStatus.SCHEDULED)
                  ButtonWidget(
                    // TODO SET COLOR based on status
                    text: subJob.scheduledStartDate == null && subJob.scheduledEndDate == null ? 'Atur Jadwal' : 'Ubah Jadwal',
                    styleType: ButtonStyleType.fill,
                    fillColor: const Color.fromARGB(0, 255, 255, 255),
                    textColor: AppTheme.blue600,
                    padding: const EdgeInsets.all(0),
                    onPressed: () => Get.toNamed(Routes.scheduleFormSubJobConstruction, arguments: subJob),
                    trailingIcon: const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.blue600),
                  ),
                // GestureDetector(
                //   // go to date setting
                //   onTap: () => Get.toNamed(Routes.scheduleFormSubJobConstruction, arguments: subJob),
                //   child: SizedBox(
                //     child: Row(
                //       children: [
                //         Text(
                //           (subJob.scheduledStartDate == null && subJob.scheduledEndDate == null)
                //               ? 'Atur Jadwal'
                //               : 'Ubah Jadwal',
                //           style: const TextStyle(
                //             fontSize: 12,
                //             color: AppTheme.blue600,
                //           ),
                //         ),
                //         const SizedBox(width: 8),
                //         const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.blue600),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        );
      }

      if (done) {
        return Text(
          // ${subJob.workingEndAt}
          'Tangal selesai: ${DateFormat('d MMMM yyyy, HH:mm').format(subJob.workingEndAt!)} ',
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.secondary250,
          ),
        );
      }

      // SINI

      // if (status == SubJobConstructionStatus.VERIFICATION_SUCCESS) {
      //   return Text(
      //     'Pekerjaan telah diselesaikan pada ${subJob.workingEndAt}',
      //     style: const TextStyle(
      //       fontSize: 12,
      //       color: AppTheme.secondary250,
      //     ),
      //   );
      // } else if (scheduled) {
      //   if (takenByOther) {
      //     return Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         const Text(
      //           "Pengerjaan akan dilakukan oleh petugas lain",
      //           style: TextStyle(
      //             fontSize: 12,
      //             color: AppTheme.secondary250,
      //           ),
      //         ),
      //         const SizedBox(height: 4),
      //         // TODO fix nama teknisi
      //         Text(
      //           'TEKNISI ID: $teknisiId',
      //           style: const TextStyle(
      //             fontSize: 12,
      //             color: AppTheme.secondary800,
      //             fontWeight: FontWeight.w500,
      //           ),
      //         ),
      //       ],
      //     );
      //   } else if (taken) {
      //     return Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         // STATUS TERTUNDA
      //         if (status == SubJobConstructionStatus.PAUSED) ...[
      //           const BadgeWidget(
      //             text: "Pekerjaan Ditunda",
      //             backgroundColor: Color(0xFFEAECF0),
      //             borderColor: Colors.black,
      //             textColor: Colors.black,
      //           ),
      //           const SizedBox(height: 4),
      //           Text(
      //               "sudah ${subJob.lastStartPauseAt != null ? '${DateTime.now().difference(subJob.lastStartPauseAt!).inDays}' : 'N/A'} hari ditunda"),
      //           const SizedBox(height: 4),
      //           GestureDetector(
      //             // go to date setting
      //             onTap: () => controller.resumeSubJobConstruction(subJob.id),
      //             child: const Row(
      //               children: [
      //                 Text(
      //                   'Lanjutkan Pengerjaan',
      //                   style: const TextStyle(
      //                     fontSize: 14,
      //                     color: AppTheme.blue600,
      //                   ),
      //                 ),
      //                 SizedBox(width: 8),
      //                 Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.blue600),
      //               ],
      //             ),
      //           )
      //         ],
      //         if (status != SubJobConstructionStatus.PAUSED)
      //           Row(
      //             children: [
      //               if (subJob.scheduledStartDate == null && subJob.scheduledEndDate == null) ...[
      //                 SvgPicture.asset('assets/icons/ic_calendar.svg'),
      //                 const SizedBox(width: 8),
      //                 const Text(
      //                   'Jadwal pengerjaan belum diatur',
      //                   style: TextStyle(
      //                     fontSize: 12,
      //                     color: AppTheme.secondary250,
      //                   ),
      //                 ),
      //               ],
      //               if (subJob.scheduledStartDate != null && subJob.scheduledEndDate != null)
      //                 Text(
      //                   readAbleSchedule,
      //                   style: const TextStyle(
      //                     fontSize: 12,
      //                     color: AppTheme.secondary250,
      //                   ),
      //                 ),
      //               const Spacer(),
      //               if (status == SubJobConstructionStatus.ASSIGNED || status == SubJobConstructionStatus.SCHEDULED)
      //                 GestureDetector(
      //                   // go to date setting
      //                   onTap: () => Get.toNamed(Routes.scheduleFormSubJobConstruction, arguments: subJob),
      //                   child: Row(
      //                     children: [
      //                       Text(
      //                         (subJob.scheduledStartDate == null && subJob.scheduledEndDate == null)
      //                             ? 'Atur Jadwal'
      //                             : 'Ubah Jadwal',
      //                         style: const TextStyle(
      //                           fontSize: 12,
      //                           color: AppTheme.blue600,
      //                         ),
      //                       ),
      //                       const SizedBox(width: 8),
      //                       const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.blue600),
      //                     ],
      //                   ),
      //                 ),
      //             ],
      //           ),
      //       ],
      //     );
      //   } else {
      //     if (subJob.subTaskTypeName == 'Pipa Instalasi (SK)') {
      //       return const Text(
      //         'Aktivitas ini dapat dikerjakan segera',
      //         style: TextStyle(
      //           fontSize: 12,
      //           color: AppTheme.secondary250,
      //         ),
      //       );
      //     } else if (subJob.subTaskTypeName == 'Pipa Service (SR)') {
      //       return const Text(
      //         'Aktivitas ini dapat dikerjakan segera',
      //         style: TextStyle(
      //           fontSize: 12,
      //           color: AppTheme.secondary250,
      //         ),
      //       );
      //     } else if (subJob.subTaskTypeName == 'Pasang Meter Gas') {
      //       return Text(
      //         // TODO make sure this condition is correct
      //         controller.subJobConstructions[0].status == SubJobConstructionStatus.VERIFICATION_SUCCESS ||
      //                 controller.subJobConstructions[1].status == SubJobConstructionStatus.VERIFICATION_SUCCESS
      //             ? 'Aktivitas ini dapat dikerjakan segera'
      //             : 'Aktivitas ini dapat dikerjakan ketika pekerjaan Pipa Instalasi (SK) atau Pipa Servis (SR) selesai dikerjakan.',
      //         style: const TextStyle(
      //           fontSize: 12,
      //           color: AppTheme.secondary250,
      //         ),
      //       );
      //     } else {
      //       // GAS IN
      //       return Text(
      //         // TODO check this SubJobConstructionStatus.BLOCKING_DEPENDENCY
      //         subJob.status != SubJobConstructionStatus.BLOCKING_DEPENDENCY
      //             ? 'Aktivitas ini dapat dikerjakan segera'
      //             : 'Aktivitas ini dapat dikerjakan ketika pekerjaan Pipa Instalasi (SK), Pipa Servis (SR), dan Pasang Meter Gas selesai dikerjakan.',
      //         style: const TextStyle(
      //           fontSize: 12,
      //           color: AppTheme.secondary250,
      //         ),
      //       );
      //     }
      //   }
      // } else if (taken && !scheduled) {
      //   return Row(
      //     children: [
      //       Expanded(
      //         child: Text(
      //           '${subJob.workingStartAt} - ${subJob.workingEndAt}',
      //           maxLines: 2,
      //           style: const TextStyle(
      //             overflow: TextOverflow.ellipsis,
      //             fontSize: 12,
      //             color: AppTheme.secondary250,
      //           ),
      //         ),
      // ),
      // const Spacer(),
      // GestureDetector(
      //   onTap: () {},
      //   child: const Row(
      //     children: [
      //       Text(
      //         'Ubah Jadwal',
      //         style: TextStyle(
      //           fontSize: 12,
      //           color: AppTheme.blue600,
      //         ),
      //       ),
      //       SizedBox(width: 8),
      //       Icon(Icons.arrow_forward_ios,
      //           size: 16, color: AppTheme.blue600),
      //     ],
      //   ),
      // ),
      // ],
      // );
      // } else {
      //   if (!taken && readAbleSchedule != "") {
      //     return Text(
      //       'Estimasi pengerjaan akan dilaksanakan pada ${subJob.workingStartAt} sampai ${subJob.workingEndAt}.',
      //       style: const TextStyle(
      //         fontSize: 12,
      //         color: AppTheme.secondary250,
      //       ),
      //     );
      //   } else {
      //     return const SizedBox();
      //   }
      // }
      return const SizedBox();
    }();

    return Stack(
      children: [
        // const SizedBox(height: 16),
        Container(
          padding: EdgeInsets.only(left: 24, right: 24, top: subJob.subTaskTypeFullCode == "01-01" ? 10 : 0),
          decoration: BoxDecoration(
            color: done ? AppTheme.green100 : Colors.transparent,
          ),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
              color: done ? const Color(0xFFA8AD00) : const Color(0xFFE0E3E8),
              width: 3.0,
            ))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: subJob.subTaskTypeFullCode == "01-01" ? 2 : 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // DEBUG
                            // "${subJob.subTaskTypeName} ${subJob.subTaskTypeFullCode}",
                            subJob.subTaskTypeName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: taken || subJob.status == SubJobConstructionStatus.WAITING_ASSIGNMENT
                                  ? Colors.black
                                  : const Color(0XFF667085),
                            ),
                          ),
                          if (status != SubJobConstructionStatus.WAITING_ASSIGNMENT)
                            Text(
                              subJob.status != SubJobConstructionStatus.BLOCKING_DEPENDENCY ? subJob.readAbleStatus : "",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.secondary800,
                              ),
                            ),
                        ],
                      ),
                      if (subJob.workingStartAt != null &&
                          subJob.workingEndAt != null &&
                          (taken && status == SubJobConstructionStatus.SCHEDULED)) ...[
                        const SizedBox(height: 8),
                        const BadgeWidget(
                          text: "Jadwal sudah diatur",
                          backgroundColor: Color(0xFFECF9EB),
                          borderColor: Color(0xFF29A11E),
                          textColor: Color(0xFF29A11E),
                        ),
                      ],
                      const SizedBox(height: 8),
                      // Step Description
                      description,

                      if (done) ...[
                        // Container(
                        //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(6),
                        //   ),
                        //   child: Text(
                        //     attachment ?? 'Attachname File Name',
                        //     style: const TextStyle(
                        //       fontSize: 12,
                        //       color: AppTheme.secondary900,
                        //       decoration: TextDecoration.underline,
                        //     ),
                        //   ),
                        // )
                        ButtonWidget(
                          text: "Lihat Data Pekerjaan",
                          styleType: ButtonStyleType.fill,
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.secondary900,
                            decoration: TextDecoration.underline,
                          ),
                          fillColor: Colors.white,
                          padding: const EdgeInsets.only(left: 10),
                          trailingIcon: SvgPicture.asset(
                            'assets/images/svg/chevron-right.svg',
                            // width: 16,
                            height: 16,
                            fit: BoxFit.contain,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.subTaskReport, arguments: {
                              'id': subJob.id,
                              'type': subJob.subTaskTypeName,
                              'finishDate': subJob.workingEndAt,
                            });
                          },
                        ),
                      ],
                      if (done && (subJob.subTaskTypeFullCode == "01-01" || subJob.subTaskTypeFullCode == "01-04")) ...[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Lihat Berita Acara",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.unselected,
                              ),
                            ),
                            ButtonWidget(
                              text: attachment ?? 'Attachment File Name',
                              styleType: ButtonStyleType.fill,
                              textStyle: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.secondary900,
                                decoration: TextDecoration.underline,
                              ),
                              fillColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                              icon: SvgPicture.asset('assets/icons/ic_pdf.svg'),
                            ),
                          ],
                        ),
                      ],

                      // if (true) ...[
                      if (taken &&
                          (status == SubJobConstructionStatus.ASSIGNED ||
                              status == SubJobConstructionStatus.SCHEDULED ||
                              status == SubJobConstructionStatus.WORKING)) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: ButtonWidget(
                                text: 'Tunda',
                                styleType: ButtonStyleType.outline,
                                fillColor: Colors.white,
                                outlineColor: status == SubJobConstructionStatus.ASSIGNED ||
                                        status == SubJobConstructionStatus.SCHEDULED ||
                                        status == SubJobConstructionStatus.WORKING
                                    ? const Color(0xFF0057B8)
                                    : const Color(0xFFA1A1A1),
                                textColor: status == SubJobConstructionStatus.ASSIGNED ||
                                        status == SubJobConstructionStatus.SCHEDULED ||
                                        status == SubJobConstructionStatus.WORKING
                                    ? const Color(0xFF0057B8)
                                    : const Color(0xFFA1A1A1),
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                onPressed: () {
                                  if (status == SubJobConstructionStatus.ASSIGNED ||
                                      status == SubJobConstructionStatus.SCHEDULED ||
                                      status == SubJobConstructionStatus.WORKING) {
                                    Get.toNamed(Routes.holdFormSubJobConstruction, arguments: subJob);
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ButtonWidget(
                                  // TODO SET COLOR based on status
                                  text: 'Kerjakan',
                                  styleType: ButtonStyleType.fill,
                                  fillColor: const Color(0xFF0057B8),
                                  textColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  onPressed: () async {
                                    await controller.startWorking(subJob);
                                  }),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 12),
                      if (subJob.subTaskTypeFullCode != '01-04' && !done) ...[
                        // const SizedBox(height: 12),
                        Container(
                          color: const Color(0xFFE0E3E8),
                          height: 1,
                          width: double.infinity,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // icon container
        Positioned(
          top: subJob.subTaskTypeFullCode == "01-01" ? 10 : 5,
          left: 16,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: done ? const Color(0xFFA8AD00) : AppTheme.border500,
              shape: BoxShape.circle,
              border: Border.all(
                color: done ? const Color(0xFFA8AD00) : AppTheme.border500,
                width: 2.0,
              ),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class SubJobRouteParameterModel {
  int? jobId;
  SubJobConstructionModel? job;
  List<SubJobConstructionModel>? jobs;
  List<ReportFileGroupModel> listReportFileGroup = [];
  TemporaryFormData? formData =
      TemporaryFormData(id: "", name: "", email: "", phone: "", npwp: "", address: "", areaPgn: "", buildingType: "", group: "");

  SubJobRouteParameterModel({
    this.jobId,
    this.job,
    this.jobs,
    this.listReportFileGroup = const [],
    this.formData,
  });

  int? getReportFileGroupId(String nameid) {
    for (var group in listReportFileGroup) {
      if (group.nameid == nameid) {
        return group.id;
      }
    }
    return null;
  }
}

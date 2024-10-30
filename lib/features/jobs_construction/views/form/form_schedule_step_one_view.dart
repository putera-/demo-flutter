import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pgnpartner_mobile/core/widgets/badge_widget.dart';
import 'package:pgnpartner_mobile/core/widgets/card_wrapper_widget.dart';
import 'package:pgnpartner_mobile/core/widgets/info_card.dart';

class FormScheduleStepOneView extends StatelessWidget {
  const FormScheduleStepOneView({
    super.key,
    required this.scheduledStartDate,
    required this.scheduledEndDate,
  });

  final String scheduledStartDate;
  final String scheduledEndDate;

  @override
  Widget build(BuildContext context) {
    return CardWrapperWidget(
      title: 'Status Tanggal\nPengerjaan',
      badge: const BadgeWidget(
        text: 'Sudah Diatur',
        textColor: Color(0xFF29A11E),
        borderColor: Color(0xFF29A11E),
        backgroundColor: Color(0xFFECF9EB),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/icons/ic_notepad.svg'),
                  const SizedBox(width: 4),
                  const Text("Mulai dari"),
                ],
              ),
              Text(
                DateFormat('d MMMM yyyy').format(DateTime.parse(scheduledStartDate)),
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/icons/ic_notepad.svg'),
                  const SizedBox(width: 4),
                  const Text("Sampai"),
                ],
              ),
              Text(
                DateFormat('d MMMM yyyy').format(DateTime.parse(scheduledEndDate)),
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: 24),
          const InfoCard(
            text:
                'Jika saat ini Anda sedang bersama pelanggan pada tanggal tertera di atas, silakan teruskan pekerjaan Anda.',
            borderColor: Color(0xFF1174CD),
            backgroundColor: Color(0xFFE7F1FA),
            icon: Icon(
              Icons.info,
              color: Color(0xFF1174CD),
            ),
          ),
        ],
      ),
    );
  }
}

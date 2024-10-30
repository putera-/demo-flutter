import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';

class SubTaskReportCard extends StatelessWidget {
  final String title;
  final bool isHeader;
  final String? headerIcon;
  final Widget body;

  const SubTaskReportCard({super.key, required this.title, this.isHeader = false, this.headerIcon, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: AppTheme.border300),
          boxShadow: const [
            BoxShadow(
              color: AppTheme.shadow,
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isHeader)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(color: AppTheme.blue200, shape: BoxShape.circle),
                          child: SvgPicture.asset(headerIcon ?? '', height: 24, width: 24, fit: BoxFit.scaleDown),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.secondary800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                            decoration: BoxDecoration(
                              color: AppTheme.green50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppTheme.green500,
                              ),
                            ),
                            child: const Text(
                              'Selesai',
                              style: TextStyle(
                                color: AppTheme.green500,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              if (!isHeader)
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.secondary800,
                  ),
                ),
              const SizedBox(height: 16),
              if (isHeader) _buildDashedDivider(),
              if (!isHeader) const Divider(height: 1, color: AppTheme.secondary200),
              const SizedBox(height: 16),
              body
            ],
          ),
        ),
      ),
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

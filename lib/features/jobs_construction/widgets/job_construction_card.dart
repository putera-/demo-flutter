import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/utils/shimmer_extension.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/job_construction_model.dart';

class JobConstructionCard extends StatelessWidget {
  final JobConstructionModel job;
  final bool? shimmer;
  final String? spk;
  final VoidCallback? onTapSPK;
  final VoidCallback? onTap;

  const JobConstructionCard({
    super.key,
    required this.job,
    this.shimmer,
    this.spk,
    this.onTapSPK,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadowColor: AppTheme.shadow,
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            // add box shadow & border
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 4,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: AppTheme.green400,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    job.taskTypeName ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.secondary800,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ).shimmer(shimmer!),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                                  decoration: BoxDecoration(
                                    color: AppTheme.orange100,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppTheme.orange500,
                                    ),
                                  ),
                                  child: const Text(
                                    'Baru',
                                    style: TextStyle(
                                      color: AppTheme.orange700,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ).shimmer(shimmer!),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                job.createdAt ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: AppTheme.secondary800,
                                ),
                              ),
                            ).shimmer(shimmer!),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.background,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/ic_location3.svg',
                            width: 13.75,
                            height: 17.5,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              job.customer?.address ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.secondary250,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ).shimmer(shimmer!),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Nama Pelanggan',
                                  style: TextStyle(
                                    color: AppTheme.secondary250,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ).shimmer(shimmer!),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  job.customer?.fullname ?? "",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.secondary800,
                                  ),
                                ),
                              ).shimmer(shimmer!),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'ID Pelanggan',
                                  style: TextStyle(
                                    color: AppTheme.secondary250,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ).shimmer(shimmer!),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  job.customer?.customerNumber ?? "",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.secondary800,
                                  ),
                                ),
                              ).shimmer(shimmer!),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // add condition if job has an spk
                    if (spk != null) ...[
                      const SizedBox(height: 10),
                      const Divider(color: AppTheme.border300, thickness: 1),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'SPK Terlampir',
                              style: TextStyle(
                                color: AppTheme.secondary250,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ).shimmer(shimmer!),
                          GestureDetector(
                            onTap: onTapSPK,
                            child: Row(
                              children: [
                                Text(
                                  spk!,
                                  style: const TextStyle(
                                    color: AppTheme.blue400,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SvgPicture.asset(
                                  'assets/icons/ic_arrow_up_right.svg',
                                  width: 9,
                                  height: 9,
                                ),
                              ],
                            ).shimmer(shimmer!),
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

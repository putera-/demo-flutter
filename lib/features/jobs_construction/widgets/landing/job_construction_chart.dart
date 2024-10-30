import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/config/routes.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/utils/color_extensions.dart';
import 'package:pgnpartner_mobile/core/widgets/card_wrapper_widget.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/sub_job_construction_report.dart';

class JobConstructionChart extends StatelessWidget {
  const JobConstructionChart({
    super.key,
    this.report,
  });

  final SubJobConstructionReport? report;

  @override
  Widget build(BuildContext context) {
    int maxValue = [
      report?.totalSubTaskSk ?? 0,
      report?.totalSubTaskSr ?? 0,
      report?.totalSubTaskMeterInstallation ?? 0,
      report?.totalSubTaskGasIn ?? 0
    ].reduce((a, b) => a > b ? a : b);

    double scaleFactor = maxValue <= 10 ? 10 : maxValue.toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CardWrapperWidget(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Total Aktivitas Anda',
                style: TextStyle(
                  color: AppTheme.unselected,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/ic_trand_up.svg'),
                  const SizedBox(width: 8),
                  Text(
                    ((report?.totalSubTaskSk ?? 0) +
                            (report?.totalSubTaskSr ?? 0) +
                            (report?.totalSubTaskMeterInstallation ?? 0) +
                            (report?.totalSubTaskGasIn ?? 0))
                        .toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 230,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: scaleFactor,
                    barGroups: [
                      _makeGroupData(
                        0,
                        (report?.totalSubTaskSk ?? 0) / (scaleFactor / 10).toDouble(),
                        HexColor('#FFA847'),
                      ),
                      _makeGroupData(
                        1,
                        (report?.totalSubTaskSr ?? 0) / (scaleFactor / 10).toDouble(),
                        HexColor('#672BC4'),
                      ),
                      _makeGroupData(
                        2,
                        (report?.totalSubTaskMeterInstallation ?? 0) / (scaleFactor / 10).toDouble(),
                        HexColor('#00B3B8'),
                      ),
                      _makeGroupData(
                        3,
                        (report?.totalSubTaskGasIn ?? 0) / (scaleFactor / 10).toDouble(),
                        HexColor('#A8AD00'),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 70,
                          getTitlesWidget: (value, meta) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  _getValue(value).toString(),
                                  style: TextStyle(
                                    color: HexColor('#1D2939'),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  _getLabel(value),
                                  style: const TextStyle(
                                    color: AppTheme.secondary300,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    gridData: const FlGridData(
                      show: true,
                      drawVerticalLine: false,
                    ),
                    borderData: FlBorderData(show: false),
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            (rod.toY * (scaleFactor / 10)).round().toString(),
                            const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.availableJobConstruction);
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Ambil Pekerjaan',
                        style: TextStyle(
                          color: AppTheme.primary,
                        ),
                      ),
                      SvgPicture.asset('assets/icons/ic_cheveron_right.svg'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 40,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ],
    );
  }

  int _getValue(double value) {
    switch (value.toInt()) {
      case 0:
        return report?.totalSubTaskSk ?? 0;
      case 1:
        return report?.totalSubTaskSr ?? 0;
      case 2:
        return report?.totalSubTaskMeterInstallation ?? 0;
      case 3:
        return report?.totalSubTaskGasIn ?? 0;
      default:
        return 0;
    }
  }

  String _getLabel(double value) {
    switch (value.toInt()) {
      case 0:
        return 'Pipa\nInstalasi';
      case 1:
        return 'Pipa\nServis';
      case 2:
        return 'Pasang\nMeter Gas';
      case 3:
        return 'Gas In';
      default:
        return '';
    }
  }
}

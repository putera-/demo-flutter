import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/utils/color_extensions.dart';
import 'package:pgnpartner_mobile/core/widgets/app_bar_general.dart';
import 'package:pgnpartner_mobile/core/widgets/button_widget.dart';

class JobSearchView extends StatelessWidget {
  const JobSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic parentController = Get.arguments;
    return Scaffold(
      appBar: AppBarGeneral(
        title: "Search",
        withLeading: false,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/svg/x.svg',
              width: 21,
              height: 21,
              fit: BoxFit.contain,
            ),
            onPressed: () {
              Navigator.pop(context);
              reset(parentController);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white950,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: AppTheme.border500,
                    ),
                  ),
                  child: TextField(
                    // controller: controller.searchController,
                    controller: parentController.searchController,
                    style: const TextStyle(
                      color: AppTheme.secondary800,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Cari ID atau Nama Pelanggan',
                      hintStyle: const TextStyle(
                        color: AppTheme.secondary250,
                      ),
                      prefixIcon: SizedBox(
                        height: 21,
                        width: 21,
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/svg/ic_magnifying_glass.svg',
                            width: 21,
                            height: 21,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/ic_x_circle.svg',
                          width: 21,
                          height: 21,
                          fit: BoxFit.contain,
                        ),
                        onPressed: () {
                          reset(parentController);
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pencarian Sebelumnya',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 0,
                      // itemCount: controller.recentSearch.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/ic_clock.svg',
                                width: 16,
                                height: 16,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "TEST",
                                // controller.recentSearch[index].toUpperCase(),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: HexColor('#667085')),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFE0E3E8),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Semua Area',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 0,
                        // itemCount: controller.recentArea.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_map_pin.svg',
                                  width: 16,
                                  height: 16,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'TEST',
                                  // controller.recentArea[index].toUpperCase(),
                                  style:
                                      TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: HexColor('#667085')),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Color(0xFFEAECF0),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  onPressed: () {
                    reset(parentController);
                    parentController.search();
                    Get.back();
                  },
                  text: "Reset",
                  textColor: AppTheme.primary,
                  styleType: ButtonStyleType.outline,
                  fillColor: AppTheme.white950,
                  outlineColor: AppTheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ButtonWidget(
                  onPressed: () {
                    parentController.search();
                    Get.back();
                  },
                  text: "Terapkan",
                  styleType: ButtonStyleType.fill,
                  fillColor: AppTheme.primary,
                  textColor: AppTheme.white950,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              )
            ],
          )),
    );
  }

  void reset(dynamic thisController) {
    thisController.searchQuery.value = '';
    thisController.searchController.clear();
  }
}

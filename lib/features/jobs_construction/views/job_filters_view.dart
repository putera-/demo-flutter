import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/core/bottom_sheets/list_check_box/bottom_sheet_list_checkbox_controller.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/widgets/app_bar_general.dart';
import 'package:pgnpartner_mobile/core/widgets/button_widget.dart';
import 'package:pgnpartner_mobile/core/widgets/check_box_cell.dart';
import 'package:pgnpartner_mobile/core/widgets/multiple_selector_with_badge_style.dart';
import 'package:pgnpartner_mobile/core/widgets/tab_multiple_selector_with_badge_style.dart';
import 'package:pgnpartner_mobile/data/models/location/location_model.dart';
import 'package:pgnpartner_mobile/features/jobs_construction/controllers/filter_controller.dart';

class JobFilters extends GetView<FilterController> {
  const JobFilters({super.key});

  @override
  Widget build(BuildContext context) {
    controller.resetFilterArea();
    return Scaffold(
      appBar: AppBarGeneral(
        title: "Filter and Short",
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
              Get.back();
              // Navigator.pop(context);
              // reset(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sort",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      MultipleSelectorWithBadgeStyle(
                        title: "Pilih Urutan",
                        subtitle: "Urutkan",
                        placeholder: "Pilih urutan berdasarkan",
                        sheetTitle: "Urutkan berdasarkan",
                        controller: controller.sortOptionController,
                        isSorted: controller.isSorted.value,
                        optionItems: controller.sortOptions,
                        onSelectorClose: () {
                          controller.isSorted.value = controller.sortOptionController.selectedItems.isNotEmpty;
                        },
                        onRemoveSelectedItem: (item) {
                          controller.removeSortItem(item);
                        },
                        onUbah: () => controller.resetSort(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFE0E3E8),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Filter",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Pilih Area",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Obx(() => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.kabupatenOptions.length,
                          // itemCount: 0,
                          itemBuilder: (context, index) {
                            KabupatenModel item = controller.kabupatenOptions[index];
                            return Obx(() {
                              return Column(
                                children: [
                                  CheckBoxCell<String>(
                                    item: item.name,
                                    value: controller.isKabupatenSelected(item.code),
                                    itemToString: (item) => item,
                                    onChanged: (bool? value) {
                                      controller.toggleKabupatenSelection(item);
                                    },
                                  ),
                                  if (controller.isKabupatenSelected(item.code))
                                    TabMultipleSelectorWithBadgeStyle(
                                      title: "",
                                      subtitle: "",
                                      placeholder: "Pilih Kecamatan dan Kelurahan",
                                      sheetTitle: "Kecamatan dan Kelurahan",
                                      controller: controller.kabupatenControllers[item.code]!,
                                      kecamatanController: controller.kecamatanControllers[item.code] ??=
                                          BottomSheetListCheckBoxController<String>(),
                                      isSorted: controller.kabupatenControllers[item.code]!.selectedItems.isNotEmpty,
                                      // kabupaten: item,
                                      parentItems: item.kecamatans!.map((e) => e.name).toList(),
                                      childItems: (kecamatan) => item.kecamatans
                                          .firstWhere((e) => e.name == kecamatan)
                                          .kelurahans
                                          .map((e) => e.name)
                                          .toList(),
                                      onSelectorClose: () {},
                                      onRemoveSelectedItem: (kelurahan) {
                                        controller.removeAreaItem(item.code, kelurahan);
                                      },
                                      onUbah: () => controller.resetSortArea(item.code),
                                    ),
                                  // }),
                                ],
                              );
                            });
                          },
                        )),
                    const SizedBox(height: 66),
                    Obx(() => MultipleSelectorWithBadgeStyle(
                          title: "Pilih Jenis Pekerjaan",
                          subtitle: "Pilih Pekerjaan",
                          placeholder: "Pilih jenis pekerjaan",
                          sheetTitle: "Jenis Pekerjaan",
                          controller: controller.jobTypeController,
                          isSorted: controller.isSelectedJobtype.value,
                          optionItems: controller.jobTypeOptions,
                          onSelectorClose: () {
                            controller.isSelectedJobtype.value = controller.jobTypeController.selectedItems.isNotEmpty;
                          },
                          onRemoveSelectedItem: (item) {
                            controller.removeJobTypeItem(item);
                          },
                          onUbah: () => controller.resetJobType(),
                        )),
                  ],
                ),
              ),
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
                    reset();
                    // Get.back();
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
                    // controller.isfiltered.value = true;
                    // controller.applyFilters();
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

  void reset() {
    controller.resetAll();
    //   controller.isfiltered.value = false;
    //   controller.filterController.selectedValue.value = null;
    //   controller.sortController.selectedValue.value = null;
    // controller.provinceControllers.forEach((key, value) {
    //   value.selectedItems.clear();
    // });
    //   controller.kecamatanControllers.forEach((key, value) {
    //     value.selectedItems.clear();
    //   });
    //   controller.selectedAreas.clear();
    //   controller.fetchJobs(context);
  }
}

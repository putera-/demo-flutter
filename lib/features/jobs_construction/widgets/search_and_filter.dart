import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';

class SearchAndFilter<T extends GetxController> extends GetView<T> {
  final Function() onPressFilter;
  final Function() onPressSearch;
  final TextEditingController searchController;
  final Rx<bool> isfiltered;

  const SearchAndFilter({
    super.key,
    required this.onPressFilter,
    required this.onPressSearch,
    required this.searchController,
    required this.isfiltered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onPressSearch,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.white950,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppTheme.border500,
                      ),
                    ),
                    child: TextField(
                      enabled: false,
                      controller: searchController,
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
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        isDense: true,
                      ),
                      // onChanged: onSearch,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Obx(() => ElevatedButton(
                    onPressed: onPressFilter,
                    style: ButtonStyle(
                      backgroundColor: isfiltered.value
                          ? WidgetStateProperty.all(AppTheme.primary)
                          : WidgetStateProperty.all(AppTheme.border300),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      padding: WidgetStateProperty.all(const EdgeInsets.all(14)),
                      elevation: WidgetStateProperty.all(0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          isfiltered.value
                              ? 'assets/images/svg/setting-white.svg'
                              : 'assets/images/svg/setting-black.svg',
                          width: 18,
                          height: 18,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: isfiltered.value ? 22 : 42,
                          height: 22,
                          decoration: isfiltered.value
                              ? const BoxDecoration(
                                  color: AppTheme.border300,
                                  shape: BoxShape.circle,
                                )
                              : const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                          child: Center(
                            child: Text(
                              isfiltered.value ? "1" : "Filter",
                              style: const TextStyle(
                                color: AppTheme.secondary800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

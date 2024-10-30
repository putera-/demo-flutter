import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchJob extends StatelessWidget {
  final Function() onPressSearch;
  final TextEditingController searchController;

  const SearchJob({
    super.key,
    required this.onPressSearch,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onPressSearch,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                ),
                child: TextField(
                  enabled: false,
                  controller: searchController,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: 'Cari ID atau Nama Pelanggan',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

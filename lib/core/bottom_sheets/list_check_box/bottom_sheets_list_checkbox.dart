import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/core/bottom_sheets/list_check_box/bottom_sheet_list_checkbox_controller.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/widgets/button_widget.dart';
import 'package:pgnpartner_mobile/core/widgets/check_box_cell.dart';

void showBottomSheetListCheckBox<T>({
  required BuildContext context,
  required String title,
  required List<T> items,
  required BottomSheetListCheckBoxController<T> controller,
  required String Function(T item) itemToString,
  required VoidCallback onSavePressed,
  required VoidCallback onClose,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16.0),
      ),
    ),
    builder: (BuildContext context) {
      return PopScope(
        onPopInvoked: (didPop) {
          if (didPop) {
            onClose();
          }
          return;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 5,
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFCDCFD0),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFEAECF0),
                  ),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final item = items[index];
                return Obx(() => CheckBoxCell<T>(
                      item: item,
                      value: controller.isSelected(item),
                      itemToString: itemToString,
                      onChanged: (bool? value) {
                        controller.toggleItem(item);
                      },
                    ));
              },
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: ButtonWidget(
                onPressed: () {
                  onSavePressed();
                  Navigator.pop(context);
                },
                text: "Simpan",
                styleType: ButtonStyleType.fill,
                fillColor: AppTheme.primary,
                textColor: AppTheme.white950,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ],
        ),
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/widgets/button_widget.dart';

class GeneralDialog {
  static void show({
    Widget? image,
    String? title,
    String? description,
    String? primaryButtonText,
    Color? primaryButtonColor,
    Widget? trailingIconPrimary,
    VoidCallback? onTapPrimary,
    String? secondaryButtonText,
    VoidCallback? onTapSecondary,
    EdgeInsets? screenPadding, // Padding between content and background screen
    EdgeInsets? contentPadding, // Padding inside the dialog for content
    Color? backgroundColor, // Background color parameter
  }) {
    List<Widget> dialogContent = [];

    if (image != null) {
      dialogContent.add(image);
      dialogContent.add(const SizedBox(height: 8));
    }

    if (title != null) {
      dialogContent.add(
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
      dialogContent.add(const SizedBox(height: 8));
    }

    if (description != null) {
      dialogContent.add(
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            description,
            style: const TextStyle(
              color: Color(0xFF667085),
              height: 20 / 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
      dialogContent.add(const SizedBox(height: 24));
    }

    if (primaryButtonText != null && onTapPrimary != null) {
      dialogContent.add(
        SizedBox(
          width: double.infinity,
          child: ButtonWidget(
            text: primaryButtonText,
            styleType: ButtonStyleType.fill,
            fillColor: primaryButtonColor ?? AppTheme.primary,
            textColor: AppTheme.white950,
            padding: const EdgeInsets.symmetric(vertical: 10),
            onPressed: onTapPrimary,
            trailingIcon: trailingIconPrimary,
          ),
        ),
      );
    }

    if (secondaryButtonText != null && onTapSecondary != null) {
      dialogContent.add(
        SizedBox(
          width: double.infinity,
          child: ButtonWidget(
            text: secondaryButtonText,
            styleType: ButtonStyleType.outline,
            fillColor: AppTheme.white950,
            outlineColor: AppTheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 10),
            onPressed: onTapSecondary,
          ),
        ),
      );
    }

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: screenPadding ?? const EdgeInsets.all(16),
        child: Container(
          padding: contentPadding ?? const EdgeInsets.fromLTRB(16, 24, 16, 12),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: dialogContent,
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  static void showLoadingDialog({
    String? title,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  color: AppTheme.primary,
                  strokeWidth: 2,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title ?? "Memeriksa ...",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}

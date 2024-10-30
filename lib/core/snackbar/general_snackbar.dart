import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralSnackbar {
  static void show({
    required String message,
    Widget? closeIcon,
    Duration duration = const Duration(seconds: 3),
    EdgeInsets? margin,
    Color backgroundColor = const Color(0xFFE6333C),
    Color textColor = Colors.white,
    double borderRadius = 8.0,
  }) {
    Get.rawSnackbar(
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: textColor),
            ),
          ),
          if (closeIcon != null)
            GestureDetector(
              onTap: () {
                Get.back(); // Close snackbar on tap
              },
              child: closeIcon,
            ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      snackPosition: SnackPosition.BOTTOM,
      margin: margin ?? EdgeInsets.only(left: 16, right: 16, bottom: Get.height - 150),
      borderRadius: borderRadius,
      isDismissible: false,
      dismissDirection: DismissDirection.horizontal,
      barBlur: 20, // Optional for a blurred background effect
    );
  }
}

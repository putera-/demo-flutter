import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

extension ShimmerExtension on Widget {
  Widget shimmer(bool enabled, {Color? baseColor, Color? highlightColor}) {
    if (!enabled) return this;

    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey[300]!,
      highlightColor: highlightColor ?? Colors.grey[100]!,
      child: this,
    );
  }
}

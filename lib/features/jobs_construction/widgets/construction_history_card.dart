import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pgnpartner_mobile/core/themes/app_theme.dart';
import 'package:pgnpartner_mobile/core/widgets/card_shadow_widget.dart';

class ConstructionHistoryCard extends StatelessWidget {
  final String icon;
  final Color iconBackgroundColor;
  final int total;
  final String title;
  final VoidCallback? onTap;

  const ConstructionHistoryCard({
    super.key,
    required this.icon,
    required this.iconBackgroundColor,
    required this.total,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CardShadowWidget(
        width: 140,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: iconBackgroundColor,
                  radius: 14,
                  child: SvgPicture.asset(icon),
                ),
                const SizedBox(width: 8),
                Text(
                  total.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppTheme.unselected),
            )
          ],
        ),
      ),
    );
  }
}

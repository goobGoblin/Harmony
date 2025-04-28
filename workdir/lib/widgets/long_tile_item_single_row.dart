// lib/widgets/long_tile_item_single_row.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/theme.dart'; // AppFontStyles, AppColors

class LongTileItemSingleRow extends StatelessWidget {
  final String title;
  final double containerWidth;
  final double containerHeight;

  const LongTileItemSingleRow({
    Key? key,
    required this.title,
    required this.containerWidth,
    required this.containerHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dynamic sizing based on containerHeight
    final double borderRadius = containerHeight * 0.2;
    final double horizontalPadding = containerHeight * 0.18;
    final double fontSize = containerHeight * 0.5;
    return Opacity(
      opacity: 0.90,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: ShapeDecoration(
          color: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: AppFontStyles.entrySubtitle.copyWith(
                fontSize: fontSize,
                color: AppColors.text,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

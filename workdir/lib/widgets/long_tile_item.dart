// lib/widgets/long_tile_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/theme.dart'; // Import your theme for fonts and colors


class LongTileItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final ImageProvider imageProvider;
  final double containerWidth;
  final double containerHeight;

  const LongTileItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageProvider,
    required this.containerWidth,
    required this.containerHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define proportions relative to containerHeight
    final double imageSize = containerHeight * 0.74;
    final double padding = containerHeight * 0.14;
    final double textOffsetTop = containerHeight * 0.17;
    final double subtitleOffsetTop = containerHeight * 0.52;
    final double textSpacing = containerWidth * 0.03;
    final double textAvailableWidth = containerWidth - (padding * 2 + imageSize + textSpacing);

    return Opacity(
      opacity: 0.90,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.primary, // Using your defined secondary color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(containerHeight * 0.2),
          ),
        ),
        child: Stack(
          children: [
            // Image
            Positioned(
              left: padding,
              top: padding,
              child: Container(
                width: imageSize,
                height: imageSize,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(containerHeight * 0.1),
                  ),
                ),
              ),
            ),
            // Title
            Positioned(
              left: padding + imageSize + textSpacing,
              top: textOffsetTop,
              child: SizedBox(
                width: textAvailableWidth,
                child: Text(
                  title,
                  style: AppFontStyles.entryTitle.copyWith( // Using your AppFontStyles
                    fontSize: containerHeight * 0.26,
                    color: AppColors.text, // Universal text color
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // Subtitle
            Positioned(
              left: padding + imageSize + textSpacing,
              top: subtitleOffsetTop,
              child: SizedBox(
                width: textAvailableWidth,
                child: Text(
                  subtitle,
                  style: AppFontStyles.entrySubtitle.copyWith(
                    fontSize: containerHeight * 0.24,
                    color: AppColors.text, 
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

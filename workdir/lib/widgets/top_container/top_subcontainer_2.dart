// lib/widgets/top_subcontainer_2.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_application_1/constants/constants.dart'; 

class TopSubcontainer2 extends StatelessWidget {
  const TopSubcontainer2({
    Key? key,
    required this.containerSize,
    this.backgroundOpacity = 0.7,
  }) : super(key: key);

  final double containerSize;
  final double backgroundOpacity;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final dimensions = AppDimensions.getScreenBasedDimensions(screenSize);

    final tileWidth = containerSize; // Full width of container
    final tileHeight = containerSize * 0.215; // 21.5% of container height
    final tileSpacing = containerSize * 0.024; // 2.4% gap between tiles
    final leftPadding = containerSize * 0.038; // 3.8% for text shift to the right

    return TopSubcontainerBase(
      containerSize: containerSize,
      backgroundImagePath: 'assets/images/backgrounds/topSubcontainer2BG.png',
      backgroundOpacity: backgroundOpacity,
      child: Container(
        width: containerSize * 0.9,
        height: containerSize,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Stack(
          children: [
            // First tile (bottom)
            Positioned(
              left: 0.05 * tileWidth,
              top: containerSize - tileHeight, // Bottom
              child: LongTileItemSingleRow(
                title: 'Track Library',
                containerWidth: tileWidth * 0.9,
                containerHeight: tileHeight,
              ),
            ),
            // Second tile
            Positioned(
              left: 0.05 * tileWidth,
              top: containerSize - (tileHeight * 2 + tileSpacing),
              child: LongTileItemSingleRow(
                title: 'Liked Playlists',
                containerWidth: tileWidth * 0.9,
                containerHeight: tileHeight,
              ),
            ),
            // Third tile
            Positioned(
              left: 0.05 * tileWidth,
              top: containerSize - (tileHeight * 3 + tileSpacing * 2),
              child: LongTileItemSingleRow(
                title: 'Your Playlists',
                containerWidth: tileWidth * 0.9,
                containerHeight: tileHeight,
              ),
            ),
            // Fourth tile (topmost)
            Positioned(
              left: 0.05 * tileWidth,
              top: containerSize - (tileHeight * 4 + tileSpacing * 3),
              child: LongTileItemSingleRow(
                title: 'Smart Playlists',
                containerWidth: tileWidth * 0.9,
                containerHeight: tileHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

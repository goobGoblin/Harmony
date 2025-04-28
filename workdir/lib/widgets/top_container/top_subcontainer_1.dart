// lib/widgets/top_subcontainer_1.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_application_1/constants/constants.dart'; 


class TopSubcontainer1 extends StatelessWidget {
  const TopSubcontainer1({
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

    final tileHeight = containerSize * 0.25; // Each tile is 25% of container height
    final tileSpacing = containerSize * 0.04; // 4% spacing between tiles
    final assetImage = const AssetImage('assets/images/placeholders/profilePicPlaceholder.jpeg');

    return TopSubcontainerBase(
      containerSize: containerSize,
      backgroundImagePath: 'assets/images/backgrounds/topSubcontainer1BG.png',
      backgroundOpacity: backgroundOpacity,
      child: Padding(
        padding: EdgeInsets.all(tileSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LongTileItem(
              title: 'Heavy Rotation',
              subtitle: 'Playlist',
              imageProvider: assetImage,
              containerWidth: containerSize - (containerSize * 0.08), // account for padding
              containerHeight: tileHeight,
            ),
            SizedBox(height: tileSpacing),
            LongTileItem(
              title: 'Listening History',
              subtitle: 'Collection',
              imageProvider: assetImage,
              containerWidth: containerSize - (containerSize * 0.08),
              containerHeight: tileHeight,
            ),
            SizedBox(height: tileSpacing),
            LongTileItem(
              title: 'Liked Songs',
              subtitle: 'Collection',
              imageProvider: assetImage,
              containerWidth: containerSize - (containerSize * 0.08),
              containerHeight: tileHeight,
            ),
          ],
        ),
      ),
    );
  }
}

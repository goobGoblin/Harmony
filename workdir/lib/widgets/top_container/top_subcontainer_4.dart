// lib/widgets/top_subcontainer_4.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/theme/theme.dart';

class TopSubcontainer4 extends StatelessWidget {
  const TopSubcontainer4({
    Key? key,
    required this.containerSize,
    this.backgroundOpacity = 0.7,
    this.onTap,
  }) : super(key: key);

  final double containerSize;
  final double backgroundOpacity;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TopSubcontainerBase(
        containerSize: containerSize,
        backgroundImagePath: 'assets/images/backgrounds/topSubcontainer4BG.png',
        backgroundOpacity: backgroundOpacity,
        child: Center(
          child: AppIcon(
            icon: IconAsset.settings,
            size: IconSize.big,
            color: Colors.white,
            filled: false,
          ),
        ),
      ),
    );
  }
}

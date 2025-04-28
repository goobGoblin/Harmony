// lib/widgets/top_subcontainer_base.dart
// Base class for all subcontainers with common functionality

import 'package:flutter/material.dart';

class TopSubcontainerBase extends StatelessWidget {
  const TopSubcontainerBase({
    Key? key,
    required this.containerSize,
    required this.backgroundImagePath,
    this.backgroundOpacity = 0.7,
    this.child,
  }) : super(key: key);

  final double containerSize;
  final String backgroundImagePath;
  final double backgroundOpacity;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background container with decoration
        Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImagePath),
              fit: BoxFit.cover,
              opacity: backgroundOpacity,
            ),
          ),
        ),
        
        // Child content if provided
        if (child != null)
          SizedBox(
            width: containerSize,
            height: containerSize,
            child: child,
          ),
      ],
    );
  }
}


// lib/widgets/top_subcontainer_2.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/top_subcontainer_base.dart';

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
    return TopSubcontainerBase(
      containerSize: containerSize,
      backgroundImagePath: 'assets/images/backgrounds/topSubcontainer2BG.png',
      backgroundOpacity: backgroundOpacity,
      child: Center(
        child: Text(
          '2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


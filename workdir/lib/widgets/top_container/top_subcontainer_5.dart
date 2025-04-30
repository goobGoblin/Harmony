// lib/widgets/top_subcontainer_5.dart - updated with height parameter
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/widgets.dart';

class TopSubcontainer5 extends StatelessWidget {
  const TopSubcontainer5({
    Key? key,
    required this.containerSize,
    required this.height, // Different height parameter
    this.backgroundOpacity = 0.7,
  }) : super(key: key);

  final double containerSize;
  final double height; // Container has width of containerSize but custom height
  final double backgroundOpacity;

  @override
  Widget build(BuildContext context) {
    // Custom container that has different width and height
    return Container(
      width: containerSize,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/backgrounds/topSubcontainer4BG.png'),
          fit: BoxFit.cover,
          opacity: backgroundOpacity,
        ),
      ),
      child: Center(
        child: Text(
          '5',
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

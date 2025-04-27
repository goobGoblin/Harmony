// lib/theme/app_dimensions.dart

import 'package:flutter/material.dart';

class AppDimensions {
  // Golden ratio constants
  static const double goldenRatio = 1.618033988749895;
  static const double inverseGoldenRatio = 0.618033988749895;
  
  // Method to calculate dimensions based on screen size
  static Map<String, double> getScreenBasedDimensions(Size screenSize) {

    final goldenRatio = 1.618033988749895;
    // Top container dimensions
    final topContainerWidth = screenSize.width;
    final topContainerHeight = screenSize.width / goldenRatio;
    
    // Golden ratio-based dimensions
    final gr_top1 = screenSize.width / goldenRatio;
    final gr_top2 = gr_top1 / goldenRatio;
    final gr_top3 = gr_top2 / goldenRatio;
    final gr_top4 = gr_top3 / goldenRatio;
    final gr_top5 = gr_top4 / goldenRatio;
    
    // Logo dimensions
    final logoWidth = screenSize.width * 1.35;
    final logoHeight = screenSize.height / goldenRatio;
    final logoX = (screenSize.width / logoWidth) + (logoHeight*0.08);
    final logoNegX = -1 * (screenSize.width - logoX);
    final logoY = gr_top1 - (screenSize.height * 0.08);
    final stretchedLogoShift = logoX * -0.08;
    
    // Sidebar dimensions
    final sbOffsetX = logoX * 0.2;
    final sbOffsetY = logoHeight * 0.15;
    final sbHeight = (logoHeight) / goldenRatio;
    final sbY = gr_top1 - (gr_top4*0.85) + ((logoHeight - sbHeight) / goldenRatio); 
    final sbWidth = logoX; 

    return {
      'goldenRatio': goldenRatio,
      'inverseGoldenRatio': inverseGoldenRatio,
      'topContainerWidth': topContainerWidth,
      'topContainerHeight': topContainerHeight,
      'gr_top1': gr_top1,
      'gr_top2': gr_top2,
      'gr_top3': gr_top3,
      'gr_top4': gr_top4,
      'gr_top5': gr_top5,
      'logoWidth': logoWidth,
      'logoHeight': logoHeight,
      'logoX': logoX,
      'logoNegX': logoNegX,
      'logoY': logoY,
      'stretchedLogoShift': stretchedLogoShift,
      'sbOffsetX': sbOffsetX,
      'sbOffsetY': sbOffsetY,
      'sbY': sbY,
      'sbHeight': sbHeight,
      'sbWidth': sbWidth,

    };
  }
}

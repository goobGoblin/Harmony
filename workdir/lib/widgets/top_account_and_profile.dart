// lib/widgets/top_account_and_profile.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_application_1/widgets/widgets.dart';

enum ProfileDisplayMode {
  account,
  profile
}

class TopAccountAndProfile extends StatelessWidget {
  const TopAccountAndProfile({
    Key? key,
    required this.containerSize,
    this.displayMode = ProfileDisplayMode.account,
  }) : super(key: key);

  final double containerSize;
  final ProfileDisplayMode displayMode;

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;
    
    // Get dimensions using the helper method
    final dimensions = AppDimensions.getScreenBasedDimensions(screenSize);
    
    // Determine the text to display based on the mode
    final String displayText = displayMode == ProfileDisplayMode.account 
        ? 'account' 
        : 'profile';
    
    return Column(
      children: [
        // Top section with centered text (larger portion by golden ratio)
        Container(
          height: containerSize - (containerSize / dimensions['goldenRatio']!),
          child: Center(
            child: Text(
              displayText,
              style: AppFontStyles.entryTitle.copyWith(
                color: Colors.white,
                letterSpacing: 0.42,
              ),
            ),
          ),
        ),
        
        // Bottom section with profile pic and icon using golden ratio
        Container(
          height: containerSize / dimensions['goldenRatio']!,
          child: Row(
            children: [
              // Left section: Profile picture in a golden ratio square
              Container(
                width: containerSize / dimensions['goldenRatio']!,
                height: containerSize / dimensions['goldenRatio']!,
                child: Center(
                  child: Container(
                    width: containerSize * 0.5,
                    height: containerSize * 0.5,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/placeholders/profilePicPlaceholder.jpeg'),
                        fit: BoxFit.cover,
                      ),
                      shape: const OvalBorder(),
                    ),
                  ),
                ),
              ),
              
              // Right section: Up icon centered in the remaining space
              Container(
                width: containerSize - (containerSize / dimensions['goldenRatio']!),
                height: containerSize / dimensions['goldenRatio']!,
                child: Center(
                  child: AppIcon(
                    icon: IconAsset.down,
                    size: IconSize.big,
                    color: ButtonColors.inactive,
                    filled: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

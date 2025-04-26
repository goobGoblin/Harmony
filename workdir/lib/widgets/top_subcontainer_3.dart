// lib/widgets/top_subcontainer_3.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:flutter_application_1/widgets/account_button.dart';
import 'package:flutter_application_1/widgets/top_subcontainer_base.dart';

enum ProfileDisplayMode {
  account,
  profile
}

class TopSubcontainer3 extends StatelessWidget {
  const TopSubcontainer3({
    Key? key,
    required this.containerSize,
    this.displayMode = ProfileDisplayMode.account,
    this.onProfileTap,
    this.destinationRoute = '/connectedApps',
    this.backgroundOpacity = 0.7,
  }) : super(key: key);

  final double containerSize;
  final ProfileDisplayMode displayMode;
  final VoidCallback? onProfileTap;
  final String destinationRoute;
  final double backgroundOpacity;

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
    
    // Calculate dimensions
    final double topSectionHeight = containerSize - (containerSize / dimensions['goldenRatio']!);
    final double bottomSectionHeight = containerSize / dimensions['goldenRatio']!;
    final double profileButtonSize = bottomSectionHeight * 0.8;
    
    return TopSubcontainerBase(
      containerSize: containerSize,
      backgroundImagePath: 'assets/images/backgrounds/topSubcontainer3BG.png',
      backgroundOpacity: backgroundOpacity,
      child: Stack(
        children: [
          // Content layout
          Column(
            children: [
              // Top section with centered text
              SizedBox(
                height: topSectionHeight,
                width: containerSize,
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
              
              // Bottom section with icon
              SizedBox(
                height: bottomSectionHeight,
                width: containerSize,
                child: Row(
                  children: [
                    // Left section (profile button will be positioned over this)
                    SizedBox(
                      width: bottomSectionHeight,
                      height: bottomSectionHeight,
                    ),
                    
                    // Right section with down icon
                    Expanded(
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
          ),
          
          // Account button positioned precisely
          Positioned(
            left: bottomSectionHeight / 2 - profileButtonSize / 2,
            bottom: bottomSectionHeight / 2 - profileButtonSize / 2,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: onProfileTap ?? () {
                  Navigator.pushNamed(context, destinationRoute);
                },
                child: AccountButton(
                  size: profileButtonSize,
                  destination: destinationRoute,
                  imagePath: 'assets/images/placeholders/profilePicPlaceholder.jpeg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

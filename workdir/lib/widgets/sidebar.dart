import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:flutter_application_1/theme/app_colors.dart';

class Sidebar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  
  const Sidebar({
    Key? key,
    this.selectedIndex = 0,
    required this.onItemSelected,
  }) : super(key: key);
  
  @override
  State createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;
    
    // Get dimensions using the helper method
    final dimensions = AppDimensions.getScreenBasedDimensions(screenSize);
    
    // Calculate sidebar dimensions
    final sidebarWidth = dimensions['sbWidth']!;
    final sidebarHeight = dimensions['sbHeight']!;
    final sidebarVertSpacing = dimensions['sbWidth']! / dimensions['goldenRatio']!;
    return Column(
      children: [
        Container(
          width: sidebarWidth,
          height: sidebarHeight,
          child: Stack(
            children: [
              // Background container with rounded corners
              Container(
                width: sidebarWidth,
                height: sidebarHeight,
                decoration: ShapeDecoration(
                  color: AppColors.primary.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // Center the column of icons in the container
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNavItem(0, IconAsset.home),
                    SizedBox(height: sidebarVertSpacing),
                    _buildNavItem(1, IconAsset.save),
                    SizedBox(height: sidebarVertSpacing),
                    _buildNavItem(2, IconAsset.search),
                    SizedBox(height: sidebarVertSpacing),
                    _buildNavItem(3, IconAsset.library),
                    SizedBox(height: sidebarVertSpacing),
                    _buildNavItem(4, IconAsset.user),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildNavItem(int index, IconAsset iconAsset) {
    final bool isSelected = widget.selectedIndex == index;
    
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;
    
    // Get dimensions using the helper method
    final dimensions = AppDimensions.getScreenBasedDimensions(screenSize);

    final sidebarWidth = dimensions['sbWidth']!;

    return GestureDetector(
      onTap: () => widget.onItemSelected(index),
      child: Container(
        width: sidebarWidth,
        height: sidebarWidth,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: AppIcon(
            icon: iconAsset,
            size: IconSize.big,
            color: isSelected ? ButtonColors.active : ButtonColors.inactive,
            filled: isSelected,
          ),
        ),
      ),
    );
  }
}

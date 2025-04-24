import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:flutter_application_1/theme/app_colors.dart'; // Added theme import

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
    return Column(
      children: [
        Container(
          width: 52,
          height: 326,
          child: Stack(
            children: [
              // Background container with rounded corners
              Positioned(
                left: 0,
                top: 0,
                child: Opacity(
                  opacity: 0.80,
                  child: Container(
                    width: 52,
                    height: 326,
                    decoration: ShapeDecoration(
                      color: AppColors.primary, // Using theme primary color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              // Icon column
              Positioned(
                left: 6,
                top: 4,
                child: Container(
                  width: 44.41,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNavItem(0, IconAsset.home),
                      const SizedBox(height: 29),
                      _buildNavItem(1, IconAsset.save),
                      const SizedBox(height: 29),
                      _buildNavItem(2, IconAsset.search),
                      const SizedBox(height: 29),
                      _buildNavItem(3, IconAsset.library),
                      const SizedBox(height: 29),
                      _buildNavItem(4, IconAsset.user),
                    ],
                  ),
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
    
    return GestureDetector(
      onTap: () => widget.onItemSelected(index),
      child: Container(
        width: 40.41,
        height: 40.41,
        decoration: BoxDecoration(
          color: Colors.transparent, // No background color
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: AppIcon(
            icon: iconAsset,
            size: IconSize.big,
            color: isSelected ? ButtonColors.active : ButtonColors.inactive, // Using theme button colors
            filled: isSelected, // Use filled variant for selected icons
          ),
        ),
      ),
    );
  }
}

// lib/widgets/list_header_buttons.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:flutter_application_1/theme/app_colors.dart';

class ListHeaderButtons extends StatefulWidget {
  final VoidCallback? onPlayPressed;
  final VoidCallback? onShufflePressed;
  final VoidCallback? onMorePressed;
  final VoidCallback? onBackPressed;
  final VoidCallback? onTagsPressed;
  final VoidCallback? onGenresPressed;
  final double containerWidth;

  const ListHeaderButtons({
    Key? key,
    this.onPlayPressed,
    this.onShufflePressed,
    this.onMorePressed,
    this.onBackPressed,
    this.onTagsPressed,
    this.onGenresPressed,
    required this.containerWidth,
  }) : super(key: key);

  @override
  State<ListHeaderButtons> createState() => _ListHeaderButtonsState();
}

class _ListHeaderButtonsState extends State<ListHeaderButtons> {
  // Track the play/pause state
  bool isPlaying = false;

  // Toggle play state
  void _togglePlayState() {
    setState(() {
      isPlaying = !isPlaying;
    });
    
    // Call the callback if provided
    if (widget.onPlayPressed != null) {
      widget.onPlayPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: widget.containerWidth, 
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side buttons - back, tags, genres
          Row(
            children: [
              _buildHeaderButton(
                IconAsset.left,
                widget.onBackPressed, 
                ButtonColors.inactive,
                false,
              ),
              _buildHeaderButton(
                IconAsset.save,
                widget.onTagsPressed, 
                ButtonColors.inactive,
                false,
              ),
              _buildHeaderButton(
                IconAsset.genres,
                widget.onGenresPressed, 
                ButtonColors.inactive,
                false,
              ),
            ],
          ),
          
          // Right side buttons - more, shuffle, play
          Row(
            children: [
              _buildHeaderButton(
                IconAsset.more,
                widget.onMorePressed, 
                ButtonColors.inactive,
                false,
              ),
              _buildHeaderButton(
                IconAsset.shuffle,
                widget.onShufflePressed, 
                ButtonColors.inactive,
                false,
              ),
              _buildHeaderButton(
                isPlaying ? IconAsset.pauseSimple : IconAsset.playSimple, 
                _togglePlayState,
                ButtonColors.active,
                false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Creates a standard header button with the specified icon
  Widget _buildHeaderButton(
    IconAsset iconAsset, 
    VoidCallback? onPressed, 
    Color color,
    bool filled,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: AppIcon(
            icon: iconAsset,
            size: IconSize.big,
            color: color,
            filled: filled,
          ),
        ),
      ),
    );
  }
}

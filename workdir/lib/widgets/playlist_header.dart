// lib/widgets/playlist_header.dart
import 'package:flutter/material.dart';
import '../pages/dependencies.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:flutter_application_1/theme/app_colors.dart';

class PlaylistHeader extends StatefulWidget {
  final String title;
  final int trackCount;
  final Duration playlistDuration;
  final String artist;
  final bool initialIsPrivate; // Changed from isPrivate to initialIsPrivate
  final String? description;

  // Add callback functions for the buttons
  final VoidCallback? onPlayPressed;
  final VoidCallback? onShufflePressed;
  final VoidCallback? onMorePressed;
  final VoidCallback? onBackPressed;
  final VoidCallback? onTagsPressed;
  final VoidCallback? onGenresPressed;
  final ValueChanged<bool>? onPrivacyChanged; // Changed callback type

  const PlaylistHeader({
    Key? key,
    required this.title,
    required this.trackCount,
    required this.playlistDuration,
    required this.artist,
    this.initialIsPrivate = false, // Changed parameter name
    this.description,
    this.onPlayPressed,
    this.onShufflePressed,
    this.onMorePressed,
    this.onBackPressed,
    this.onTagsPressed,
    this.onGenresPressed,
    this.onPrivacyChanged, // Changed parameter
  }) : super(key: key);

  @override
  State<PlaylistHeader> createState() => _PlaylistHeaderState();
}

class _PlaylistHeaderState extends State<PlaylistHeader> {
  late bool _isPrivate;

  @override
  void initState() {
    super.initState();
    _isPrivate = widget.initialIsPrivate;
  }

  void _togglePrivacy() {
    setState(() {
      _isPrivate = !_isPrivate;
      // Notify parent widget if callback is provided
      if (widget.onPrivacyChanged != null) {
        widget.onPrivacyChanged!(_isPrivate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final dimensions = AppDimensions.getScreenBasedDimensions(screenSize);
    
    final topContainerWidth = dimensions['topContainerWidth']!;
    
    return Container(
      width: topContainerWidth,
      color: AppColors.primary,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top section with album art, title, track count, duration, and buttons
          Container(
            height: 100, // Fixed height for the top section
            width: topContainerWidth,
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              clipBehavior: Clip.none, // Allow elements to overflow the stack
              children: [
                // Left section with album art
                Positioned(
                  left: 0,
                  top: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/placeholders/profilePicPlaceholder.jpeg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Right section with title, track count, duration
                Positioned(
                  left: 90, 
                  top: 0,
                  right: 40, // Leave space for the privacy button
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        widget.title,
                        style: AppFontStyles.title.copyWith(color: AppColors.text),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                      // Track count and duration
                      Row(
                        children: [
                          Text(
                            '${widget.trackCount} Tracks',
                            style: AppFontStyles.description.copyWith(
                              color: AppColors.secondary,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            _formatDuration(widget.playlistDuration),
                            style: AppFontStyles.description.copyWith(
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      // Account button with artist name
                      Row(
                        children: [
                          AccountButton(
                            size: 24.0,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'By ${widget.artist}',
                            style: AppFontStyles.description.copyWith(
                              color: AppColors.text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Privacy button in top-right corner - using the helper function with the togglePrivacy callback
                Positioned(
                  right: 0,
                  top: 0,
                  child: _buildPrivacyButton(
                    isPrivate: _isPrivate,
                    onTogglePrivacy: _togglePrivacy,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ),
          
          // Description section - only show if description is provided
          if (widget.description != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
              child: Text(
                widget.description!,
                style: AppFontStyles.description.copyWith(
                  color: AppColors.text,
                ),
              ),
            ),
          
          // Bottom section - using the ListHeaderButtons widget
          ListHeaderButtons(
            containerWidth: topContainerWidth,
            onPlayPressed: widget.onPlayPressed,
            onShufflePressed: widget.onShufflePressed,
            onMorePressed: widget.onMorePressed,
            onBackPressed: widget.onBackPressed,
            onTagsPressed: widget.onTagsPressed,
            onGenresPressed: widget.onGenresPressed,
          ),
        ],
      ),
    );
  }
  
  // Helper function for privacy button
  Widget _buildPrivacyButton({
    required bool isPrivate, 
    VoidCallback? onTogglePrivacy,
    Color color = AppColors.text,
  }) {
    return GestureDetector(
      onTap: onTogglePrivacy,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: AppIcon(
            icon: isPrivate ? IconAsset.private : IconAsset.public,
            size: IconSize.big,
            color: color,
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}

// lib/widgets/service_connection_button.dart

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum MusicService {
  spotify,
  apple,
  youtube,
  soundcloud,
  lastfm,
}

class ServiceConnectionButton extends StatelessWidget {
  final MusicService service;
  final bool isConnected;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const ServiceConnectionButton({
    Key? key,
    required this.service,
    this.isConnected = false,
    required this.onPressed,
    this.width = 200.0,
    this.height = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10.0),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(_getButtonImagePath()),
                fit: BoxFit.cover,
              ),
            ),
            child: isConnected
                ? Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 24.0,
                      ),
                    ),
                  )
                : Container(),
          ),
        ),
      ),
    );
  }

  String _getButtonImagePath() {
    switch (service) {
      case MusicService.spotify:
        return 'assets/images/buttons/spotifyButton.png';
      case MusicService.apple:
        return 'assets/images/buttons/appleButton.png';
      case MusicService.youtube:
        return 'assets/images/buttons/youtubeButton.png';
      case MusicService.soundcloud:
        return 'assets/images/buttons/soundcloudButton.png';
      case MusicService.lastfm:
        return 'assets/images/buttons/lastfmButton.png';
    }
  }

  Color _getServiceColor() {
    switch (service) {
      case MusicService.spotify:
        return StreamingServiceColors.spotify;
      case MusicService.apple:
        return StreamingServiceColors.appleMusic;
      case MusicService.youtube:
        return StreamingServiceColors.youtube;
      case MusicService.soundcloud:
        return StreamingServiceColors.soundcloud;
      case MusicService.lastfm:
        return StreamingServiceColors.lastFM;
    }
  }
}

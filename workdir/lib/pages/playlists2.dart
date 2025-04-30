// lib/pages/playlists2.dart
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'dependencies.dart';
import '../widgets/playlist_header.dart';

// Convert to StatefulWidget to manage the privacy state
class Playlists2 extends StatefulWidget {
  const Playlists2({Key? key}) : super(key: key);

  @override
  State<Playlists2> createState() => _Playlists2State();
}

class _Playlists2State extends State<Playlists2> {
  // Add state variable for privacy
  bool _playlistPrivacyState = false;
  
  @override
  Widget build(BuildContext context) {
    // Log when this screen is built
    developer.log('Playlists2Screen is being built', name: 'playlists2');
    
    final String playlistDescription = "cybernetic enhancements engaged. activating robot mode. mix of songs to keep you feelin cyberpunk. cyber-utopianism is alive";
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // PlaylistHeader with sample data
              PlaylistHeader(
                title: "Human Robot",
                trackCount: 36,
                playlistDuration: const Duration(hours: 3, minutes: 2, seconds: 56),
                artist: "i.e.",
                // Remove the isPrivate parameter
                initialIsPrivate: _playlistPrivacyState, // Use initialIsPrivate instead
                description: playlistDescription,
                onPrivacyChanged: (newValue) {
                  // Update state when privacy changes
                  setState(() {
                    _playlistPrivacyState = newValue;
                  });
                },
              ),
              
              // Placeholder for the rest of the content
              const SizedBox(height: 400),
              const Center(
                child: Text("Playlist tracks will be implemented next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

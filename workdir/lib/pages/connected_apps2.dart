import 'package:flutter/material.dart';
import 'dependencies.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'dart:ui' as ui;
import 'package:flutter_application_1/widgets/widgets.dart'; 
import 'package:flutter_application_1/constants/constants.dart';
import '../widgets/service_connection_button.dart'; // Import the service connection button

class ConnectedApps2 extends StatefulWidget {
  const ConnectedApps2({super.key});

  @override
  _ConnectedApps2State createState() => _ConnectedApps2State();
}

class _ConnectedApps2State extends State<ConnectedApps2> {
  // Index for sidebar selection
  int _selectedIndex = 0; // Start with home selected (index 0)

  // Helper method to create consistently styled checkbox list tiles

	// Helper method to create consistently styled checkbox list tiles
	Widget _buildCheckboxListTile(String title, bool value, Function(bool?) onChanged) {
		return Padding(
			padding: const EdgeInsets.symmetric(vertical: 4.0), // <-- Add vertical space here
			child: CheckboxListTile(
				title: Text(
					title,
					style: AppFontStyles.entrySubtitle.copyWith(
						color: AppColors.text,
					),
				),
				value: value,
				onChanged: onChanged,
				activeColor: StreamingServiceColors.spotify,
				checkColor: AppColors.primary,
				tileColor: AppColors.secondary.withOpacity(0.1),
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(3),
				),
				contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
				dense: true,
			),
		);
	}

  // Check if a service is connected
  bool _isServiceConnected(String serviceName) {
    try {
      if (globals.userDoc["Linked Accounts"][serviceName] != null) {
        var status = globals.userDoc["Linked Accounts"][serviceName];
        if (status is bool) {
          return status;
        } else if (status is List && status.isNotEmpty) {
          return status[0];
        }
      }
    } catch (e) {
      log("Error checking connection status: $e");
    }
    return false;
  }

  // Handle Spotify connection
  void _handleSpotifyConnect() async {
    Map<String, bool> options = {
      'Playlists': true,
      'Liked Songs': true,
      'Recently Played': true,
      'Top Tracks': true,
      'Top Artists': true,
      'Followed Artists': true,
      'Followed Users': true,
      'Albums': true,
      'Saved Podcasts': true,
    };

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primary,
          title: Text(
            'Import Options',
            style: AppFontStyles.title.copyWith(
              color: AppColors.text,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            height: 300,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    _buildCheckboxListTile(
                      "Playlists",
                      options['Playlists']!,
                      (value) {
                        setState(() {
                          options['Playlists'] = value!;
                        });
                      },
                    ),
                    _buildCheckboxListTile(
                      "Liked Songs",
                      options['Liked Songs']!,
                      (value) {
                        setState(() {
                          options['Liked Songs'] = value!;
                        });
                      },
                    ),
                    _buildCheckboxListTile(
                      "Recently Played",
                      options['Recently Played']!,
                      (value) {
                        setState(() {
                          options['Recently Played'] = value!;
                        });
                      },
                    ),
                    _buildCheckboxListTile(
                      "Top Tracks",
                      options['Top Tracks']!,
                      (value) {
                        setState(() {
                          options['Top Tracks'] = value!;
                        });
                      },
                    ),
                    _buildCheckboxListTile(
                      "Top Artists",
                      options['Top Artists']!,
                      (value) {
                        setState(() {
                          options['Top Artists'] = value!;
                        });
                      },
                    ),
                    _buildCheckboxListTile(
                      "Followed Artists",
                      options['Followed Artists']!,
                      (value) {
                        setState(() {
                          options['Followed Artists'] = value!;
                        });
                      },
                    ),
                    _buildCheckboxListTile(
                      "Followed Users",
                      options['Followed Users']!,
                      (value) {
                        setState(() {
                          options['Followed Users'] = value!;
                        });
                      },
                    ),
                    _buildCheckboxListTile(
                      "Saved Albums",
                      options['Albums']!,
                      (value) {
                        setState(() {
                          options['Albums'] = value!;
                        });
                      },
                    ),
                    _buildCheckboxListTile(
                      "Saved Podcasts",
                      options['Saved Podcasts']!,
                      (value) {
                        setState(() {
                          options['Saved Podcasts'] = value!;
                        });
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.text,
              ),
              child: Text(
                "Cancel",
                style: AppFontStyles.entryTitle,
              ),
            ),
            TextButton(
              onPressed: () {
                // Connect to Spotify with selected options
                spotifyConnection.connect(
                  FirebaseAuth.instance.currentUser!.uid,
                  options,
                );
                
                setState(() {
                  // Refresh UI to show connection status
                });
                
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: StreamingServiceColors.spotify,
                backgroundColor: AppColors.secondary.withOpacity(0.1),
              ),
              child: Text(
                "Connect",
                style: AppFontStyles.entryTitle,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;
    
    // Get dimensions using the helper method
    final dimensions = AppDimensions.getScreenBasedDimensions(screenSize);

    return Container(
      color: AppColors.background,
      // Ensure the UI does not cover system UI
      child: SafeArea(
        // Fullscreen container
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Stack(
            children: [
              // Top Container
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: dimensions['topContainerWidth']!,
                  height: dimensions['topContainerHeight']!,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/backgrounds/topContainerBG.png'),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ), 
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                      ),
                    child: Container(
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          // First subcontainer - aligned to the left
                          Positioned(
                            left: 0,
                            top: 0,
                            child: TopSubcontainer1(
                              containerSize: dimensions['gr_top1']!,
                            ), 
                          ),
                          
                          // Second subcontainer - right of the first
                          Positioned(
                            left: dimensions['gr_top1']!,
                            top: 0,
                            child: TopSubcontainer2(
                              containerSize: dimensions['gr_top2']!,
                            ),
                          ),
                          
                          // Third subcontainer - below the second
                          Positioned(
                            right: 0,
                            top: dimensions['gr_top2']!,
                            child: Material(
                              color: Colors.transparent,
                              elevation: 10,
                              child: TopSubcontainer3(
                                containerSize: dimensions['gr_top3']!,
                                displayMode: ProfileDisplayMode.account,
                              ),
                            ),
                          ),

                          // Fourth subcontainer - left of the third
                          Positioned(
                            left: dimensions['gr_top1']!,
                            bottom: 0,
                            child: TopSubcontainer4(
                              containerSize: dimensions['gr_top4']!,
                            ),
                          ),

                          // Fifth subcontainer - above the fourth
                          Positioned(
                            left: dimensions['gr_top1']!,
                            bottom: dimensions['gr_top4']!,
                            child: TopSubcontainer5(
                              containerSize: dimensions['gr_top4']!,
                              height: dimensions['gr_top5']!,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),  // End Top Container
              ),  // End align

              // Harmony Logo - Using IgnorePointer to allow clicks to pass through
              Positioned(
                left: 0,
                top: dimensions['logoY']!,
                child: IgnorePointer(  // This makes the logo ignore pointer events
                  child: SizedBox(
                    width: dimensions['logoWidth']!,
                    height: dimensions['logoHeight']!,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        // Right part of the logo (stretched) with offset
                        Positioned(
                          left: dimensions['logoNegX']!, 
                          top: 0,
                          bottom: 0,
                          child: Image.asset(
                            'assets/images/logos/inverseLogoRight.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),              

              Positioned(
                left: (dimensions['topContainerWidth']! - (dimensions['gr_top1']!)) - dimensions['logoX']!,
                top: dimensions['logoY']!,
                width: 100,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: dimensions['logoWidth']! / 96,
                    vertical: dimensions['logoHeight']! / 9,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Last.fm button - no offset
                      ServiceConnectionButton(
                        service: MusicService.lastfm,
                        isConnected: false,
                        onPressed: () {
                          print("Last.fm button pressed");
                        },
                        width: dimensions['logoHeight']! / 8,
                        height: dimensions['logoHeight']! / 8,
                      ),
                      SizedBox(height: dimensions['logoHeight']! / 512),
                      
                      // Apple Music button - small offset to the left
                      Padding(
                        padding: EdgeInsets.only(left: dimensions['logoWidth']! / 24),
                        child: ServiceConnectionButton(
                          service: MusicService.apple,
                          isConnected: false,
                          onPressed: () {
                            print("Apple Music button pressed");
                          },
                          width: dimensions['logoHeight']! / 8,
                          height: dimensions['logoHeight']! / 8,
                        ),
                      ),
                      SizedBox(height: dimensions['logoHeight']! / 512),
                      
                      // Spotify button - larger offset to the left
                      Padding(
                        padding: EdgeInsets.only(left: dimensions['logoWidth']! / 18),
                        child: ServiceConnectionButton(
                          service: MusicService.spotify,
                          isConnected: _isServiceConnected('Spotify'),
                          onPressed: () {
                            _handleSpotifyConnect();
                          },
                          width: dimensions['logoHeight']! / 8,
                          height: dimensions['logoHeight']! / 8,
                        ),
                      ),
                      SizedBox(height: dimensions['logoHeight']! / 512),

                      // SoundCloud button - small offset to the left
                      Padding(
                        padding: EdgeInsets.only(left: dimensions['logoWidth']! / 24),
                        child: ServiceConnectionButton(
                          service: MusicService.soundcloud,
                          isConnected: false,
                          onPressed: () {
                            print("SoundCloud button pressed");
                          },
                          width: dimensions['logoHeight']! / 8,
                          height: dimensions['logoHeight']! / 8,
                        ),
                      ),
                      SizedBox(height: dimensions['logoHeight']! / 512),
                      
                      // YouTube Music button - no offset
                      ServiceConnectionButton(
                        service: MusicService.youtube,
                        isConnected: false,
                        onPressed: () {
                          print("YouTube button pressed");
                        },
                        width: dimensions['logoHeight']! / 8,
                        height: dimensions['logoHeight']! / 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ), // End fullscreen container
      ),  // End SafeArea
    );
  }
  
  // Handle navigation based on selected index
  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Home screen
        print('Already on Home screen');
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        // Save screen navigation - let's try navigating to Connected Apps here
        print('Navigate to Connected Apps');
        Navigator.pushNamed(context, '/settings');
        break;
      case 2:
        // Search screen navigation
        print('Navigate to Search screen');
        break;
      case 3:
        // Library screen navigation
        print('Navigate to Library screen');
        break;
      case 4:
        // User Profile screen navigation
        print('Navigate to User Profile screen');
        break;
    }
  }
}

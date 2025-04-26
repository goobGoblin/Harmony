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
                          left: dimensions['logoNegX']! + dimensions['logoX']!, 
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
                left: dimensions['topContainerWidth']! - (dimensions['topContainerWidth']! / dimensions['goldenRatio']!),
                top: dimensions['logoY']!,
                width: 100,
                child: Container(
                  padding:  EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: dimensions['logoHeight']! / 7.5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Spotify button - no offset
                      ServiceConnectionButton(
                        service: MusicService.spotify,
                        isConnected: false,
                        onPressed: () {
                          print("Spotify button pressed");
                        },
                        width: 40.0,
                        height: 40.0,
                      ),
                      SizedBox(
                        height: dimensions['logoHeight']! / 16), 
                      
                      // Apple Music button - small offset to the left
                      Padding(
                        padding: EdgeInsets.only(left: dimensions['logoWidth']! / 24),
                        child: ServiceConnectionButton(
                          service: MusicService.apple,
                          isConnected: false,
                          onPressed: () {
                            print("Apple Music button pressed");
                          },
                          width: 40.0,
                          height: 40.0,
                        ),
                      ),
                      SizedBox(height: dimensions['logoHeight']! / 18),
                      
                      // YouTube Music button - larger offset to the left
                      Padding(
                        padding: EdgeInsets.only(left: dimensions['logoWidth']! / 18),
                        child: ServiceConnectionButton(
                          service: MusicService.youtube,
                          isConnected: false,
                          onPressed: () {
                            print("YouTube button pressed");
                          },
                          width: 40.0,
                          height: 40.0,
                        ),
                      ),
                      SizedBox(height: dimensions['logoHeight']! / 18),

                      // SoundCloud button - same offset as Apple Music
                      Padding(
                        padding: EdgeInsets.only(left: dimensions['logoWidth']! / 24),
                        child: ServiceConnectionButton(
                          service: MusicService.soundcloud,
                          isConnected: false,
                          onPressed: () {
                            print("SoundCloud button pressed");
                          },
                          width: 40.0,
                          height: 40.0,
                        ),
                      ),
                      SizedBox(height: dimensions['logoHeight']! / 16),
                      
                      // Last.fm button - no offset
                      ServiceConnectionButton(
                        service: MusicService.lastfm,
                        isConnected: false,
                        onPressed: () {
                          print("Last.fm button pressed");
                        },
                        width: 40.0,
                        height: 40.0,
                      ),
                    ],
                  ),
                ),
              ),

              // Add the sidebar to the main stack
              Positioned(
                left: dimensions['sbOffsetX']!,  
                top: dimensions['logoY']! + dimensions['sbOffsetY']!,
                child: Sidebar(
                  selectedIndex: _selectedIndex,
                  onItemSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                    _handleNavigation(context, index);
                  },
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

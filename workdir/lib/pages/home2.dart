import 'package:flutter/material.dart';
import 'dependencies.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'dart:ui' as ui;
import 'package:flutter_application_1/widgets/widgets.dart'; 
import 'package:flutter_application_1/constants/constants.dart'; 


class Home2Route extends StatefulWidget {
  const Home2Route({super.key});

  @override
  State<Home2Route> createState() => _Home2RouteState();
}

class _Home2RouteState extends State<Home2Route> {
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
                                                    // Test AccountButton (TEMPORARY)

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
                left: dimensions['logoX']!,
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
                          left: dimensions['stretchedLogoShift']!, 
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Image.asset(
                            'assets/images/logos/inverseLogoRight.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        // Left part of the logo (unstretched, stays in place)
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Image.asset(
                            'assets/images/logos/inverseLogoLeft.png',
                            height: dimensions['logoHeight']!,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),              

              // Add the sidebar to the main stack
              // Positioned(
                // left: dimensions['sbOffsetX']!,  
                // top: dimensions['logoY']! + dimensions['sbOffsetY']!,
                // child: Sidebar(
                //   selectedIndex: _selectedIndex,
                //   onItemSelected: (index) {
                //     setState(() {
                //       _selectedIndex = index;
                //     });
                //     _handleNavigation(context, index);
                //   },
                // ),
              // ),

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

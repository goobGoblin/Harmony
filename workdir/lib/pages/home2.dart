import 'package:flutter/material.dart';
import 'dependencies.dart';
import 'package:flutter_application_1/theme/app_colors.dart';
import 'dart:ui' as ui;
import 'package:flutter_application_1/widgets/widgets.dart'; // Import your widgets

const double goldenRatio = 1.618033988749895;
const double inverseGoldenRatio = 0.618033988749895;

class Home2Route extends StatefulWidget {  // Changed to StatefulWidget
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

    // Calculate the container dimensions with the golden ratio
    final topContainerWidth = screenSize.width;
    final topContainerHeight = screenSize.width / goldenRatio;
    
    // Define the sizes of the subcontainers according to the golden ratio
    // Largest subcontainer aligned to the the top left of the top container 
    final gr_top1 = screenSize.width / goldenRatio;
    // Subcontainer aligned to the top right of the top container
    final gr_top2 = gr_top1 / goldenRatio;
    // Subcontainer aligned to the bottom left of the top container 
    final gr_top3 = gr_top2 / goldenRatio;
    // Small subcontainer aligned near the bottom middle of the top container 
    final gr_top4 = gr_top3 / goldenRatio;
    // Smallest subcontainers aligned above the botttom middle small container
    final gr_top5 = gr_top4 / goldenRatio; 

    // Calculate the size of the harmony logo based on the screen size
    final logoWidth = screenSize.width * 1.3;
    final logoHeight = screenSize.height / goldenRatio;
    // Calculate the harmony logo position based on the golden ratio
    final logoX = screenSize.width * 0.1;
    final logoY = gr_top1 - (screenSize.height * 0.08);
    // Calculate how far the right side of the logo needs shifted to account for the stretch
    final stretchedLogoShift = screenSize.width * -0.04;
    
    return Container(
      color: AppColors.background,
      // Ensure the UI does not cover system UI
      child: SafeArea(
        // Fullscreen container
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          child: Stack(
            children: [
              // Top Container
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: topContainerWidth,
                  height: topContainerHeight,
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
                            child: Container(
                              width: gr_top1,
                              height: gr_top1,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                image: AssetImage('assets/images/backgrounds/topSubcontainer1BG.png'),
                                fit: BoxFit.cover,
                                opacity: 0.7,
                              ),
                            ),
                              child: Center(child: Text('1')),
                            ),
                          ),
                          
                          // Second subcontainer - right of the first
                          Positioned(
                            left: gr_top1,
                            top: 0,
                            child: Container(
                              width: gr_top2,
                              height: gr_top2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                image: AssetImage('assets/images/backgrounds/topSubcontainer2BG.png'),
                                fit: BoxFit.cover,
                                opacity: 0.7,
                              ),
                            ),
                              child: Center(child: Text('2')),
                            ),
                          ),
                          
                          // Third subcontainer - below the second
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: gr_top3,
                              height: gr_top3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                image: AssetImage('assets/images/backgrounds/topSubcontainer3BG.png'),
                                fit: BoxFit.cover,
                                opacity: 0.7,
                              ),
                            ),
                              child: Center(child: Text('3')),
                            ),
                          ),
                          
                          // Fourth subcontainer - left of the third
                          Positioned(
                            left: gr_top1,
                            bottom: 0,
                            child: Container(
                              width: gr_top4,
                              height: gr_top4,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                image: AssetImage('assets/images/backgrounds/topSubcontainer4BG.png'),
                                fit: BoxFit.cover,
                                opacity: 0.7,
                              ),
                            ),
                              child: Center(child: Text('4')),
                            ),
                          ),
                          
                          // Fifth subcontainer - above the fourth
                          Positioned(
                            left: gr_top1,
                            bottom: gr_top4,
                            child: Container(
                              width: gr_top4,  
                              height: gr_top5, 
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                image: AssetImage('assets/images/backgrounds/topSubcontainer4BG.png'),
                                fit: BoxFit.cover,
                                opacity: 0.7,
                              ),
                            ),
                              child: Center(child: Text('5')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),  // End Top Container
              ),  // End align
              
              // Harmony Logo - placed in the main Stack
              Positioned(
                left: logoX,
                top: logoY,
                child: Container(
                  width: logoWidth,
                  height: logoHeight,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      // Right part of the logo (stretched) with offset
                      Positioned(
                        left: stretchedLogoShift, 
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
                          height: logoHeight,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Add the sidebar to the main stack
              Positioned(
                left: 5,  // Adjust position as needed
                top: topContainerHeight + 20,  // Position below top container
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
        // Already on Home screen
        print('Already on Home screen');

        break;
      case 1:
        // Save screen navigation
        print('Navigate to Save screen');
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

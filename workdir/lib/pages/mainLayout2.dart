// lib/pages/mainLayout2.dart

import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../widgets/widgets.dart';
import 'dependencies.dart';

class MainLayout2 extends StatefulWidget {
  const MainLayout2({super.key, required this.child});
  final Widget child;
  
  @override
  _MainLayout2 createState() => _MainLayout2();
}

class _MainLayout2 extends State<MainLayout2> {
  int _selectedIndex = 0; // Track which sidebar item is selected
  
  @override
  void initState() {
    super.initState();
    // Schedule this for after the first build frame to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _selectedIndex = _getCurrentSidebarIndex(context);
        });
      }
    });
  }
  
  // Method to determine the current sidebar index based on the route
  int _getCurrentSidebarIndex(BuildContext context) {
    final String route = ModalRoute.of(context)?.settings.name ?? '/home';
    
    switch (route) {
      case '/home':
      case '/home2':
        return 0;
      case '/settings':
      case '/connectedApps':
      case '/preferences':
        return 1;
      // Add cases for search, library, etc.
      case '/playlists':
      case '/songs':
      case '/albums':
      case '/artists':
        return 3;
      case '/myAccount':
        return 4;
      default:
        return 0; // Default to home
    }
  }
  
  void _handleNavigation(BuildContext context, int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    // Handle navigation based on sidebar selection
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
      case 2:
        // Search screen
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/playlists');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/myAccount');
        break;
    }
  }
  
 @override
Widget build(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  final dimensions = AppDimensions.getScreenBasedDimensions(screenSize);
  

  print("SIDEBAR DEBUGGING:");
  print("Screen size: ${screenSize.width} x ${screenSize.height}");
  print("sbOffsetX: ${dimensions['sbOffsetX']}");
  print("logoY: ${dimensions['logoY']}");
  print("sbOffsetY: ${dimensions['sbOffsetY']}");
  print("sbY: ${dimensions['sbY']}");
  print("logoHeight: ${dimensions['logoHeight']}");
  print("logoWidth: ${dimensions['logoWidth']}");

  return Scaffold(
    body: Stack(
      children: [
        // Main content area first (at the bottom layer)
        widget.child,
        
        // Sidebar - correctly using Positioned inside Stack
        Positioned(
          left: dimensions['sbOffsetX']!,  
          top: dimensions['sbY']!,
          child: Material(
            elevation: 8, // Add elevation to ensure it appears on top
            color: Colors.transparent,
            child: Sidebar(
              selectedIndex: _selectedIndex,
              onItemSelected: (index) => _handleNavigation(context, index),
            ),
          ),
        ),
        
        // Bottom player
        Align(
          alignment: Alignment.bottomCenter, 
          child: globals.bottomPlayer
        ),
      ],
    ),
  );
}}

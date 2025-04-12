

library;
import 'dependencies.dart';

class Globals {
  dynamic currentlyPlaying = {};
  Map<String, dynamic> currentPlaylist = {};
  List<dynamic>? currentTracks = [];
  int currentIndex = 0;
  bool isPlaying = false;
  late DocumentSnapshot<Map<String, dynamic>> userDoc;
}

// dynamic currentlyPlaying = {};
// Map<String, dynamic> currentPlaylist = {};
// List<dynamic>? currentTracks = [];
// int currentIndex = 0;
// bool isPlaying = false;

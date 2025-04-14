library;

import 'dependencies.dart';

class Globals with ChangeNotifier {
  dynamic currentlyPlaying = {};
  Map<String, dynamic> currentPlaylist = {};
  List<dynamic>? currentTracks = [];
  int currentIndex = 0;
  bool isPlaying = false;
  bool isPaused = false;
  late DocumentSnapshot<Map<String, dynamic>> userDoc;
  Widget bottomPlayer = BottomPlayer();

  void updateBottomPlayer() {
    bottomPlayer = BottomPlayer();
    notifyListeners();
  }
}

// dynamic currentlyPlaying = {};
// Map<String, dynamic> currentPlaylist = {};
// List<dynamic>? currentTracks = [];
// int currentIndex = 0;
// bool isPlaying = false;

library;

import 'dependencies.dart';

//TODO: implement ChangeNotifier for this class to update the UI when the data changes
class Globals {
  //with ChangeNotifier {
  dynamic currentlyPlaying = {};
  Map<String, dynamic> currentPlaylist = {};
  List<dynamic>? currentTracks = [];
  int currentIndex = 0;
  bool isPlaying = false;
  bool isPaused = false;
  late DocumentSnapshot<Map<String, dynamic>> userDoc;
  Widget bottomPlayer = BottomPlayer();

  // Globals() {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     getUserData().then((value) {
  //       userDoc = value;
  //       notifyListeners();
  //     });
  //   }
  // }

  void updateBottomPlayer() {
    bottomPlayer = BottomPlayer();
    //notifyListeners();
  }

  // // void updateUname(String newUName) {
  // //   userDoc["username"] = newUName;
  // //   notifyListeners();
  // // }

  // void updateCurrentTracks(List<dynamic> newTracks) {
  //   currentTracks = newTracks;
  //   notifyListeners();
  // }

  // void updateCurrentSong(thisSong) {
  //   currentlyPlaying = thisSong;
  //   notifyListeners();
  // }

  // void updateCurrentIndex(int newIndex) {
  //   currentIndex = newIndex;
  //   notifyListeners();
  // }

  // void updateIsPlaying(bool newIsPlaying) {
  //   isPlaying = newIsPlaying;
  //   notifyListeners();
  // }

  // void updateIsPaused(bool newIsPaused) {
  //   isPaused = newIsPaused;
  //   notifyListeners();
  // }

  // void updateCurrentPlaylist(Map<String, dynamic> newPlaylist) {
  //   currentPlaylist = newPlaylist;
  //   notifyListeners();
  // }

  // bool isLinked(String service) {
  //   if (userDoc["Linked Accounts"][service] == null) {
  //     log(userDoc["Linked Accounts"][service].toString());
  //     log(service.toString());
  //     return false;
  //   } else {
  //     return userDoc["Linked Accounts"][service][0];
  //   }
  // }

  // void updateUserDoc() async {
  //   userDoc = await getUserData();
  //   notifyListeners();
  // }
}

// dynamic currentlyPlaying = {};
// Map<String, dynamic> currentPlaylist = {};
// List<dynamic>? currentTracks = [];
// int currentIndex = 0;
// bool isPlaying = false;

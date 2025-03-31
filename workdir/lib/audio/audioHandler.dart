//TODO : Implement player for all platforms

import "dart:developer";

import "package:just_audio/just_audio.dart";
import "../apis/spotify_api.dart";

class MyAudioHandler {
  // e.g. just_audio

  final _player = AudioPlayer();

  // The most common callbacks:
  Future<void> play(
    String thisUri,
    String source,
    SpotifyAPI thisParser,
  ) async {
    try {
      switch (source) {
        case "Spotify":
          thisParser.play(thisUri);
          break;
        case "Soundcloud":
          await thisParser.sendRequest("POST", {
            "type": "play",
            "uri": thisUri,
          });
          break;
        //TODO: Implement Soundcloud
        case "Apple Music":
          await thisParser.sendRequest("POST", {
            "type": "play",
            "uri": thisUri,
          });
          break;
        //TODO: Implement Apple Music
        case "Youtube":
          await thisParser.sendRequest("POST", {
            "type": "play",
            "uri": thisUri,
          });
          break;
        //TODO: Implement Youtube

        case "LastFM":
          //TODO: Implement LastFM
          break;

        default:
          log("Invalid source");
      }
      //_player.play();
    } catch (e) {
      print(e);
    }
  }

  Future<void> pause() => _player.pause();
  Future<void> stop() => _player.stop();
  Future<void> seek(Duration position) => _player.seek(position);
  Future<void> skipToQueueItem(int i) => _player.seek(Duration.zero);
}

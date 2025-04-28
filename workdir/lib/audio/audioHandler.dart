//TODO : Implement player for all platforms

import "dart:developer";

import "package:just_audio/just_audio.dart";
import "../apis/spotify_api.dart";

class MyAudioHandler {
  // e.g. just_audio

  var _player = AudioPlayer();

  // The most common callbacks:
  Future<void> play(String thisUri, String source, var thisParser) async {
    try {
      switch (source) {
        case "Spotify":
          _player.pause();
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
        case "YouTube":
          var thisStream = await thisParser.play(thisUri);
          _player.setUrl(thisStream.toString());
          _player.play();
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

  Future<void> pause(var thisParser) async {
    try {
      thisParser.pause();
    } catch (e) {
      _player.pause();
    }
  }

  Future<void> resume(var thisParser) async {
    try {
      thisParser.resume();
    } catch (e) {
      _player.play();
      print(e);
    }
  }

  Future<void> stop() => _player.stop();
  Future<void> seek(Duration position) => _player.seek(position);
  Future<void> skipToQueueItem(int i) => _player.seek(Duration.zero);
}

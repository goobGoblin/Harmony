//TODO : Implement player for all platforms

import "package:just_audio/just_audio.dart";

class MyAudioHandler {
  // e.g. just_audio

  final _player = AudioPlayer();

  // The most common callbacks:
  Future<void> play() => _player.play();
  Future<void> pause() => _player.pause();
  Future<void> stop() => _player.stop();
  Future<void> seek(Duration position) => _player.seek(position);
  Future<void> skipToQueueItem(int i) => _player.seek(Duration.zero);
}

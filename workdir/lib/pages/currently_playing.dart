import 'dependencies.dart';

//create stateful widget to dynamically update songs page
class CurrentlyPlaying extends StatefulWidget {
  const CurrentlyPlaying({super.key});

  @override
  _CurrentlyPlaying createState() => _CurrentlyPlaying();
}

class _CurrentlyPlaying extends State<CurrentlyPlaying> {
  //_CurrentlyPlaying({super.key});
  String _imageSource = '';

  @override
  void initState() {
    super.initState();
    try {
      _imageSource = globals.currentlyPlaying['Images'][0]['url'];
    } catch (e) {
      _imageSource =
          'https://w7.pngwing.com/pngs/800/189/png-transparent-multimedia-music-play-player-song-video-multimedia-controls-solid-icon.png';
      log("Image not available: $e");
    }
  }

  void updateImage() {
    setState(() {
      try {
        _imageSource = globals.currentlyPlaying['Images'][0]['url'];
      } catch (e) {
        _imageSource =
            'https://w7.pngwing.com/pngs/800/189/png-transparent-multimedia-music-play-player-song-video-multimedia-controls-solid-icon.png';
        log("Image not available: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      //log(globals.currentlyPlaying['Images'][0]['url'].toString());
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: Text("Currently Playing"),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: NetworkImage(_imageSource)),
              Text(globals.currentlyPlaying['Name']),
              Text(globals.currentlyPlaying['Artist'][0]['name']),
              //TODO: Likely will be apart of the implementaion of the audio handler
              //But implement dynamic changing of globals.currentlyPlaying when a track is skipped
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.skip_previous),
                    onPressed: () {
                      setState(() {
                        if (globals.currentIndex > 0) {
                          globals.currentIndex--;
                        } else {
                          globals.currentIndex =
                              globals.currentTracks!.length - 1;
                        }
                        globals.currentlyPlaying =
                            globals.currentTracks![globals.currentIndex];

                        updateImage();

                        //pass in the source and api to play the song
                        audioHandler.play(
                          globals.currentlyPlaying["URI"],
                          globals.currentlyPlaying["LinkedService"][0],
                          globals.currentlyPlaying["LinkedService"][0] ==
                                  "Spotify"
                              ? spotifyConnection
                              : youtubeConnection,
                        );
                        globals.recentlyPlayed!.add(
                          globals.currentlyPlaying.data(),
                        );
                      });

                      globals.updateBottomPlayer();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: () {
                      setState(() {
                        globals.isPlaying = false;
                        audioHandler.pause(
                          globals.currentlyPlaying["LinkedService"][0] ==
                                  "Spotify"
                              ? spotifyConnection
                              : youtubeConnection,
                        );
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      setState(() {
                        globals.isPlaying = true;
                        audioHandler.resume(
                          globals.currentlyPlaying["LinkedService"][0] ==
                                  "Spotify"
                              ? spotifyConnection
                              : youtubeConnection,
                        );
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next),
                    onPressed: () {
                      //wrap arround
                      setState(() {
                        if (globals.currentIndex <
                            globals.currentTracks!.length - 1) {
                          globals.currentIndex++;
                        } else {
                          globals.currentIndex = 0;
                        }

                        globals.currentlyPlaying =
                            globals.currentTracks![globals.currentIndex];

                        updateImage();
                        //pass in the source and api to play the song
                        audioHandler.play(
                          globals.currentlyPlaying["URI"],
                          globals.currentlyPlaying["LinkedService"][0],
                          globals.currentlyPlaying["LinkedService"][0] ==
                                  "Spotify"
                              ? spotifyConnection
                              : youtubeConnection,
                        );
                        globals.recentlyPlayed!.add(
                          globals.currentlyPlaying.data(),
                        );
                      });

                      globals.updateBottomPlayer();
                    },
                  ),
                ],
              ), //thisConnection.getCurrentlyPlaying()),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   tooltip: 'Back',
        //   child: const Icon(Icons.arrow_back),
        // ),
      );
    } catch (e) {
      log("Error: $e");
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: Text("Currently Playing"),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
        body: Center(child: Text("Nothing is playing")),
      );
    }
  }
}

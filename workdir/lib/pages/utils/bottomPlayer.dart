import "../dependencies.dart";
import 'package:auto_scroll_text/auto_scroll_text.dart';

class BottomPlayer extends StatefulWidget {
  const BottomPlayer({super.key});

  @override
  _BottomPlayer createState() => _BottomPlayer();
}

class _BottomPlayer extends State<BottomPlayer> {
  Widget thisPlayer = Container();

  @override
  void initState() {
    super.initState();
  }

  // Widget showPlayer() {
  //   if (globals.currentlyPlaying['Name'] == null) {
  //     return Container();
  //   } else {
  //     return thisPlayer;
  //   }
  // }

  @override
  Widget build(BuildContext contex) {
    log("bottom player being built");

    if (!((globals.isPlaying || globals.isPaused) &&
        globals.bottomPlayerVisible)) {
      return Container();
    }

    thisPlayer = Container(
      height: 100,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/currentlyPlaying');
            },
            child: Image(
              image: NetworkImage(globals.currentlyPlaying['Images'][0]['url']),
            ),
          ),

          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: AutoScrollText(
                  delayBefore: Duration(milliseconds: 1000),
                  globals.currentlyPlaying['Name'],
                  style: TextStyle(color: Colors.white),
                  velocity: Velocity(pixelsPerSecond: Offset(25, 0)),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 5),
              SizedBox(
                width: 100,
                child: AutoScrollText(
                  delayBefore: Duration(milliseconds: 1000),
                  globals.currentlyPlaying['Artist'][0]['name'],
                  style: TextStyle(color: Colors.white),
                  velocity: Velocity(pixelsPerSecond: Offset(25, 0)),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Flexible(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: () {
                    //skip to previous song
                    if (globals.currentIndex > 0) {
                      globals.currentIndex--;
                    } else {
                      globals.currentIndex = globals.currentTracks!.length - 1;
                    }

                    globals.currentlyPlaying =
                        globals.currentTracks![globals.currentIndex];

                    audioHandler.play(
                      globals.currentlyPlaying["URI"],
                      globals.currentlyPlaying["LinkedService"][0],
                      spotifyConnection,
                    );
                    setState(() {});
                  },
                ),

                IconButton(
                  icon: Icon(
                    globals.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),

                  onPressed: () {
                    //play song
                    if (globals.isPlaying == true) {
                      audioHandler.pause(spotifyConnection);
                      setState(() {
                        globals.isPlaying = false;
                        globals.isPaused = true;
                      });
                      return;
                    }
                    if (globals.isPaused == true) {
                      audioHandler.resume(spotifyConnection);
                      setState(() {
                        globals.isPlaying = true;
                        globals.isPaused = false;
                      });
                      return;
                    }
                    audioHandler.play(
                      globals.currentlyPlaying["URI"],
                      globals.currentlyPlaying["LinkedService"][0],
                      spotifyConnection,
                    );
                    setState(() {
                      globals.isPlaying = true;
                      globals.isPaused = false;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: () {
                    //skip to next song
                    if (globals.currentIndex <
                        globals.currentTracks!.length - 1) {
                      globals.currentIndex++;
                    } else {
                      globals.currentIndex = 0;
                    }
                    globals.currentlyPlaying =
                        globals.currentTracks![globals.currentIndex];
                    audioHandler.play(
                      globals.currentlyPlaying["URI"],
                      globals.currentlyPlaying["LinkedService"][0],
                      spotifyConnection,
                    );
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return thisPlayer;
  }
}

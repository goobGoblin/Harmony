import "../dependencies.dart";

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
    if (!(globals.isPlaying || globals.isPaused)) {
      return Container();
    }

    thisPlayer = Container(
      height: 100,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            image: NetworkImage(globals.currentlyPlaying['Images'][0]['url']),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                globals.currentlyPlaying['Name'],
                style: TextStyle(color: Colors.white),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5),
              Text(
                globals.currentlyPlaying['Artist'][0]['name'],
                style: TextStyle(color: Colors.white),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Flexible(
            child: IconButton(
              icon: Icon(Icons.play_arrow),

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
          ),
        ],
      ),
    );

    return thisPlayer;
  }
}

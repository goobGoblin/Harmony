import '../dependencies.dart';
import '../pages.dart';
import 'connectedImages.dart';

List<Widget> createListOfSongs(
  List<dynamic>? collection,
  BuildContext context,
) {
  globals.currentTracks = collection;
  List<Widget> thisWidgets = [];
  for (var i = 0; i < collection!.length; i++) {
    try {
      //get document snapshot from reference {
      // log(collection[i].toString());
      var thisSong = collection[i].data();
      var newButton = ElevatedButton(
        onPressed: () {
          globals.currentlyPlaying = thisSong;
          globals.currentIndex = i;
          log(globals.currentlyPlaying.toString(), name: 'Currently Playing');
          audioHandler.play(
            thisSong["URI"],
            thisSong["LinkedService"][0],
            spotifyConnection,
          );
        },
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 12),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: const BorderSide(color: Colors.black),
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // so the button wraps content tightly
          children: getConnectedImages(thisSong),
        ), //Text(thisSong["Name"]),
      );
      //add the new button to the list
      thisWidgets.add(newButton);
    } catch (e) {
      log("Error: $e");
    }
  }
  return thisWidgets;
}

List<Widget> createListOfPlaylists(
  List<dynamic> thisList,
  BuildContext context,
) {
  List<Widget> thisWidgets = [];
  for (var i = 0; i < thisList.length; i++) {
    try {
      log(thisList[i]["URI"]);
      var newButton = ElevatedButton(
        onPressed: () {
          String temp = thisList[i]["Name"];
          globals.currentPlaylist = thisList[i]['Tracks'];
          Navigator.push(
            context,
            //create new songs page with name of playlist
            MaterialPageRoute(
              builder:
                  (context) =>
                      Songs(thisName: temp, tracks: thisList[i]['Tracks']),
            ),
          );
        },
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: const BorderSide(color: Colors.black),
            ),
          ),
        ),
        child: Text(thisList[i]['Name']),
      );
      //add the new button to the list
      thisWidgets.add(newButton);
    } catch (e) {
      log("error:$e");
    }
  }
  return thisWidgets;
}

import '../dependencies.dart';
import '../pages.dart';
import 'connectedImages.dart';
import 'menuItems.dart';

List<Widget> createListOfSongs(
  List<dynamic>? collection,
  BuildContext context,
) {
  globals.currentTracks = collection;

  List<StatefulWidget> thisWidgets = [];
  for (var i = 0; i < collection!.length; i++) {
    try {
      //get document snapshot from reference {
      // log(collection[i].toString());
      var thisSong = collection[i].data();
      //log("Current song $thisSong.toString()");
      var newButton = ElevatedButton(
        onPressed: () {
          globals.recentlyPlayed!.add(thisSong);
          globals.getRecentlyPlayed();
          globals.currentlyPlaying = thisSong;
          globals.currentIndex = i;
          globals.isPlaying = true;
          //log(globals.currentlyPlaying.toString(), name: 'Currently Playing');
          globals.updateBottomPlayer();
          audioHandler.play(
            thisSong["URI"],
            thisSong["LinkedService"][0],
            thisSong["LinkedService"][0] == "Spotify"
                ? spotifyConnection
                : youtubeConnection,
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
          mainAxisSize: MainAxisSize.min,
          //use getConnected images to dynamically add images based on the songs
          //linked services
          children: [
            ...getConnectedImages(thisSong),
            //Dropdown button to show more options
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: const Icon(
                  Icons.more_vert,
                  size: 32,
                  color: Colors.blueAccent,
                ),
                items: [
                  ...MenuItems.firstItems.map(
                    (item) => DropdownMenuItem<MenuItem>(
                      value: item,
                      child: MenuItems.buildItem(item),
                    ),
                  ),
                  const DropdownMenuItem<Divider>(
                    enabled: false,
                    child: Divider(),
                  ),
                  ...MenuItems.secondItems.map(
                    (item) => DropdownMenuItem<MenuItem>(
                      value: item,
                      child: MenuItems.buildItem(item),
                    ),
                  ),
                ],
                onChanged: (value) {
                  MenuItems.onChanged(context, value! as MenuItem);
                  globals.currentIndex = i;
                },
                dropdownStyleData: DropdownStyleData(
                  width: 160,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Theme.of(context).appBarTheme.backgroundColor,
                  ),
                  offset: const Offset(0, 8),
                ),
                menuItemStyleData: MenuItemStyleData(
                  customHeights: [
                    ...List<double>.filled(MenuItems.firstItems.length, 48),
                    8,
                    ...List<double>.filled(MenuItems.secondItems.length, 48),
                  ],
                  padding: const EdgeInsets.only(left: 16, right: 16),
                ),
              ),
            ),
          ],
        ),
      );
      //add the new button to the list
      thisWidgets.add(newButton);
    } catch (e) {
      log("Error in song list creation: $e");
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
      //log(thisList[i]["URI"]);
      var newButton = ElevatedButton(
        onPressed: () {
          String temp = thisList[i]["Name"];
          globals.currentPlaylist = thisList[i]['Tracks'];
          globals.userPlaylistIndex = i;
          Navigator.push(
            context,
            //create new songs page with name of playlist
            MaterialPageRoute(
              builder:
                  (context) => MainLayout(
                    child: Songs(thisName: temp, tracks: thisList[i]['Tracks']),
                  ),
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

List<Widget> createListOfAlbums(List<dynamic> thisList, BuildContext context) {
  List<Widget> thisWidgets = [];
  for (var i = 0; i < thisList.length; i++) {
    try {
      //log("creating this list : ${thisList[i]["Name"]}");
      var newButton = ElevatedButton(
        onPressed: () {
          String temp = thisList[i]["Name"];
          globals.currentPlaylist = thisList[i]['Tracks'];
          Navigator.push(
            context,
            //create new songs page with name of playlist
            MaterialPageRoute(
              builder:
                  (context) => MainLayout(
                    child: Songs(thisName: temp, tracks: thisList[i]['Tracks']),
                  ),
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

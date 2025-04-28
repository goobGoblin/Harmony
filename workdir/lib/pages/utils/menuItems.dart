import '../dependencies.dart';

class MenuItem {
  const MenuItem({required this.text, required this.icon});

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [addToPlaylist, share, settings];
  static const List<MenuItem> secondItems = [removeFromPlaylist];

  static const addToPlaylist = MenuItem(
    text: 'Add to playlist(s)',
    icon: Icons.playlist_add,
  );
  static const share = MenuItem(text: 'Share', icon: Icons.share);
  static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
  static const removeFromPlaylist = MenuItem(
    text: 'Remove from playlist',
    icon: Icons.playlist_remove,
  );

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Text(item.text, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  static void showAddToPlaylistDialog(
    BuildContext context,
    currentlyPlaying,
  ) async {
    try {
      // Fetch playlists from Firebase (or any other source)
      var userDoc =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(globals.userDoc.id)
              .get();

      var playlists = userDoc.data()?['playlists'] ?? [];
      // Create a list of playlist names or any data to show
      List<String> playlistNames = [];

      for (var playlist in playlists) {
        if (playlist == null) continue;
        playlistNames.add(playlist['Name']);
      }

      log('Playlists: $playlistNames');

      // Show the dialog with a list of playlists
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Select Playlist'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  playlistNames.map((playlistName) {
                    return ListTile(
                      title: Text(playlistName),
                      onTap: () {
                        // Handle adding track to the selected playlist
                        _addToPlaylist(playlistName);
                        Navigator.pop(context); // Close dialog
                      },
                    );
                  }).toList(),
            ),
          );
        },
      );
    } catch (e) {
      log('Error fetching playlists: $e');
    }
  }

  static void onChanged(BuildContext context, MenuItem item) async {
    switch (item) {
      case MenuItems.addToPlaylist:
        //Do something
        showAddToPlaylistDialog(context, globals.currentlyPlaying);
        break;
      case MenuItems.settings:
        //Do something
        break;
      case MenuItems.share:
        //Do something
        break;
      case MenuItems.removeFromPlaylist:
        //Do something

        try {
          globals.currentPlaylist['Tracklist'].removeAt(globals.currentIndex);

          globals
              .currentPlaylist['Number of Tracks']--; //Remove the current track from the playlist
          //update the playlist in the database

          log("Globals.currentPlaylist: ${globals.currentPlaylist}");
          var thisRef =
              await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(globals.userDoc.id)
                  .get();

          // thisRef.data()?

          var data = thisRef.data();

          data?["playlists"][globals.userPlaylistIndex]["Tracks"] =
              globals.currentPlaylist;

          // thisRef.data()?["playlists"][globals
          //         .userPlaylistIndex]["Tracks"]["Number of Tracks"] =
          //     globals.currentPlaylist['Number of Tracks'];
          log(
            "thisRef: ${data?["playlists"][globals.userPlaylistIndex]["Tracks"]}",
          );
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(globals.userDoc.id)
              .update({"playlists": data?["playlists"]});
        } catch (e) {
          log("Error in removing track from playlist: $e");
        }
        break;
    }
  }

  static void _addToPlaylist(String playlistName) {}
}

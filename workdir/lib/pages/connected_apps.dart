import 'dependencies.dart';

class ConnectedApps extends StatefulWidget {
  const ConnectedApps({super.key});

  @override
  _ConnectedApps createState() => _ConnectedApps();
}

class _ConnectedApps extends State<ConnectedApps> {
  bool? isShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Connected Apps"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              //TODO: add popup to ask user what they want to import
              onPressed: () async {
                //This is not implemented correctly
                PopupMenuButton(
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          child: StatefulBuilder(
                            builder: (_context, _setState) {
                              return CheckboxListTile(
                                activeColor: Colors.blue,
                                value: isShown,
                                onChanged:
                                    (value) => _setState(() => isShown = value),
                                title: Text("Show Password"),
                              );
                            },
                          ),
                        ),
                      ],
                );
                spotifyConnection.connect(
                  FirebaseAuth.instance.currentUser!.uid,
                );
              },
              //TODO: Add visuals for if an account is connected or not
              child: const Text("Spotify"),
            ),
            ElevatedButton(
              onPressed: () async {
                spotifyConnection.connect(
                  FirebaseAuth.instance.currentUser!.uid,
                );
              },
              //TODO: Add visuals for if an account is connected or not
              child: const Text("Youtube"),
            ),
            ElevatedButton(
              onPressed: () async {
                spotifyConnection.connect(
                  FirebaseAuth.instance.currentUser!.uid,
                );
              },
              //TODO: Add visuals for if an account is connected or not
              child: const Text("Soundcloud"),
            ), //thisConnection.getConnectedApps()),

            ElevatedButton(
              onPressed: () async {
                // Prompt user to enter Last.fm credentials
                final username = "user_lastfm"; // Replace with user input
                final password =
                    "pass_lastfm"; // Replace with secure input handling

                await lastFMConnection.connect(username, password);
              },
              child: const Text("Last.fm"),
            ),
          ],
        ),
      ),
    );
  }
}

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
              onPressed: () async {
                Map<String, bool> options = {
                  'Playlists': true,
                  'Liked Songs': true,
                  'Recently Played': true,
                  'Top Tracks': true,
                  'Top Artists': true,
                  'Followed Artists': true,
                  'Followed Users': true,
                  'Albums': true,
                  'Saved Podcasts': true,
                };

                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Import Options'),
                      content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //add checkboxes for each option
                              //update the options map when the checkbox is changed
                              CheckboxListTile(
                                title: Text("Playlists"),
                                value: options['Playlists'],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options['Playlists'] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Liked Songs"),
                                value: options["Liked Songs"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Liked Songs"] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Recently Played"),
                                value: options["Recently Played"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Recently Played"] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Top Tracks"),
                                value: options["Top Tracks"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Top Tracks"] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Top Artists"),
                                value: options["Top Artists"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Top Artists"] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Followed Artists"),
                                value: options["Followed Artists"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Followed Artists"] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Followed Users"),
                                value: options["Followed Users"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Followed Users"] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Albums"),
                                value: options["Albums"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Albums"] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Saved Podcasts"),
                                value: options["Saved Podcasts"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Saved Podcasts"] = value!;
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              //isShown = tempIsShown;
                              // You can save or act on the other options here too
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );

                // Proceed with logic using the selected options
                log('Selected options: $options');

                spotifyConnection.connect(
                  FirebaseAuth.instance.currentUser!.uid,
                  options,
                  // You can pass these options in your connect logic if needed
                );
              },
              //TODO: Add visuals for if an account is connected or not
              child: const Text("Spotify"),
            ),
            ElevatedButton(
              onPressed: () async {
                Map<String, bool> options = {
                  'Playlists': true,
                  'Liked Songs': true,
                  'Recently Played': true,
                  'Top Tracks': true,
                  'Top Artists': true,
                  'Followed Artists': true,
                  'Followed Users': true,
                  'Albums': true,
                  'Saved Podcasts': true,
                };

                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Import Options'),
                      content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //add checkboxes for each option
                              //update the options map when the checkbox is changed
                              CheckboxListTile(
                                title: Text("Playlists"),
                                value: options['Playlists'],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options['Playlists'] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Liked Songs"),
                                value: options["Liked Songs"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Liked Songs"] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Recently Played"),
                                value: options["Recently Played"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Recently Played"] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Top Tracks"),
                                value: options["Top Tracks"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Top Tracks"] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Top Artists"),
                                value: options["Top Artists"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Top Artists"] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Followed Artists"),
                                value: options["Followed Artists"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Followed Artists"] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Followed Users"),
                                value: options["Followed Users"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Followed Users"] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Albums"),
                                value: options["Albums"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Albums"] = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("Saved Podcasts"),
                                value: options["Saved Podcasts"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options["Saved Podcasts"] = value!;
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              //isShown = tempIsShown;
                              // You can save or act on the other options here too
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );

                // Proceed with logic using the selected options
                log('Selected options: $options');

                youtubeConnection.connect(
                  FirebaseAuth.instance.currentUser!.uid,
                  "reconsproject",
                  options,
                  // You can pass these options in your connect logic if needed
                );
              },
              //TODO: Add visuals for if an account is connected or not
              child: const Text("Youtube"),
            ),
            ElevatedButton(
              onPressed: () async {
                await soundcloudConnection.connect();
              },
              child: const Text("SoundCloud"),
            ),

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
